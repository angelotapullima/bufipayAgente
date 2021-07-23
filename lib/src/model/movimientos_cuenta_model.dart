class MovimientosCuentaModel {
  String idMovimiento;
  String numeroOperacion;
  String idEmpresa;
  String idPago;
  String monto;
  String concepto;
  String fecha;
  String estado;

  MovimientosCuentaModel({
    this.idMovimiento,
    this.numeroOperacion,
    this.idEmpresa,
    this.idPago,
    this.monto,
    this.concepto,
    this.fecha,
    this.estado,
  });

  factory MovimientosCuentaModel.fromJson(Map<String, dynamic> json) => MovimientosCuentaModel(
        idMovimiento: json["idMovimiento"],
        numeroOperacion: json["numeroOperacion"],
        idEmpresa: json["idEmpresa"],
        idPago: json["idPago"],
        monto: json["monto"],
        concepto: json["concepto"],
        fecha: json["fecha"],
        estado: json["estado"],
      );
}
