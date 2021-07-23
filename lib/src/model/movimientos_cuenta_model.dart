class MovimientosCuentaModel {
  String idMovimiento;
  String numeroOperacion;
  String cuentaEmisor;
  String cuentaReceptor;
  String monto;
  String concepto;
  String fecha;
  String estado;
  String tipoMovimiento;

  MovimientosCuentaModel({
    this.idMovimiento,
    this.numeroOperacion,
    this.cuentaEmisor,
    this.cuentaReceptor,
    this.monto,
    this.concepto,
    this.fecha,
    this.estado,
    this.tipoMovimiento,
  });

  factory MovimientosCuentaModel.fromJson(Map<String, dynamic> json) => MovimientosCuentaModel(
        idMovimiento: json["idMovimiento"],
        numeroOperacion: json["numeroOperacion"],
        cuentaEmisor: json["cuentaEmisor"],
        cuentaReceptor: json["cuentaReceptor"],
        monto: json["monto"],
        concepto: json["concepto"],
        fecha: json["fecha"],
        estado: json["estado"],
        tipoMovimiento: json["tipoMovimiento"],
      );
}
