import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'doctoraptm.dart';
import 'patientaptmview.dart';
import 'doctorsignup.dart';
import 'class.dart';


class DatabaseHelper {
  static Database? _database;
  static final DatabaseHelper instance = DatabaseHelper._();

  DatabaseHelper._();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'healtworld.db');
    print("Database Path: $path");
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future<void> _createDb(Database db, int version) async {
    try {
    await db.execute('''
       CREATE TABLE Patient (
        id INTEGER PRIMARY KEY NOT NULL,
        fname TEXT NOT NULL,
        lname TEXT NOT NULL,
        email TEXT NOT NULL,
        gender TEXT,
        date_birth TEXT,
        home_add TEXT ,
        phone TEXT NOT NULL,
        bloodgroup TEXT,
        genotype TEXT,
        marital_status TEXT,  
        height TEXT,
        weight TEXT,
        allergies TEXT,
        emergency_contact_name TEXT,
        emergency_contact_phone TEXT,
        occupation TEXT,
        habit TEXT,
        password TEXT NOT NULL 
      )
    ''');

    await db.execute('''
       CREATE TABLE doctor (
        id INTEGER PRIMARY KEY NOT NULL,
        fname TEXT NOT NULL,
        lname TEXT NOT NULL,
        email TEXT NOT NULL,
        gender TEXT,
        password TEXT,
        date_birth TEXT,
        home_add TEXT ,
        phone TEXT ,
        clinic_name TEXT,
        clinic_address TEXT,
        speciality TEXT,
        department TEXT,
        marital_status TEXT,
        imageUrl TEXT
        
      )
 ''');

   await db.execute('''
       CREATE TABLE appointment (
        id INTEGER PRIMARY KEY NOT NULL,
        fname TEXT NOT NULL,
        lname TEXT NOT NULL,
        email TEXT NOT NULL,
        phone TEXT NOT NULL,
        doctor_name TEXT,
        departmant TEXT,
        clinic_name TEXT,
        speciality TEXT,
        reason TEXT,
        date_time INTEGER
      )
 ''');



 await db.execute('''
      CREATE TABLE appointment_status (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        status TEXT NOT NULL
      )
    ''');

} catch (e) {
  print("Error: $e");
}

  }
  
   Future<void> insertPatient({
    required String fname,
    required String lname,
    required String email,
    required String phone,
    required String password,
    required String date_birth,
    required String home_add,
    required String bloodgroup,
    required String genotype,
    required String height,
    required String weight,
    required String allergies,
    required String emergency_contact_name,
    required String emergency_contact_phone,
    required String marital_status,
    required String occupation,
    required String gender,
    required String habit,
  
    
  }) async {
    final db = await database;
    try {
    int insertedPatient = await db.insert(
      'patient', 
      {
          'fname': fname,
          'lname': lname,
          'email': email,
          'phone': phone,
          'password':password,
          'date_birth': date_birth,
          'home_add': home_add,
          'bloodgroup': bloodgroup,
          'genotype': genotype,
          'height': height,
          'weight': weight,
          'allergies': allergies,
          'emergency_contact_name': emergency_contact_name,
          'emergency_contact_phone': emergency_contact_phone,
          'marital_status': marital_status,
          'occupation': occupation,
          'gender': gender,
          'habit': habit,
       
      },
    );


    if (insertedPatient != -1 ){
    print('Patient saved successfully.');
    print(insertedPatient);
    List insertedData = await db.query('patient', where: 'id = ?', whereArgs: [insertedPatient]);

    print(insertedData);
    }
  } catch (e) {
    print('Error saving patient: $e');
    throw e; 
  }
    
  }

  
  Future<int?> getPatientId() async {
  final db = await instance.database;

  final List<Map<String, dynamic>> maps = await db.query(
    'patient',
    columns: ['id'] 
  );

  if (maps.isNotEmpty) {
    return maps.first['id']as int;
  } else {
    return null;
  }
  }


   Future<Patient?> getPatient(int id) async {
    
    final db = await instance.database;

  
    final List<Map<String, dynamic>> maps = await db.query(
      'patient', 
      where: 'id = ?', 
      whereArgs: [id], 
    );

    if (maps.isNotEmpty) {
      return Patient.fromMap(maps.first);
    } else {
      print('faild');
      return null;
    }
  }


  
  Future<Map<String, dynamic>?> updatePatient(Patient patient) async {
    final db = await instance.database;

    await db.update(
      'patient',
      patient.toMap(), 
      where: 'id = ?', 
      whereArgs: [patient.id], 
    );
    print(patient.toMap());
    return null;
  }


  
  Future<Map<String, dynamic>?> getPatientProfile() async {
  final db = await instance.database;

  final List<Map<String, dynamic>> maps = await db.query(
    'patient',
    columns: ['id', 'fname', 'lname', 'email', 'gender', 'date_birth', 'home_add', 'phone', 'genotype', 'bloodgroup', 'weight', 'height', 'marital_status', 'emergency_contact_name', 'emergency_contact_phone','occupation','habit', 'allergies'],
  );

  if (maps.isNotEmpty) {
    return maps.first;
  } else {
    return null;
  }
}







  Future<void> insertDoctor({
  required String fname,
  required String lname,
  required String password,
  required String email,
  required String phone,
  required String gender,
  required String date_birth,
  required String home_add,
  required String clinic_name,
  required String clinic_address,
  required String speciality,
  required String department,
  required String marital_status,
  required String imageUrl,



}) async {
  final db = await database;
  try {
   int insertedDoctor = await db.insert(
      'doctor',
      {
        'fname': fname,
        'lname': lname,
        'email': email,
        'phone': phone,
        'password': password,
        'gender': gender,
        'date_birth':date_birth,
        'home_add':home_add,
        'clinic_name':clinic_name,
        'clinic_address': clinic_address,
        'speciality': speciality,
        'department':department,
        'marital_status':marital_status,
        'imageUrl':imageUrl

      },
    );
    if (insertedDoctor != -1 ){
    print('Doctor saved successfully.');
    print(insertedDoctor);
    List insertedData = await db.query('doctor', where: 'id = ?', whereArgs: [insertedDoctor]);

    print(insertedData);
    }
  } catch (e) {
    print('Error saving doctor: $e');
    throw e; 
  }
}



  Future<Map<String, dynamic>?> updateDoctor(Doctor doctor) async {
    final db = await instance.database;

    await db.update(
      'doctor',
      doctor.toMap(), 
      where: 'id = ?', 
      whereArgs: [doctor.id], 
    );
    print(doctor.toMap());
    return null;
  }


  Future<Map<String, dynamic>?> getDoctorProfile() async {
  final db = await instance.database;

  final List<Map<String, dynamic>> maps = await db.query(
    'doctor',
    columns: ['id', 'fname', 'lname', 'email', 'gender', 'date_birth', 'home_add', 'phone', 'clinic_name', 'clinic_address', 'speciality', 'department', 'marital_status', 'imageUrl'],
  );

  if (maps.isNotEmpty) {
    return maps.first;
  } else {
    return null;
  }
}


  Future<int?> getDoctorId() async {
  final db = await instance.database;

  final List<Map<String, dynamic>> maps = await db.query(
    'doctor',
    columns: ['id'], 
  );

  if (maps.isNotEmpty) {
    return maps.first['id'] as int;
  } else {
    return null;
  }
  }

  Future<Doctor?> getDoctor(int id) async {
    
    final db = await instance.database;

  
    final List<Map<String, dynamic>> maps = await db.query(
      'doctor', 
      where: 'id = ?', 
      whereArgs: [id], 
    );

    if (maps.isNotEmpty) {
      return Doctor.fromMap(maps.first);
    } else {
      return null;
    }
  }



  
   Future<void> insertAppointment({
    required String fname,
    required String lname,
    required String email,
    required String phone,
    required String doctor_name,
    required String reason,
    required String date_time,
    
  }) async {
    final db = await database;
    try{
    int insertedappointmentId = await db.insert(
      'appointment', 
      {
        'fname': fname,
        'lname': lname,
        'email': email,
        'phone': phone,
        'doctor_name': doctor_name,
        'reason': reason,
        'date_time': date_time

      },
    );
    
    if (insertedappointmentId != -1) {
      print('Appointment inserted with ID: $insertedappointmentId');

      final insertedData = await db.query('appointment', where: 'id = ?', whereArgs: [insertedappointmentId]);
      print('Inserted Data: $insertedData');
    } else {
      print('Failed to insert appointment.');
    }
  } catch (e) {
    print('Error inserting appointment: $e');
  }
    
  }


  Future<void> insertStatus({
    required String status

  })async{
    final db = await database;
     try{
    int insertedStatusId = await db.insert(
      'appointment_status',
      {
      'status': status
      },
    );
    
    if (insertedStatusId != -1) {
      print('Status inserted with ID: $insertedStatusId');

      final insertedData = await db.query('appointment_status', where: 'id = ?', whereArgs: [insertedStatusId]);
      print('Inserted Data: $insertedData');
    } else {
      print('Failed to insert status.');
    }
   } catch (e) {
    print('Error inserting status: $e');
  }

  }


Future<List<AllDoctors>> getAllDoctors() async {
  final db = await database;
  
  try {
    final List<Map<String, dynamic>> maps = await db.query('doctor');
    print('Query returned ${maps.length} rows from the database.');
    List<AllDoctors> doctorsList = List.generate(maps.length, (index) {
      AllDoctors doctor = AllDoctors(
        doc_id: maps[index]['id'],
        doc_fname: maps[index]['fname'],
        doc_lname: maps[index]['lname'],
        doc_speciality: maps[index]['speciality'],
        doc_department: maps[index]['department'],
        doc_clinic_name: maps[index]['clinic_name'],
      );
      // Print doctor properties for debugging
      print('Doctor ${index + 1}: ${doctor.doc_fname} ${doctor.doc_lname}, ${doctor.doc_department}');
      return doctor;
    }); 
    print('Generated ${doctorsList.length} AllDoctors objects.');
    return doctorsList;
  } catch (e) {
    print('Error fetching doctors: $e');
    return [];
  }
}




  
  Future<List<Person>> getAllAppointments() async {
    final db = await database;
    try {
    final List<Map<String, dynamic>> maps = await db.query('appointment');
     
    return List.generate(maps.length, (index) {
      return Person(
        id: maps[index]['id'],
        firstname: maps[index]['fname'],
        lastname: maps[index]['lname'],
        email: maps[index]['email'],
        phone: maps[index]['phone'],
        doctorName: maps[index]['doctor_name'],
        // department: maps[index]['department'],
        reason: maps[index]['reason'],
        date_time: maps[index]['date_time'],
      );
    });
     } catch (e) {
        print('Error fetching appointments: $e');
    return [];
  }

  }



Future<List<Status>> getAllStatus() async {
  final db = await database;
    try {
    final List<Map<String, dynamic>> maps = await db.query('appointment_status');
    return List.generate(maps.length, (index) {
      return Status(
        status: maps[index]['status'],
      );
      });
     } catch (e) {
        print('Error fetching appointments: $e');
    return [];
  }
}

 static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();



Future<List<AppointmentData>> getAllAppointmentsWithStatus() async {
  final db = await database;

  try {
    final List<Map<String, dynamic>> appointmentMaps = await db.query('appointment');
    final List<Map<String, dynamic>> statusMaps = await db.query('appointment_status');

    List<AppointmentData> appointments = [];

    for (int i = 0; i < appointmentMaps.length && i < statusMaps.length; i++) {
      final person = Person(
        id: appointmentMaps[i]['id'],
        firstname: appointmentMaps[i]['fname'],
        lastname: appointmentMaps[i]['lname'],
        email: appointmentMaps[i]['email'],
        phone: appointmentMaps[i]['phone'],
        doctorName: appointmentMaps[i]['doctor_name'],
        // department: appointmentMaps[i]['department'],
        reason: appointmentMaps[i]['reason'],
        date_time: appointmentMaps[i]['date_time'],
      );

      final status = Status(
        status: statusMaps[i]['status'],
      );

      appointments.add(AppointmentData(person: person, status: status));
    }

    return appointments;
  } catch (e) {
    print('Error fetching appointments with status: $e');
    return [];
  }
}


}



