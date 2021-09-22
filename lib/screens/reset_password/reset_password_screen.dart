import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:my_clients_by_anduril/app_module.dart';
import 'package:my_clients_by_anduril/bloc/user_bloc.dart';
import 'package:my_clients_by_anduril/components/custom_animated_container.dart';
import 'package:my_clients_by_anduril/components/custom_appbar.dart';
import 'package:my_clients_by_anduril/components/custom_button.dart';
import 'package:my_clients_by_anduril/components/custom_color_circular_indicator.dart';
import 'package:my_clients_by_anduril/components/custom_form_field.dart';
import 'package:my_clients_by_anduril/styles/style.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  var userBloc = AppModule.to.getBloc<UserBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Redefinir senha',
      ),
      body: FormBuilder(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  CustomAnimatedContainer(
                    milliseconds: 1200,
                    horizontalOffset: -200,
                    position: 2,
                    widget:CustomFormField(
                      text: 'email',
                      hint: 'E-mail',
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
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            CustomAnimatedContainer(
              milliseconds: 1200,
              horizontalOffset: -200,
              position: 3,
              widget:Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: StreamBuilder(
                    stream: userBloc.loadingStream,
                    initialData: [],
                    builder: (context, snapshot) {
                      if(snapshot.data != true) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: CustomButton(
                            widget: Text('enviar', style: buttonColors,),
                            onPressed: () async {
                              FocusScope.of(context).requestFocus(new FocusNode());
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                await userBloc.resetPassword(
                                    _formKey.currentState.value['email'],
                                    context);
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
            ),
          ],
        ),
      ),
    );
  }
}
