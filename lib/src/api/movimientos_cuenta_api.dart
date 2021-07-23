import 'dart:convert';

import 'package:bufipay_agente/src/database/movimientos_cuenta_database.dart';
import 'package:bufipay_agente/src/model/movimientos_cuenta_model.dart';
import 'package:bufipay_agente/src/preferences/preferences.dart';
import 'package:bufipay_agente/src/utils/constants.dart';
import 'package:http/http.dart' as http;

class MovimientosCuentaApi {
  final movimientosCuentaDatabase = MovimientosCuentaDatabase();
  final prefs = new Preferences();

  Future<bool> obtenerMovimientos() async {
    try {
      final url = Uri.parse('$apiBaseURL/api/Cuenta/listar_movimientos_cuenta');

      final resp = await http.post(url, body: {'app': 'true', 'tn': prefs.token, 'id_cuenta': prefs.idCuenta});

      final decodedData = json.decode(resp.body);
      print(decodedData);

      if (decodedData['result']['code'] == 1) {
        for (int i = 0; i < decodedData['result']['data'].length; i++) {
          MovimientosCuentaModel movimientoCuenta = MovimientosCuentaModel();
          movimientoCuenta.idMovimiento = decodedData['result']['data'][i]['id_transferencia'];
          movimientoCuenta.numeroOperacion = decodedData['result']['data'][i]['transferencia_nro_operacion'];
          movimientoCuenta.cuentaEmisor = decodedData['result']['data'][i]['cuenta_emisor'];
          movimientoCuenta.cuentaReceptor = decodedData['result']['data'][i]['cuenta_receptor'];
          movimientoCuenta.monto = decodedData['result']['data'][i]['transferencia_monto'];
          movimientoCuenta.concepto = decodedData['result']['data'][i]['transferencia_concepto'];
          movimientoCuenta.fecha = decodedData['result']['data'][i]['transferencia_datetime'];
          movimientoCuenta.estado = decodedData['result']['data'][i]['transferencia_estado'];
          movimientoCuenta.tipoMovimiento = decodedData['result']['data'][i]['movimiento'].toString();

          await movimientosCuentaDatabase.insertarMovimientosCuenta(movimientoCuenta);
        }

        return true;
      } else {
        return false;
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return false;
    }
  }
}
