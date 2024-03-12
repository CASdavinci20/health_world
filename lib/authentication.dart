
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class Authentication {
  static Database? _database;

  static Future<Database> _getDatabase() async {
    if (_database == null) {
      _database = await openDatabase(
        join(await getDatabasesPath(), 'healtworld.db'),
        onCreate: (db, version) async {
          await db.execute(
            'CREATE TABLE doctor(id INTEGER PRIMARY KEY, email TEXT, password TEXT)',
          );
        },
        version: 1,
      );
    }
    return _database!;
  }

  static Future<bool> authenticateDoctor(String email, String password) async {
    final Database db = await _getDatabase();
    final List<Map<String, dynamic>> result = await db.query(
      'doctor',
      where: 'email = ?',
      whereArgs: [email],
    );
    if (result.isEmpty) {
      return false; 
    }
    final String storedPassword = result.first['password'];
   
    if (storedPassword == password) {
      return true; 
    } else {
      return false; 
    }
  }


 
}




class PatientAuthentication {
  static Database? _database;

  static Future<Database> _getDatabase() async {
    if (_database == null) {
      _database = await openDatabase(
        join(await getDatabasesPath(), 'healtworld.db'),
        onCreate: (db, version) async {
          await db.execute(
            'CREATE TABLE patient(id INTEGER PRIMARY KEY, email TEXT, password TEXT)',
          );
        },
        version: 1,
      );
    }
    return _database!;
  }

  
  static Future<bool> authenticatePatient(String email, String password) async {
    final Database db = await _getDatabase();
    final List<Map<String, dynamic>> result = await db.query(
      'patient',
      where: 'email = ?',
      whereArgs: [email],
    );
    if (result.isEmpty) {
      return false; 
    }
    final String storedPassword = result.first['password'];
   
    if (storedPassword == password) {
      return true; 
    } else {
      return false; 
    }
  } 

}