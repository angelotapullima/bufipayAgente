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
        print('token ${decodedData['data']['tn']}');

        prefs.idUser = decodedData['data']['c_u'];
        prefs.userNickname = decodedData['data']['_n'];
        prefs.userEmail = decodedData['data']['u_e'];
        prefs.userEmailValidateCode = decodedData['data']['u_ve'];
        prefs.image = decodedData['data']['u_i'];
        prefs.personName = decodedData['data']['p_n'];
        prefs.personSurname = '${decodedData['data']['p_p']} ${decodedData['data']['p_m']}';
        prefs.personAddress = decodedData['data']['p_d'];
        prefs.idRol = decodedData['data']['ru'];
        prefs.rolNombre = decodedData['data']['rn'];
        prefs.ubigeoId = decodedData['data']['u_u'];
        prefs.token = decodedData['data']['tn'];
        prefs.tokenFirebase = decodedData['data']['u_tk'];

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
