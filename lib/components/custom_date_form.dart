import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:my_clients_by_anduril/styles/style.dart';

class CustomDateForm extends StatelessWidget {
  final String text;
  final DateTime initialValue;
  final bool enabled;
  const CustomDateForm({Key key, this.text, this.initialValue,this.enabled}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderDateTimePicker(
      name: text,
      inputType: InputType.both,
      style: titleForms,
      initialValue: initialValue,
      firstDate: DateTime.now(),
      enabled: enabled,
      format: DateFormat("dd/MM/yyyy HH:mm"),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(context),
      ]),
      decoration:
      InputDecoration(
        contentPadding: EdgeInsets.all(8),
        errorStyle: TextStyle(fontSize: 10, color: Colors.redAccent),
        hintStyle: titleForms,
        focusedBorder: OutlineInputBorder(
            gapPadding: 10,
            borderSide: BorderSide(color: buttonColor),
            borderRadius: BorderRadius.circular(6.0)),
        enabledBorder: OutlineInputBorder(
            gapPadding: 10,
            borderSide: BorderSide(color: Colors.grey[300]),
            borderRadius: BorderRadius.circular(6.0)),
        errorBorder: OutlineInputBorder(
            gapPadding: 10,
            borderSide: BorderSide(color: Colors.red[100]),
            borderRadius: BorderRadius.circular(6.0)),
        disabledBorder: OutlineInputBorder(
            gapPadding: 10,
            borderSide: BorderSide(color: buttonColor),
            borderRadius: BorderRadius.circular(6.0)),
      ),
    );
  }
}
