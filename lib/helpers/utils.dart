import 'package:intl/intl.dart';
import 'package:my_clients_by_anduril/models/address_model.dart';

String formattedDate(DateTime time) {
  String formattedDate = DateFormat('dd/MM/yyyy HH:mm').format(time);
  return formattedDate;
}

String removeSignalsFromNumber(String value) {
  String _onlyDigits = value.replaceAll(RegExp('[^0-9]'), "");
  return _onlyDigits;
}

String getPhoneLaunch(String phone) {
  String _onlyDigits = removeSignalsFromNumber(phone);
  String _url = 'tel:$_onlyDigits';
  return _url;
}

String locationUrl(AddressModel addressModel, String number) {
  return 'https://www.google.com/maps/search/?api=1&query=${addressModel.place},$number - ${addressModel.district}, ${addressModel.city}';
}

String clientWhatsAppUrl(String value) {
  String _phoneNumber = removeSignalsFromNumber(value);
  String _url = 'https://api.whatsapp.com/send?phone=55$_phoneNumber';
  return _url;
}