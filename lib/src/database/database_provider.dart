import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static Database _database;
  static final DatabaseProvider db = DatabaseProvider._();

  DatabaseProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();

    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, 'agentebufiv1.db');
    Future _onConfigure(Database db) async {
      await db.execute('PRAGMA foreign_keys = ON');
    }

    return await openDatabase(path, version: 1, onOpen: (db) {}, onConfigure: _onConfigure, onCreate: (Database db, int version) async {
      await db.execute(' CREATE TABLE Cuenta('
          ' idCuenta TEXT PRIMARY KEY,'
          ' numeroCuenta TEXT,'
          ' saldo TEXT,'
          ' monedaCuenta TEXT,'
          ' estadoCuenta TEXT'
          ')');

      await db.execute(' CREATE TABLE MovimientosCuenta('
          ' idMovimiento TEXT PRIMARY KEY,'
          ' numeroOperacion TEXT,'
          ' cuentaEmisor TEXT,'
          ' cuentaReceptor TEXT,'
          ' monto TEXT,'
          ' concepto TEXT,'
          ' fecha TEXT,'
          ' estado TEXT,'
          ' tipoMovimiento TEXT'
          ')');
    });
  }
}
