import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:my_clients_by_anduril/app_module.dart';
import 'package:my_clients_by_anduril/bloc/client_bloc.dart';
import 'package:my_clients_by_anduril/bloc/pdf_bloc.dart';
import 'package:my_clients_by_anduril/bloc/user_bloc.dart';
import 'package:my_clients_by_anduril/components/custom_alert_dialog.dart';
import 'package:my_clients_by_anduril/components/custom_animated_container.dart';
import 'package:my_clients_by_anduril/components/custom_appbar.dart';
import 'package:my_clients_by_anduril/components/custom_button.dart';
import 'package:my_clients_by_anduril/components/custom_color_circular_indicator.dart';
import 'package:my_clients_by_anduril/components/custom_date_form.dart';
import 'package:my_clients_by_anduril/components/custom_form_field.dart';
import 'package:my_clients_by_anduril/components/custom_info_card.dart';
import 'package:my_clients_by_anduril/helpers/utils.dart';
import 'package:my_clients_by_anduril/models/client_model.dart';
import 'package:my_clients_by_anduril/screens/client/client_details/client_details_module.dart';
import 'package:my_clients_by_anduril/styles/style.dart';
import 'package:url_launcher/url_launcher.dart';

class ClientDetailsScreen extends StatefulWidget {

  final ClientModel clientModel;

  const ClientDetailsScreen({Key key, this.clientModel}) : super(key: key);
  @override
  _ClientDetailsScreenState createState() => _ClientDetailsScreenState();
}

class _ClientDetailsScreenState extends State<ClientDetailsScreen> {

  var pdfBloc = ClientDetailsModule.to.getBloc<PdfBloc>();
  var userBloc = AppModule.to.getBloc<UserBloc>();
  var clientBloc = ClientDetailsModule.to.getBloc<ClientBloc>();
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Detalhes do Cliente',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 5,
                      child: CustomAnimatedContainer(
                        milliseconds: 1000,
                        horizontalOffset: -50,
                        position: 5,
                        widget:Text(
                          'Responsável',
                          style: titleForms,
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: CustomAnimatedContainer(
                        milliseconds: 1000,
                        horizontalOffset: -50,
                        position: 6,
                        widget:Text(
                          'Empresa',
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 5,
                      child: CustomAnimatedContainer(
                        milliseconds: 1000,
                        horizontalOffset: -50,
                        position: 7,
                        widget:CustomFormField(
                          text: 'name',
                          initialValue: widget.clientModel.name,
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
                    Spacer(),
                    Flexible(
                      flex: 5,
                      child: CustomAnimatedContainer(
                        milliseconds: 1000,
                        horizontalOffset: -50,
                        position: 8,
                        widget:CustomFormField(
                          text: 'company',
                          initialValue: widget.clientModel.company,
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
                  milliseconds: 1000,
                  horizontalOffset: -50,
                  position: 9,
                  widget:Text(
                    'Data da Visita',
                    style: titleForms,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomAnimatedContainer(
                  milliseconds: 1000,
                  horizontalOffset: -50,
                  position: 10,
                  widget: CustomDateForm(
                    text: 'date',
                    initialValue: widget.clientModel.nextVisit,
                    enabled: false,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                CustomAnimatedContainer(
                  milliseconds: 1000,
                  horizontalOffset: -50,
                  position: 9,
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
                    position: 12,
                    widget:CustomFormField(
                      text: 'email',
                      initialValue: widget.clientModel.email,
                      enabled: true,
                      action: TextInputAction.next,
                      type: TextInputType.text,
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
                    initialValue: widget.clientModel.whatsApp,
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
                  height: 20,
                ),
                CustomAnimatedContainer(
                  milliseconds: 1000,
                  horizontalOffset: -50,
                  position: 11,
                  widget:Text(
                    'Observações',
                    style: titleForms,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomAnimatedContainer(
                  milliseconds: 1000,
                  horizontalOffset: -50,
                  position: 12,
                  widget:CustomFormField(
                    text: 'observations',
                    initialValue: widget.clientModel.observations,
                    enabled: true,
                    action: TextInputAction.next,
                    type: TextInputType.text,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                    ]),
                    maxLength: 300,
                    obscureText: false,
                    maxLines: 4,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                CustomAnimatedContainer(
                  milliseconds: 1000,
                  horizontalOffset: -50,
                  position: 11,
                  widget:Text(
                    'Orçamento',
                    style: titleForms,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomAnimatedContainer(
                  milliseconds: 1000,
                  horizontalOffset: -50,
                  position: 12,
                  widget:CustomFormField(
                    text: 'budget',
                    initialValue: widget.clientModel.budget,
                    enabled: true,
                    action: TextInputAction.next,
                    type: TextInputType.text,
                    maxLength: 300,
                    obscureText: false,
                    maxLines: 4,
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
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomAlertDialog(
                                    title: 'Deseja atualizar as informações de ${widget.clientModel.company}?',
                                    content: '',
                                    yes: () async {
                                      if (_formKey.currentState.validate()) {
                                        _formKey.currentState.save();
                                        await clientBloc.updateClientsInfoById(
                                            context: context,
                                            name: _formKey.currentState.value['name'],
                                            company: _formKey.currentState.value['company'],
                                            email: _formKey.currentState.value['email'],
                                            id: widget.clientModel.id,
                                            budget: _formKey.currentState.value['budget'],
                                            observations: _formKey.currentState.value['observations'],
                                            phone: _formKey.currentState.value['phone']
                                        );
                                      }
                                      Get.back();
                                    },
                                  );
                                }
                            );

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
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: CustomAnimatedContainer(
                        position: 13,
                        horizontalOffset: 150,
                        milliseconds: 1250,
                        widget: CustomInfoPageCard(
                          width: MediaQuery.of(context).size.width * 0.3,
                          onTap: () async {
                            String url = getPhoneLaunch(widget.clientModel.phone);
                            await launch(url);
                          },
                          text: 'Contato',
                          icon: FaIcon(
                            FontAwesomeIcons.phone,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: CustomAnimatedContainer(
                        position: 14,
                        horizontalOffset: 160,
                        milliseconds: 1250,
                        widget: CustomInfoPageCard(
                          width: MediaQuery.of(context).size.width * 0.3,
                          onTap: () async {
                            String url = clientWhatsAppUrl(widget.clientModel.whatsApp);
                            await launch(url);
                          },
                          text: 'WhatsApp',
                          icon: FaIcon(
                            FontAwesomeIcons.whatsapp,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: CustomAnimatedContainer(
                        position: 15,
                        horizontalOffset: 170,
                        milliseconds: 1250,
                        widget: CustomInfoPageCard(
                          width: MediaQuery.of(context).size.width * 0.3,
                          onTap: () async{
                            await pdfBloc.conformancePDF(clientModel: widget.clientModel, userModel: userBloc.user);
                          },
                          text: 'Exportar',
                          icon: FaIcon(
                            FontAwesomeIcons.filePdf,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: CustomAnimatedContainer(
                        position: 15,
                        horizontalOffset: 170,
                        milliseconds: 1250,
                        widget: CustomInfoPageCard(
                          width: MediaQuery.of(context).size.width,
                          onTap: () async{
                            String url = locationUrl(widget.clientModel.addressModel, widget.clientModel.number);
                            await launch(url);
                          },
                          text: 'Localização',
                          icon: FaIcon(
                            FontAwesomeIcons.globeAmericas,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: CustomAnimatedContainer(
                        position: 16,
                        horizontalOffset: 170,
                        milliseconds: 1250,
                        widget: CustomInfoPageCard(
                          width: MediaQuery.of(context).size.width,
                          onTap: () async{
                            await pdfBloc.createBudget(clientModel: widget.clientModel, userModel: userBloc.user);
                          },
                          text: 'Exportar Orçamento',
                          icon: FaIcon(
                            FontAwesomeIcons.coins,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


}
