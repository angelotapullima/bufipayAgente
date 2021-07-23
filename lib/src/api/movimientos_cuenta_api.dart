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

      if (decodedData['result']['data'] != 2) {
        for (int i = 0; i < decodedData['result']['data'].length; i++) {
          MovimientosCuentaModel movimientoCuenta = MovimientosCuentaModel();
          movimientoCuenta.idMovimiento = decodedData['result']['data'][i]['id_transferencia_u_e'];
          movimientoCuenta.numeroOperacion = decodedData['result']['data'][i]['transferencia_u_e_nro_operacion'];
          movimientoCuenta.idEmpresa = decodedData['result']['data'][i]['id_empresa'];
          movimientoCuenta.idPago = decodedData['result']['data'][i]['id_pago'];
          movimientoCuenta.monto = decodedData['result']['data'][i]['transferencia_u_e_monto'];
          movimientoCuenta.concepto = decodedData['result']['data'][i]['transferencia_u_e_concepto'];
          movimientoCuenta.fecha = decodedData['result']['data'][i]['transferencia_u_e_date'];
          movimientoCuenta.estado = decodedData['result']['data'][i]['transferencia_u_e_estado'];

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
