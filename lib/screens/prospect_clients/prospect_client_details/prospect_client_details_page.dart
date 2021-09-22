import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:my_clients_by_anduril/bloc/client_bloc.dart';
import 'package:my_clients_by_anduril/components/custom_animated_container.dart';
import 'package:my_clients_by_anduril/components/custom_appbar.dart';
import 'package:my_clients_by_anduril/components/custom_button.dart';
import 'package:my_clients_by_anduril/components/custom_color_circular_indicator.dart';
import 'package:my_clients_by_anduril/components/custom_date_form.dart';
import 'package:my_clients_by_anduril/components/custom_form_field.dart';
import 'package:my_clients_by_anduril/models/client_model.dart';
import 'package:my_clients_by_anduril/screens/prospect_clients/new_client/new_client_module.dart';
import 'package:my_clients_by_anduril/screens/prospect_clients/prospect_client_details/prospect_client_details_module.dart';
import 'package:my_clients_by_anduril/styles/style.dart';

class ProspectClientDetailsScreen extends StatefulWidget {

  final ClientModel clientModel;

  const ProspectClientDetailsScreen({Key key, this.clientModel}) : super(key: key);

  @override
  _ProspectClientDetailsScreenState createState() => _ProspectClientDetailsScreenState();
}

class _ProspectClientDetailsScreenState extends State<ProspectClientDetailsScreen> {

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  var clientBloc = ProspectClientDetailsModule.to.getBloc<ClientBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Detalhes',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                CustomAnimatedContainer(
                  milliseconds: 1000,
                  horizontalOffset: -50,
                  position: 2,
                  widget:Text(
                    'Empresa',
                    style: titleForms,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomAnimatedContainer(
                  milliseconds: 1000,
                  horizontalOffset: -50,
                  position: 1,
                  widget:CustomFormField(
                    text: 'company',
                    initialValue: widget.clientModel.company,
                    enabled: false,
                    action: TextInputAction.next,
                    type: TextInputType.name,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                    ]),
                    obscureText: false,
                    maxLines: 1,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                CustomAnimatedContainer(
                  milliseconds: 1000,
                  horizontalOffset: -50,
                  position: 2,
                  widget:Text(
                    'Nome do responsável',
                    style: titleForms,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomAnimatedContainer(
                  milliseconds: 1000,
                  horizontalOffset: -50,
                  position: 2,
                  widget:CustomFormField(
                    text: 'name',
                    initialValue: widget.clientModel.name,
                    enabled: false,
                    action: TextInputAction.next,
                    type: TextInputType.name,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                    ]),
                    obscureText: false,
                    maxLines: 1,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                CustomAnimatedContainer(
                  milliseconds: 1000,
                  horizontalOffset: -50,
                  position: 2,
                  widget:Text(
                    'Contato',
                    style: titleForms,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomAnimatedContainer(
                  milliseconds: 1000,
                  horizontalOffset: -50,
                  position: 3,
                  widget:CustomFormField(
                    text: 'phone',
                    initialValue: widget.clientModel.phone,
                    enabled: false,
                    action: TextInputAction.next,
                    type: TextInputType.name,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                    ]),
                    obscureText: false,
                    maxLines: 1,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                CustomAnimatedContainer(
                  milliseconds: 1000,
                  horizontalOffset: -50,
                  position: 2,
                  widget:Text(
                    'E-mail',
                    style: titleForms,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomAnimatedContainer(
                  milliseconds: 1000,
                  horizontalOffset: -50,
                  position: 3,
                  widget:CustomFormField(
                    text: 'email',
                    initialValue: widget.clientModel.email,
                    enabled: false,
                    action: TextInputAction.next,
                    type: TextInputType.name,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                    ]),
                    obscureText: false,
                    maxLines: 1,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 4,
                      child: CustomAnimatedContainer(
                        milliseconds: 1200,
                        horizontalOffset: 50,
                        position: 4,
                        widget: Text(
                          'Agendar visita',
                          style: titleForms,
                        ),
                      ),
                    ),
                    Spacer(),
                    Flexible(
                      flex: 4,
                      child: CustomAnimatedContainer(
                        milliseconds: 1200,
                        horizontalOffset: 50,
                        position: 5,
                        widget: Text(
                          'Chave Empresa',
                          style: titleForms,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Flexible(
                      flex: 4,
                      child: CustomAnimatedContainer(
                        milliseconds: 1200,
                        horizontalOffset: 50,
                        position: 6,
                        widget: CustomDateForm(
                          text: 'next_visit',
                          enabled: true,
                        ),
                      ),
                    ),
                    Spacer(),
                    Flexible(
                      flex: 4,
                      child: CustomAnimatedContainer(
                        milliseconds: 1000,
                        horizontalOffset: -50,
                        position: 7,
                        widget: CustomFormField(
                          text: 'company_key',
                          initialValue: '',
                          enabled: true,
                          action: TextInputAction.next,
                          type: TextInputType.name,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                          ]),
                          obscureText: false,
                          maxLines: 1,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                CustomAnimatedContainer(
                  milliseconds: 1200,
                  horizontalOffset: 50,
                  position: 8,
                  widget: Text(
                    'Observações',
                    style: titleForms,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomAnimatedContainer(
                  milliseconds: 1200,
                  horizontalOffset: 50,
                  position: 9,
                  widget:CustomFormField(
                    text: 'observations',
                    initialValue: '',
                    enabled: true,
                    action: TextInputAction.next,
                    type: TextInputType.text,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                    ]),
                    maxLength: 300,
                    obscureText: false,
                    maxLines: 8,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                CustomAnimatedContainer(
                  milliseconds: 1000,
                  horizontalOffset: 100,
                  position: 10,
                  widget: StreamBuilder(
                    initialData: [],
                    stream: clientBloc.loadingStream,
                    builder: (context,snapshot){
                      if (snapshot.data != true) {
                        return CustomButton(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              await clientBloc.updateClientStatus(
                                context: context,
                                dateTime: _formKey.currentState.value['next_visit'],
                                observation: _formKey.currentState.value['observations'],
                                companyKey: _formKey.currentState.value['company_key'],
                                id: widget.clientModel.id
                              );
                            }
                          },
                          widget: Text('Atualizar',style: buttonColors,),
                        );
                      } else {
                        return CustomButton(
                          onPressed: () {},
                          widget: CustomColorCircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
