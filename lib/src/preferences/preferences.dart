import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static final Preferences _instancia = new Preferences._internal();

  factory Preferences() {
    return _instancia;
  }

  SharedPreferences _prefs;

  Preferences._internal();

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  clearPreferences() async {
    await _prefs.clear();
  }

  get idUserBufiPay {
    return _prefs.getString('idUserBufiPay');
  }

  set idUserBufiPay(String value) {
    _prefs.setString('idUserBufiPay', value);
  }

  get idAgente {
    return _prefs.getString('idAgente');
  }

  set idAgente(String value) {
    _prefs.setString('idAgente', value);
  }

  get userNickname {
    return _prefs.getString('user_nickname');
  }

  set userNickname(String value) {
    _prefs.setString('user_nickname', value);
  }

  get userEmail {
    return _prefs.getString('user_email');
  }

  set userEmail(String value) {
    _prefs.setString('user_email', value);
  }

  get image {
    return _prefs.getString('image');
  }

  set image(String value) {
    _prefs.setString('image', value);
  }

  get personName {
    return _prefs.getString('person_name');
  }

  set personName(String value) {
    _prefs.setString('person_name', value);
  }

  get personSurname {
    return _prefs.getString('person_surname');
  }

  set personSurname(String value) {
    _prefs.setString('person_surname', value);
  }

  get ubigeoId {
    return _prefs.getString('ubigeo_id');
  }

  set ubigeoId(String value) {
    _prefs.setString('ubigeo_id', value);
  }

  get token {
    return _prefs.getString('token');
  }

  set token(String value) {
    _prefs.setString('token', value);
  }

  get agenteNombre {
    return _prefs.getString('agenteNombre');
  }

  set agenteNombre(String value) {
    _prefs.setString('agenteNombre', value);
  }

  get agenteDireccion {
    return _prefs.getString('agenteDireccion');
  }

  set agenteDireccion(String value) {
    _prefs.setString('agenteDireccion', value);
  }

  get idCuenta {
    return _prefs.getString('idCuenta');
  }

  set idCuenta(String value) {
    _prefs.setString('idCuenta', value);
  }

  get numeroCuenta {
    return _prefs.getString('numeroCuenta');
  }

  set numeroCuenta(String value) {
    _prefs.setString('numeroCuenta', value);
  }

  get saldoCuenta {
    return _prefs.getString('saldoCuenta');
  }

  set saldoCuenta(String value) {
    _prefs.setString('saldoCuenta', value);
  }
}
