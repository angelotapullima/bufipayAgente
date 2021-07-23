import 'package:bufipay_agente/src/database/database_provider.dart';
import 'package:bufipay_agente/src/model/cuenta_model.dart';

class CuentaDatabase {
  final dbprovider = DatabaseProvider.db;

  insertarCuenta(CuentaModel cuenta) async {
    try {
      final db = await dbprovider.database;

      final res = await db.rawInsert("INSERT OR REPLACE INTO Cuenta (idCuenta,numeroCuenta,saldo,"
          "monedaCuenta,estadoCuenta) "
          "VALUES ('${cuenta.idCuenta}','${cuenta.numeroCuenta}',"
          "'${cuenta.saldo}','${cuenta.monedaCuenta}',"
          "'${cuenta.estadoCuenta}')");

      return res;
    } catch (exception) {
      print(exception);
    }
  }

  Future<List<CuentaModel>> obtenerCuenta() async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM Cuenta ");

    List<CuentaModel> list = res.isNotEmpty ? res.map((c) => CuentaModel.fromJson(c)).toList() : [];
    return list;
  }

  deleteCuenta() async {
    final db = await dbprovider.database;

    final res = await db.rawDelete('DELETE FROM Cuenta');

    return res;
  }
}
