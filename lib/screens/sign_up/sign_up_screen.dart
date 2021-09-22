import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:my_clients_by_anduril/app_module.dart';
import 'package:my_clients_by_anduril/bloc/user_bloc.dart';
import 'package:my_clients_by_anduril/components/custom_animated_container.dart';
import 'package:my_clients_by_anduril/components/custom_appbar.dart';
import 'package:my_clients_by_anduril/components/custom_button.dart';
import 'package:my_clients_by_anduril/components/custom_color_circular_indicator.dart';
import 'package:my_clients_by_anduril/components/custom_form_field.dart';
import 'package:my_clients_by_anduril/screens/login/login_module.dart';
import 'package:my_clients_by_anduril/styles/style.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  var userBloc = AppModule.to.getBloc<UserBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 40, left: 20,right: 20),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAnimatedContainer(
                  milliseconds: 1000,
                  horizontalOffset: -50,
                  position: 2,
                  widget: Text(
                    'Crie sua Conta',
                    style: headerText,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
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
                  height: 20,
                ),
                CustomAnimatedContainer(
                  milliseconds: 1000,
                  horizontalOffset: -50,
                  position: 7,
                  widget:Text(
                    'Senha',
                    style: titleForms,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomAnimatedContainer(
                  milliseconds: 1000,
                  horizontalOffset: -50,
                  position: 8,
                  widget:CustomFormField(
                    text: 'password',
                    initialValue: '',
                    enabled: true,
                    action: TextInputAction.send,
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
                    milliseconds: 1000,
                    horizontalOffset: -50,
                    position: 9,
                    widget: StreamBuilder(
                        stream: userBloc.loadingStream,
                        initialData: [],
                        builder: (context, snapshot) {
                          if(snapshot.data != true) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: CustomButton(
                                widget: Text('Sign Up', style: buttonColors,),
                                onPressed: () async {
                                  FocusScope.of(context).requestFocus(new FocusNode());
                                  if (_formKey.currentState.validate()) {
                                    _formKey.currentState.save();
                                    await userBloc.signUp(
                                      context: context,
                                      email: _formKey.currentState.value['email'],
                                      password: _formKey.currentState.value['password'],
                                      name: _formKey.currentState.value['name'],
                                    );
                                  }
                                },
                              ),
                            );
                          } else {
                            return CustomButton(
                              onPressed: () {},
                              widget: CustomColorCircularProgressIndicator(),
                            );
                          }
                        }
                    ),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomAnimatedContainer(
                  milliseconds: 1000,
                  horizontalOffset: -50,
                  position: 10,
                  widget: Divider(
                    thickness: 1,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomAnimatedContainer(
                  milliseconds: 1000,
                  horizontalOffset: -50,
                  position: 11,
                  widget:Row(
                    children: [
                      Text('Have an account?', style: titleForms,),
                      SizedBox(
                        width: 4,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => LoginModule());
                        },
                        child: Text(
                          'Sign In',
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
