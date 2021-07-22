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

  get idUser {
    return _prefs.getString('id_user');
  }

  set idUser(String value) {
    _prefs.setString('id_user', value);
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

  get userEmailValidateCode {
    return _prefs.getString('user_email_validate_code');
  }

  set userEmailValidateCode(String value) {
    _prefs.setString('user_email_validate_code', value);
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

  get rolNombre {
    return _prefs.getString('rol_nombre');
  }

  set rolNombre(String value) {
    _prefs.setString('rol_nombre', value);
  }

  get idRol {
    return _prefs.getString('id_rol');
  }

  set idRol(String value) {
    _prefs.setString('id_rol', value);
  }

  get personAddress {
    return _prefs.getString('person_address');
  }

  set personAddress(String value) {
    _prefs.setString('person_address', value);
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

  get tokenFirebase {
    return _prefs.getString('token_firebase');
  }

  set tokenFirebase(String value) {
    _prefs.setString('token_firebase', value);
  }

  get idNegocio {
    return _prefs.getString('idNegocio');
  }

  set idNegocio(String value) {
    _prefs.setString('idNegocio', value);
  }
}
