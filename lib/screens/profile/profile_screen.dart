import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:my_clients_by_anduril/app_module.dart';
import 'package:my_clients_by_anduril/bloc/user_bloc.dart';
import 'package:my_clients_by_anduril/bloc/version_bloc.dart';
import 'package:my_clients_by_anduril/components/custom_animated_container.dart';
import 'package:my_clients_by_anduril/components/custom_button.dart';
import 'package:my_clients_by_anduril/components/custom_form_field.dart';
import 'package:my_clients_by_anduril/components/custom_modal_bottom_sheet.dart';
import 'package:my_clients_by_anduril/screens/login/login_module.dart';
import 'package:my_clients_by_anduril/styles/style.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  var userBloc = AppModule.to.getBloc<UserBloc>();
  var versionBloc = AppModule.to.getBloc<VersionBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAnimatedContainer(
              position: 1,
              milliseconds: 1000,
              horizontalOffset: 50,
              widget: Container(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width,
                color: background,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text('Perfil.',style: headerWhiteText,)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAnimatedContainer(
                    milliseconds: 1000,
                    horizontalOffset: -50,
                    position: 3,
                    widget:Text(
                      'Email',
                      style: titleForms,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomAnimatedContainer(
                    milliseconds: 1000,
                    horizontalOffset: -50,
                    position: 4,
                    widget:CustomFormField(
                      text: 'email',
                      initialValue: userBloc.user.email,
                      enabled: false,
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
                    height: 20,
                  ),
                  CustomAnimatedContainer(
                    milliseconds: 1000,
                    horizontalOffset: -50,
                    position: 5,
                    widget:Text(
                      'Nome',
                      style: titleForms,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomAnimatedContainer(
                    milliseconds: 1000,
                    horizontalOffset: -50,
                    position: 6,
                    widget:CustomFormField(
                      text: 'name',
                      initialValue: userBloc.user.name,
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
                    height: 50,
                  ),
                  CustomAnimatedContainer(
                    verticalOffset: 800,
                    milliseconds: 1000,
                    position: 7,
                    widget:  CustomButton(
                        widget: Text(
                          'sair',
                          style: buttonColors,
                        ),
                        onPressed: () async {
                          showModalBottomSheet(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            context: context,
                            builder: (builder) {
                              return CustomModalBottomSheet(
                                title: 'Deseja deslogar?',
                                actionButtonTitle: 'deslogar',
                                onPressed: () async {
                                  await userBloc.signOut();
                                  await Get.offAll(() => LoginModule());
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                  SizedBox(
                    height: 30,
                  ),
                  StreamBuilder(
                      stream: versionBloc.streamVersion$,
                      builder: (context, snapshot) {
                        return CustomAnimatedContainer(
                          milliseconds: 1000,
                          position: 8,
                          verticalOffset: 800,
                          widget: Center(
                            child: Text(
                              "versão ${snapshot.data}", style: textButton,
                            ),
                          ),
                        );
                      }
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
