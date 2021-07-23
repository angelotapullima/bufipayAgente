import 'package:bufipay_agente/src/api/movimientos_cuenta_api.dart';
import 'package:bufipay_agente/src/database/movimientos_cuenta_database.dart';
import 'package:bufipay_agente/src/model/movimientos_cuenta_model.dart';
import 'package:rxdart/rxdart.dart';

class MovimientosCuentaBloc {
  final movimientosCuentaDatabase = MovimientosCuentaDatabase();
  final movimientosCuentaApi = MovimientosCuentaApi();
  final _movimientosCuentaController = BehaviorSubject<List<MovimientosCuentaModel>>();

  Stream<List<MovimientosCuentaModel>> get movimientosCuentaStream => _movimientosCuentaController.stream;

  dispose() {
    _movimientosCuentaController?.close();
  }

  void obtenerMovimientosCuenta() async {
    _movimientosCuentaController.sink.add(await movimientosCuentaDatabase.obtenerMovimientosCuenta());
    await movimientosCuentaApi.obtenerMovimientos();
    _movimientosCuentaController.sink.add(await movimientosCuentaDatabase.obtenerMovimientosCuenta());
  }
}
