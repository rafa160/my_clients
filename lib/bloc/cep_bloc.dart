
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:my_clients_by_anduril/models/address_model.dart';
import 'package:my_clients_by_anduril/response/api_response.dart';
import 'package:my_clients_by_anduril/service/cep_api.dart';
import 'package:rxdart/rxdart.dart';

enum CepFieldState {
  INITIALIZING,
  INCOMPLETE,
  INVALID,
  VALID
}

class CepBlocState {
  CepFieldState cepFieldState;
  String cep;
  AddressModel addressModel;

  CepBlocState({this.cepFieldState, this.cep, this.addressModel});
}

class CepBloc extends BlocBase {

  CepBloc() {
    onChanged('');
  }

  final BehaviorSubject<CepBlocState> _cepController = BehaviorSubject<CepBlocState>();
  Stream<CepBlocState> get outCep => _cepController.stream;

  void searchCep(String cep) async {
    final ApiResponse apiResponse = await getAddressFromAPI(cep);
    if(apiResponse.success) {
      _cepController.add(
        CepBlocState(
          cepFieldState: CepFieldState.VALID,
          cep: cep,
          addressModel: apiResponse.result,
        )
      );
    } else {
      _cepController.add(
        CepBlocState(
          cepFieldState: CepFieldState.INVALID,
          cep: cep
        )
      );
    }
  }

  void onChanged(String cep) {
    cep = cep.trim().replaceAll('-', '').replaceAll('.', '');
    if(cep.isEmpty || cep.length < 8) {
      _cepController.add(
        CepBlocState(
          cepFieldState: CepFieldState.INCOMPLETE,
          cep: cep,
        )
      );
    } else {
      searchCep(cep);
    }
  }

  @override
  void dispose() {
    _cepController.close();
    super.dispose();
  }
}