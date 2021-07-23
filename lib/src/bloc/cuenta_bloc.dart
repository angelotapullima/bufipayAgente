import 'package:bufipay_agente/src/api/cuenta_agente_api.dart';
import 'package:bufipay_agente/src/database/cuenta_database.dart';
import 'package:bufipay_agente/src/model/cuenta_model.dart';
import 'package:rxdart/rxdart.dart';

class CuentaBloc {
  final cuentaDatabase = CuentaDatabase();
  final cuentaApi = CuentaAgenteApi();
  final _cuentaController = BehaviorSubject<List<CuentaModel>>();

  Stream<List<CuentaModel>> get cuentaStream => _cuentaController.stream;

  dispose() {
    _cuentaController?.close();
  }

  void obtenerDetalleCuenta() async {
    _cuentaController.sink.add(await cuentaDatabase.obtenerCuenta());
    await cuentaApi.obtenerCuentaAgenteBufi();
    _cuentaController.sink.add(await cuentaDatabase.obtenerCuenta());
  }
}
