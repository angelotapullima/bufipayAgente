import 'package:bufipay_agente/src/api/recargas_agente_api.dart';
import 'package:bufipay_agente/src/model/recarga_consultada_codigo_model.dart';
import 'package:rxdart/rxdart.dart';

class ConfirmarRecargaBloc {
  final recargaApi = RecargaAgenteApi();

  final _consultarRecargaXCodigoController = BehaviorSubject<List<RecargaConsultadaPorCodigoModel>>();
  final _cargandoController = new BehaviorSubject<bool>();

  Stream<List<RecargaConsultadaPorCodigoModel>> get recargaXCodigoStream => _consultarRecargaXCodigoController.stream;
  Stream<bool> get cargando => _cargandoController.stream;
  dispose() {
    _consultarRecargaXCodigoController?.close();
    _cargandoController?.close();
  }

  void obtenerRecargaPorCodigoRecarga() async {
    _consultarRecargaXCodigoController.sink.add([]);
  }

  Future<RecargaConsultadaPorCodigoModel> consultar(String codigoRecarga) async {
    _cargandoController.sink.add(true);
    final resp = await recargaApi.obtenerRecargaPorCodigoRecarga(codigoRecarga);
    if (resp.code == '1') {
      final List<RecargaConsultadaPorCodigoModel> list = [];
      list.add(resp);
      _consultarRecargaXCodigoController.sink.add(list);
    }
    _cargandoController.sink.add(false);
    return resp;
  }
}
