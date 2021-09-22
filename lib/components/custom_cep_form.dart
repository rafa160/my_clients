import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:my_clients_by_anduril/bloc/cep_bloc.dart';
import 'package:my_clients_by_anduril/components/custom_animated_container.dart';
import 'package:my_clients_by_anduril/models/address_model.dart';
import 'package:my_clients_by_anduril/screens/prospect_clients/new_client/new_client_module.dart';
import 'package:my_clients_by_anduril/styles/style.dart';

class CustomCepForm extends StatefulWidget {

  final FormFieldSetter<AddressModel> onSaved;

  const CustomCepForm({Key key, this.onSaved}) : super(key: key);

  @override
  _CustomCepFormState createState() => _CustomCepFormState();
}

class _CustomCepFormState extends State<CustomCepForm> {


  FormFieldSetter<AddressModel> get onSaved => widget.onSaved;
  var cepBloc = NewClientsModule.to.getBloc<CepBloc>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CepBlocState>(
        initialData: CepBlocState(
          cepFieldState: CepFieldState.INITIALIZING,
        ),
        stream: cepBloc.outCep,
        builder: (context, snapshot) {
          if(snapshot.data.cepFieldState == CepFieldState.INITIALIZING)
            return Container();

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 4,
                      child: FormBuilderTextField(
                        initialValue: snapshot.data.cep,
                        keyboardType: TextInputType.number,
                        name: 'address',
                        style: titleForms,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CepInputFormatter(),
                        ],
                        onSaved: (c){
                          onSaved(snapshot.data.addressModel);
                        },
                        validator: (c){
                          switch(snapshot.data.cepFieldState) {
                            case CepFieldState.INITIALIZING:
                            case CepFieldState.INCOMPLETE:
                              return 'Campo Obrigatório';
                            case CepFieldState.INVALID:
                              return 'Campo inválido';
                            case CepFieldState.VALID:
                          }
                          return null;
                        },
                        onChanged: cepBloc.onChanged,
                        decoration: InputDecoration(
                          errorStyle: TextStyle(fontSize: 10, color: Colors.redAccent),
                          counterText: '',
                          hintStyle: titleForms,
                          contentPadding: EdgeInsets.all(8),
                          border: InputBorder.none,
                          focusedBorder: OutlineInputBorder(
                              gapPadding: 10,
                              borderSide: BorderSide(color: Colors.deepPurpleAccent),
                              borderRadius: BorderRadius.circular(6.0)),
                          enabledBorder: OutlineInputBorder(
                              gapPadding: 10,
                              borderSide: BorderSide(color: Colors.grey[300]),
                              borderRadius: BorderRadius.circular(6.0)),
                          errorBorder: OutlineInputBorder(
                              gapPadding: 10,
                              borderSide: BorderSide(color: Colors.red[100]),
                              borderRadius: BorderRadius.circular(6.0)),
                          disabledBorder: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              SizedBox(
                height: 10,
              ),
              Flexible(
                flex: 4,
                child: buildInformation(snapshot.data),
              ),
            ],
          );
        }
    );
  }

  Widget buildInformation(CepBlocState blocState) {
    switch (blocState.cepFieldState) {
      case CepFieldState.INITIALIZING:
      case CepFieldState.INCOMPLETE:
        return Container();
      case CepFieldState.INVALID:
        return CustomAnimatedContainer(
          verticalOffset: 10,
          horizontalOffset: 120,
          milliseconds: 1200,
          position: 9,
          widget: Container(
            height: 70,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(8),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color:Colors.red.withAlpha(100),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text('CEP inválido', style: buttonColors,),
          ),
        );
      case CepFieldState.VALID:
        final _address = blocState.addressModel;
        return CustomAnimatedContainer(
          verticalOffset: 10,
          horizontalOffset: 120,
          milliseconds: 800,
          position: 9,
          widget: Container(
            height: 70,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color:Colors.green[200],
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Text(
              'Localização: ${_address.district} - ${_address.city} - ${_address.unit}',
              style: buttonColors,
            ),
          ),
        );
    }
    return Container();
  }
}
