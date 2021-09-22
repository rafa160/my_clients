import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_clients_by_anduril/styles/style.dart';

class CustomFormField extends StatelessWidget {

  final String text;
  final TextInputAction action;
  final TextInputType type;
  final bool obscureText;
  final String hint;
  final bool enabled;
  final FormFieldValidator<String> validator;
  final List<TextInputFormatter> input;
  final String initialValue;
  final Function onChanged;
  final int maxLength;
  final FocusNode focusNode;
  final ValueTransformer transformer;
  final int maxLines;
  final TextEditingController controller;
  final FaIcon icon;

  const CustomFormField({Key key, this.text, this.action, this.type, this.obscureText, this.hint, this.enabled, this.validator, this.input, this.initialValue, this.onChanged, this.maxLength, this.focusNode, this.transformer, this.maxLines, this.controller, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      controller: controller,
      maxLines: maxLines,
      focusNode: focusNode,
      onChanged: onChanged,
      enabled: enabled,
      initialValue: initialValue,
      name: text,
      autocorrect: false,
      style: titleForms,
      cursorColor: buttonColor,
      validator: validator,
      textInputAction: action,
      keyboardType: type,
      obscureText: obscureText,
      maxLength: maxLength,
      inputFormatters: input,
      valueTransformer: transformer,
      decoration: InputDecoration(
        icon: icon,
        errorStyle: TextStyle(fontSize: 10, color: Colors.redAccent),
        counterText: '',
        hintText: hint,
        hintStyle: titleForms,
        contentPadding: EdgeInsets.all(8),
        border: InputBorder.none,
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
