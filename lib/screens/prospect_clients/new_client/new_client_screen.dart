import 'package:brasil_fields/brasil_fields.dart';
import 'package:cnpj_cpf_formatter/cnpj_cpf_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:my_clients_by_anduril/app_module.dart';
import 'package:my_clients_by_anduril/bloc/client_bloc.dart';
import 'package:my_clients_by_anduril/bloc/user_bloc.dart';
import 'package:my_clients_by_anduril/components/custom_animated_container.dart';
import 'package:my_clients_by_anduril/components/custom_appbar.dart';
import 'package:my_clients_by_anduril/components/custom_button.dart';
import 'package:my_clients_by_anduril/components/custom_cep_form.dart';
import 'package:my_clients_by_anduril/components/custom_color_circular_indicator.dart';
import 'package:my_clients_by_anduril/components/custom_form_field.dart';
import 'package:my_clients_by_anduril/models/address_model.dart';
import 'package:my_clients_by_anduril/screens/prospect_clients/new_client/new_client_module.dart';
import 'package:my_clients_by_anduril/styles/style.dart';

class NewClientScreen extends StatefulWidget {
  @override
  _NewClientScreenState createState() => _NewClientScreenState();
}

class _NewClientScreenState extends State<NewClientScreen> {

  AddressModel address = new AddressModel();
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  var clientBloc = NewClientsModule.to.getBloc<ClientBloc>();
  var userBloc = AppModule.to.getBloc<UserBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Novo Cliente',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 20,right: 20),
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
                  position: 3,
                  widget:CustomFormField(
                    text: 'name',
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
                SizedBox(
                  height: 30,
                ),
                CustomAnimatedContainer(
                  milliseconds: 1200,
                  horizontalOffset: 50,
                  position: 2,
                  widget: Text(
                    'Email',
                    style: titleForms,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomAnimatedContainer(
                  milliseconds: 1200,
                  horizontalOffset: 50,
                  position: 3,
                  widget:CustomFormField(
                    text: 'email',
                    initialValue: '',
                    enabled: true,
                    action: TextInputAction.next,
                    type: TextInputType.emailAddress,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.email(context),
                      FormBuilderValidators.required(context),
                    ]),
                    obscureText: false,
                    maxLines: 1,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                CustomAnimatedContainer(
                  milliseconds: 1200,
                  horizontalOffset: 50,
                  position: 2,
                  widget: Text(
                    'WhatsApp',
                    style: titleForms,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomAnimatedContainer(
                  milliseconds: 1200,
                  horizontalOffset: 50,
                  position: 3,
                  widget:CustomFormField(
                    text: 'whats_app',
                    initialValue: '',
                    enabled: true,
                    input: [
                      FilteringTextInputFormatter.digitsOnly,
                      TelefoneInputFormatter(),
                    ],
                    action: TextInputAction.next,
                    type: TextInputType.number,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                    ]),
                    obscureText: false,
                    maxLines: 1,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                CustomAnimatedContainer(
                  milliseconds: 1000,
                  horizontalOffset: -50,
                  position: 4,
                  widget:Text(
                    'Nome da Empresa',
                    style: titleForms,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomAnimatedContainer(
                  milliseconds: 1000,
                  horizontalOffset: -50,
                  position: 5,
                  widget:CustomFormField(
                    text: 'company',
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
                SizedBox(
                  height: 30,
                ),
                CustomAnimatedContainer(
                  milliseconds: 1000,
                  horizontalOffset: -50,
                  position: 8,
                  widget:Text(
                    'CNPJ',
                    style: titleForms,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomAnimatedContainer(
                  verticalOffset: 10,
                  horizontalOffset: 120,
                  milliseconds: 1200,
                  position: 7,
                  widget: CustomFormField(
                    text: 'document',
                    initialValue: '',
                    enabled: true,
                    input: [
                      CnpjCpfFormatter(
                        eDocumentType: EDocumentType.BOTH,
                      )
                    ],
                    action: TextInputAction.next,
                    type: TextInputType.number,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                    ]),
                    obscureText: false,
                    maxLines: 1,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                CustomAnimatedContainer(
                  milliseconds: 1000,
                  horizontalOffset: -50,
                  position: 8,
                  widget:Text(
                    'Telefone',
                    style: titleForms,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomAnimatedContainer(
                  milliseconds: 1000,
                  horizontalOffset: -50,
                  position: 9,
                  widget: CustomFormField(
                    text: 'phone',
                    initialValue: '',
                    enabled: true,
                    input: [
                      FilteringTextInputFormatter.digitsOnly,
                      TelefoneInputFormatter(),
                    ],
                    action: TextInputAction.next,
                    type: TextInputType.number,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                    ]),
                    obscureText: false,
                    maxLines: 1,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                CustomAnimatedContainer(
                  milliseconds: 1000,
                  horizontalOffset: -50,
                  position: 10,
                  widget:Text(
                    'Informe o CEP',
                    style: titleForms,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomAnimatedContainer(
                  milliseconds: 1000,
                  horizontalOffset: -50,
                  position: 11,
                  widget:CustomCepForm(
                    onSaved: (a) {
                      address = a;
                      print(a);
                    },
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                CustomAnimatedContainer(
                  milliseconds: 1000,
                  horizontalOffset: -50,
                  position: 12,
                  widget:Text(
                    'Número',
                    style: titleForms,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: CustomAnimatedContainer(
                        milliseconds: 1000,
                        horizontalOffset: -100,
                        position: 12,
                        widget: CustomFormField(
                          text: 'number',
                          initialValue: '',
                          enabled: true,
                          input: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          action: TextInputAction.send,
                          type: TextInputType.number,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                          ]),
                          maxLength: 6,
                          obscureText: false,
                          maxLines: 1,
                        ),
                      ),
                    ),
                    Spacer(),
                    Flexible(
                      flex: 3,
                      child: CustomAnimatedContainer(
                        milliseconds: 1000,
                        horizontalOffset: 100,
                        position: 13,
                        widget: StreamBuilder(
                          initialData: [],
                          stream: clientBloc.loadingStream,
                          builder: (context,snapshot){
                             if (snapshot.data != true) {
                               return CustomButton(
                                 onPressed: () async {
                                   if (_formKey.currentState.validate()) {
                                     _formKey.currentState.save();
                                     await clientBloc.registerClient(
                                       context: context,
                                       employeeId: userBloc.user.id,
                                       name: _formKey.currentState.value['name'],
                                       company: _formKey.currentState.value['company'],
                                       phone: _formKey.currentState.value['phone'],
                                       addressModel: address,
                                       document: _formKey.currentState.value['document'],
                                       number: _formKey.currentState.value['number'],
                                       whatsApp: _formKey.currentState.value['whats_app'],
                                       email: _formKey.currentState.value['email']
                                     );
                                   }
                                 },
                                 widget: Text('Cadastrar',style: buttonColors,),
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
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
