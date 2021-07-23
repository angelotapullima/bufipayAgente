import 'dart:convert';

import 'package:bufipay_agente/src/database/cuenta_database.dart';
import 'package:bufipay_agente/src/model/cuenta_model.dart';
import 'package:bufipay_agente/src/preferences/preferences.dart';
import 'package:bufipay_agente/src/utils/constants.dart';
import 'package:http/http.dart' as http;

class CuentaAgenteApi {
  final preferences = Preferences();
  final cuentaDatabase = CuentaDatabase();

  Future<CuentaAgenteModel> obtenerCuentaAgenteBufi() async {
    try {
      final url = Uri.parse('$apiBaseURL/api/Cuenta/listar_cuenta_por_id_negocio');

      final resp = await http.post(url, body: {
        'tn': '${preferences.token}',
        'id_negocio': '${preferences.idAgente}',
        'app': 'true',
      });

      final decodedData = json.decode(resp.body);
      CuentaAgenteModel cuentaAgenteModel = CuentaAgenteModel();
      cuentaAgenteModel.code = decodedData['result']['code'].toString();

      if (decodedData['result']['code'] == 1) {
        CuentaModel cuenta = CuentaModel();

        //Guardar los datos en preferencias
        //---------------------------------------------------------------------------------
        preferences.idCuenta = decodedData['result']['data']['id_cuenta'];
        preferences.numeroCuenta = decodedData['result']['data']['cuenta_codigo'];
        preferences.saldoCuenta = decodedData['result']['data']['cuenta_saldo'];
        preferences.agenteNombre = decodedData['result']['data']['negocio_nombre'];
        preferences.agenteDireccion = decodedData['result']['data']['negocio_direccion'];
        cuentaAgenteModel.message = 'Bienvenido!!!';
        //---------------------------------------------------------------------------------

        //Guardar en DataBase
        //---------------------------------------------------------------------------------
        cuenta.idCuenta = decodedData['result']['data']['id_cuenta'];
        cuenta.numeroCuenta = decodedData['result']['data']['cuenta_codigo'];
        cuenta.saldo = decodedData['result']['data']['cuenta_saldo'];
        cuenta.monedaCuenta = decodedData['result']['data']['cuenta_moneda'];
        cuenta.estadoCuenta = decodedData['result']['data']['cuenta_estado'];

        await cuentaDatabase.insertarCuenta(cuenta);
        //---------------------------------------------------------------------------------

      } else {
        cuentaAgenteModel.message = 'Error, Sin Agente Asignado';
      }

      return cuentaAgenteModel;
    } catch (e) {
      CuentaAgenteModel cuentaAgenteModel = CuentaAgenteModel();
      cuentaAgenteModel.code = '2';

      return cuentaAgenteModel;
    }
  }
}

class CuentaAgenteModel {
  String code;
  String message;

  CuentaAgenteModel({this.code, this.message});
}
