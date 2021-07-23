import 'dart:convert';
import 'package:bufipay_agente/src/preferences/preferences.dart';
import 'package:bufipay_agente/src/utils/constants.dart';
import 'package:http/http.dart' as http;

class LoginApi {
  final prefs = new Preferences();

  Future<LoginModel> login(String user, String pass) async {
    try {
      final url = Uri.parse('$apiBaseURL/api/Login/validar_sesion');

      final resp = await http.post(url, body: {
        'usuario_nickname': '$user',
        'usuario_contrasenha': '$pass',
        'app': 'true',
      });

      final decodedData = json.decode(resp.body);

      final int code = decodedData['result']['code'];
      LoginModel loginModel = LoginModel();
      loginModel.code = code.toString();
      loginModel.message = decodedData['result']['message'];

      if (code == 1) {
        if (decodedData['data']['agente'] != 0) {
          //Agregar idUser BufiPay
          prefs.idUserBufiPay = decodedData['data']['id_bufipay'];

          //Agregar idAgente BufiPay
          prefs.idAgente = decodedData['data']['agente'].toString();

          prefs.userNickname = decodedData['data']['_n'];
          prefs.userEmail = decodedData['data']['u_e'];
          prefs.image = decodedData['data']['u_i'];
          prefs.personName = decodedData['data']['p_n'];
          prefs.personSurname = '${decodedData['data']['p_p']} ${decodedData['data']['p_m']}';
          prefs.ubigeoId = decodedData['data']['u_u'];
          prefs.token = decodedData['data']['tn'];
        } else {
          loginModel.code = '2';
          loginModel.message = 'Usuario ingresado no es es una Cuenta Agente BufiCard';
        }

        return loginModel;
      } else {
        return loginModel;
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      LoginModel loginModel = LoginModel();
      loginModel.code = '2';
      loginModel.message = 'Error en la petición';
      return loginModel;
    }
  }
}

class LoginModel {
  String code;
  String message;

  LoginModel({this.code, this.message});
}
