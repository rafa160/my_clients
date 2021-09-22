import 'package:dio/dio.dart';
import 'package:my_clients_by_anduril/helpers/api_error.dart';
import 'package:my_clients_by_anduril/models/address_model.dart';
import 'package:my_clients_by_anduril/response/api_response.dart';



Future<ApiResponse> getAddressFromAPI(String cep) async {
  final String endPoint =
      'http://viacep.com.br/ws/${cep.replaceAll('.', '').replaceAll('-', '')}/json/';

  try {
    final Response response = await Dio().get<Map>(endPoint);

    if(response.data['erro'] == true) {
      return ApiResponse.fail(
        error: ApiError(
          code: -1,
          message: 'CEP inválido'
        ),
      );
    }
    final AddressModel addressModel = AddressModel(
      place: response.data['logradouro'],
      district: response.data['bairro'],
      city: response.data['localidade'],
      postalCode: response.data['cep'],
      unit: response.data['uf'],
    );

    return ApiResponse.success(
      result: addressModel
    );
  } on DioError catch (e){
   return ApiResponse.fail(
     error: ApiError(
       code: -1,
       message: 'Falha ao conectar na API'
     )
   );
  }

}