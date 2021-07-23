class CuentaModel {
  String idCuenta;
  String numeroCuenta;
  String saldo;
  String monedaCuenta;
  String estadoCuenta;

  CuentaModel({
    this.idCuenta,
    this.numeroCuenta,
    this.saldo,
    this.monedaCuenta,
    this.estadoCuenta,
  });
  factory CuentaModel.fromJson(Map<String, dynamic> json) => CuentaModel(
        idCuenta: json["idCuenta"],
        numeroCuenta: json["numeroCuenta"],
        saldo: json["saldo"],
        monedaCuenta: json["monedaCuenta"],
        estadoCuenta: json["estadoCuenta"],
      );
}
