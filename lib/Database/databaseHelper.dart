import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:vehicle_registration/Model/vehicleModel.dart';

class VehicleDatabaseHelper {
  static const String tableName = 'vehicles';

  late Database database;

  // Future openDatabase() async {
  //   final dbPath = await getDatabasesPath();
  //   final path = p.join(dbPath, 'vehicles.db');
  //   database = await openDatabase(path, version: 1, onCreate: (db, version) {
  //     db.execute('''
  //       CREATE TABLE $tableName(
  //         id INTEGER PRIMARY KEY AUTOINCREMENT,
  //         registrationNumber TEXT,
  //         engineNumber TEXT,
  //         model TEXT,
  //         type TEXT,
  //         company TEXT,
  //         vehicleName TEXT,
  //         basicInfo TEXT,
  //         photos TEXT
  //       )
  //     ''');
  //   });
  // }

  // Future<int> insertVehicle(Vehicle vehicle) async {
  //   return await database.insert(tableName, vehicle.toMap());
  // }

  // Implement other database methods like update, delete, and retrieve.
}
