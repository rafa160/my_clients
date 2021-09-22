import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_clients_by_anduril/app_module.dart';
import 'package:my_clients_by_anduril/bloc/pdf_bloc.dart';
import 'package:my_clients_by_anduril/bloc/user_bloc.dart';
import 'package:my_clients_by_anduril/components/custom_animated_container.dart';
import 'package:my_clients_by_anduril/components/custom_appbar.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Detalhes do Cliente',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
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
                    enabled: false,
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
                position: 11,
                widget:Text(
                  'Observações',
                  style: titleForms,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              CustomAnimatedContainer(
                milliseconds: 1000,
                horizontalOffset: -50,
                position: 12,
                widget:CustomFormField(
                  text: 'observations',
                  initialValue: widget.clientModel.observations,
                  enabled: false,
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
              CustomAnimatedContainer(
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
            ],
          ),
        ),
      ),
    );
  }


}
