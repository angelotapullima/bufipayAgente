import 'dart:convert';

import 'package:bufipay_agente/src/api/cuenta_agente_api.dart';
import 'package:bufipay_agente/src/model/recarga_consultada_codigo_model.dart';
import 'package:bufipay_agente/src/preferences/preferences.dart';
import 'package:bufipay_agente/src/utils/constants.dart';
import 'package:http/http.dart' as http;

class RecargaAgenteApi {
  final preferences = Preferences();
  final cuentaAgenteApi = CuentaAgenteApi();

  Future<RecargaConsultadaPorCodigoModel> obtenerRecargaPorCodigoRecarga(String codigoRecarga) async {
    try {
      final url = Uri.parse('$apiBaseURL/api/Recarga/listar_recarga_por_codigo');

      final resp = await http.post(url, body: {
        'tn': '${preferences.token}',
        'recarga_codigo': '$codigoRecarga',
        'app': 'true',
      });

      final decodedData = json.decode(resp.body);
      print(decodedData);
      RecargaConsultadaPorCodigoModel recargaModel = RecargaConsultadaPorCodigoModel();

      if (decodedData['result']['code'] == 1) {
        recargaModel.code = decodedData['result']['code'].toString();
        recargaModel.idRecarga = decodedData['result']['data']['id_recarga'];
        recargaModel.tipoRecarga = decodedData['result']['data']['recarga_tipo'];
        recargaModel.codigoRecarga = decodedData['result']['data']['recarga_codigo'];
        recargaModel.montoRecarga = decodedData['result']['data']['recarga_monto'];
        recargaModel.conceptoRecarga = decodedData['result']['data']['recarga_concepto'];
        recargaModel.recargaFecha = decodedData['result']['data']['recarga_datetime'];
        recargaModel.fechaExpiracionRecarga = decodedData['result']['data']['recarga_date_expiracion'];
      } else {
        recargaModel.code = '3';
      }

      return recargaModel;
    } catch (e) {
      RecargaConsultadaPorCodigoModel recargaModel = RecargaConsultadaPorCodigoModel();
      recargaModel.code = '2';
      //lista.add(recargaModel);
      return recargaModel;
    }
  }

  Future<int> confirmarRecarga(String idRecarga) async {
    try {
      final url = Uri.parse('$apiBaseURL/api/Recarga/confirmar_recarga');

      final resp = await http.post(url, body: {
        'app': 'true',
        'tn': preferences.token,
        'id_recarga': '$idRecarga',
        'id_negocio': preferences.idAgente,
      });

      final decodedData = json.decode(resp.body);
      print('Resultado guardar recarga : $decodedData');

      // if (decodedData['result']['code'] == 1) {
      //   await cuentaAgenteApi.obtenerCuentaAgenteBufi();
      // }
      return decodedData['result']['code'];
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return 2;
    }
  }
}
