import 'package:bufipay_agente/src/database/database_provider.dart';
import 'package:bufipay_agente/src/model/movimientos_cuenta_model.dart';

class MovimientosCuentaDatabase {
  final dbprovider = DatabaseProvider.db;

  insertarMovimientosCuenta(MovimientosCuentaModel movimientocuenta) async {
    try {
      final db = await dbprovider.database;

      final res = await db.rawInsert("INSERT OR REPLACE INTO MovimientosCuenta (idMovimiento,numeroOperacion,idEmpresa,"
          "idPago,monto,concepto,fecha,estado) "
          "VALUES ('${movimientocuenta.idMovimiento}','${movimientocuenta.numeroOperacion}',"
          "'${movimientocuenta.idEmpresa}','${movimientocuenta.idPago}',"
          "'${movimientocuenta.monto}','${movimientocuenta.concepto}',"
          "'${movimientocuenta.fecha}','${movimientocuenta.estado}')");

      return res;
    } catch (exception) {
      print(exception);
    }
  }

  Future<List<MovimientosCuentaModel>> obtenerMovimientosCuenta() async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM MovimientosCuenta ");

    List<MovimientosCuentaModel> list = res.isNotEmpty ? res.map((c) => MovimientosCuentaModel.fromJson(c)).toList() : [];

    return list;
  }

  Future<List<MovimientosCuentaModel>> obtenerMovimientosCuentaPorNoperacion(String id) async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM MovimientosCuenta where numeroOperacion='$id'");

    List<MovimientosCuentaModel> list = res.isNotEmpty ? res.map((c) => MovimientosCuentaModel.fromJson(c)).toList() : [];

    return list;
  }

// Future<List<MovimientosCuentaModel>> obtenerMovimientosCuentaSoloFecha() async {
//     final db = await dbprovider.database;
//     final res = await db.rawQuery("SELECT * FROM MovimientosCuenta GROUP BY soloFecha");

//     List<MovimientosCuentaModel> list = res.isNotEmpty
//         ? res.map((c) => MovimientosCuentaModel.fromJson(c)).toList()
//         : [];

//     return list;
//   }

  deleteMovimientosCuenta() async {
    final db = await dbprovider.database;

    final res = await db.rawDelete('DELETE FROM MovimientosCuenta');

    return res;
  }
}
