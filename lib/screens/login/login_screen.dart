import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:my_clients_by_anduril/app_module.dart';
import 'package:my_clients_by_anduril/bloc/user_bloc.dart';
import 'package:my_clients_by_anduril/components/custom_animated_container.dart';
import 'package:my_clients_by_anduril/components/custom_button.dart';
import 'package:my_clients_by_anduril/components/custom_color_circular_indicator.dart';
import 'package:my_clients_by_anduril/components/custom_form_field.dart';
import 'package:my_clients_by_anduril/screens/reset_password/reset_password_module.dart';
import 'package:my_clients_by_anduril/screens/sign_up/sign_up_module.dart';
import 'package:my_clients_by_anduril/styles/style.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  var userBloc = AppModule.to.getBloc<UserBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 80, left: 20, right: 20),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAnimatedContainer(
                  milliseconds: 800,
                  horizontalOffset: 50,
                  position: 1,
                  widget: Padding(
                    padding: const EdgeInsets.only(top: 60, bottom: 30),
                    child: Text(
                      'Bem-Vindo!',
                      style: headerText,
                    ),
                  ),
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
                  widget: CustomFormField(
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
                  height: 20,
                ),
                CustomAnimatedContainer(
                  milliseconds: 1200,
                  horizontalOffset: 50,
                  position: 4,
                  widget: Text(
                    'Senha',
                    style: titleForms,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomAnimatedContainer(
                  milliseconds: 1200,
                  horizontalOffset: 50,
                  position: 5,
                  widget: CustomFormField(
                    text: 'password',
                    initialValue: '',
                    enabled: true,
                    action: TextInputAction.next,
                    type: TextInputType.text,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                    ]),
                    obscureText: true,
                    maxLines: 1,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                CustomAnimatedContainer(
                  milliseconds: 1200,
                  horizontalOffset: 50,
                  position: 6,
                  widget: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(() => ResetPasswordModule());
                        },
                        child: Text(
                          'Esqueceu sua Senha?',
                          style: titleForms,
                        ),
                      ),
                      Spacer(),
                      Flexible(
                        flex: 1,
                        child: StreamBuilder(
                            stream: userBloc.loadingStream,
                            initialData: [],
                            builder: (context, snapshot) {
                              if (snapshot.data != true) {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child: CustomButton(
                                    widget: Text(
                                      'Sign In',
                                      style: buttonColors,
                                    ),
                                    onPressed: () async {
                                      FocusScope.of(context)
                                          .requestFocus(new FocusNode());
                                      if (_formKey.currentState.validate()) {
                                        _formKey.currentState.save();
                                        await userBloc.signIn(
                                            _formKey
                                                .currentState.value['email'],
                                            _formKey
                                                .currentState.value['password'],
                                            context);
                                      }
                                    },
                                  ),
                                );
                              } else {
                                return CustomButton(
                                  onPressed: () {},
                                  widget:
                                      CustomColorCircularProgressIndicator(),
                                );
                              }
                            }),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomAnimatedContainer(
                  milliseconds: 1000,
                  horizontalOffset: 50,
                  position: 7,
                  widget: Divider(
                    thickness: 1,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomAnimatedContainer(
                  milliseconds: 1200,
                  horizontalOffset: 50,
                  position: 8,
                  widget: Row(
                    children: [
                      Text(
                        'Don’t you have an account?',
                        style: titleForms,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => SignUpModule());
                        },
                        child: Text(
                          'Sign Up',
                          style: textButton,
                        ),
                      )
                    ],
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
