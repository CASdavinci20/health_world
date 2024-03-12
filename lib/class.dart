import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class DoctorProfile extends ChangeNotifier {
  late String fname;
  late String lname;
  late String email;
  late String gender;
  late String password;
  late String date_birth;
  late String home_add;
  late String phone;
  late String clinic_name;
  late String clinic_address;
  late String speciality;
  late String department;
  late String marital_status;
  late String imageUrl;




    DoctorProfile({
    required this.fname,
    required this.lname,
    required this.email,
    required this.gender,
    required this.password,
    required this.date_birth,
    required this.home_add,
    required this.phone,
    required this.clinic_name,
    required this.clinic_address,
    required this.speciality,
    required this.department,
    required this.marital_status,
    required this.imageUrl,
  });


 factory DoctorProfile.fromDatabase(Map<String, dynamic> data) {
    return DoctorProfile(
      fname: data['fname'],
      lname: data['lname'],
      email: data['email'],
      gender: data['gender'],
      password:data['password'],
      date_birth: data['date_birth'],
      home_add: data['home_add'],
      phone: data['phone'],
      clinic_name: data['clinic_name'],
      clinic_address: data['clinic_address'],
      speciality: data['speciality'],
      department: data['department'],
      marital_status: data['marital_status'],
      imageUrl: data['imageUrl'],
    );
  }
  

  void updateProfile({
    required String fname,
    required String lname,
    required String email,
    required String gender,
    required String date_birth,
    required String home_add,
    required String phone,
    required String clinic_name,
    required String clinic_address,
    required String speciality,
    required String department,
    required String marital_status,
    required String imageUrl,

  }) {
    this.fname = fname;
    this.lname = lname;
     this.email = email;
    this.gender = gender;
     this.date_birth = date_birth;
    this.home_add  = home_add;
    this.phone = phone;
     this.clinic_name = clinic_name;
    this.clinic_address = clinic_address;
     this.speciality = speciality;
    this.department = department;
     this.marital_status = marital_status;
    this.imageUrl = imageUrl;
    notifyListeners(); 
  }

  void clearData({
    bool clearFname= true,
    bool clearLname= true,
    bool clearEmail= true,
    bool clearGender= true,
    bool clearPhone= true,
    bool clearMarital_status= true,
    bool claerSpeciality= true,
    bool clearDepartment= true,
    bool clearDate_birth= true,
    bool clearClinic_address= true,
    bool clearClinic_name= true,
    bool clearHome_add= true,
    bool clearImageUrl= true,
  }) {

  print('Before clearing:');
  print('fname: $fname');
  print('lname: $lname');
  print('gender: $gender');
  print('phone: $phone');
  print('marital_status: $marital_status');
  print('speciality: $speciality');

  if (clearFname) {
    fname = ''; 
    lname = '';
    email = '';
    phone = '';
    gender = '';
    marital_status ='';
    speciality = '';
    department = '';
    clinic_address = '';
    clinic_name = '';
    date_birth = '';
    home_add = '';
    imageUrl = '';
        
  print('After clearing:');
  print('fname: $fname');
  print('lname: $lname');
  print('gender: $gender');
  print('phone: $phone');
  print('marital_status: $marital_status');
  print('speciality: $speciality');

    notifyListeners();

  }
  }
}
  

class DoctorData extends ChangeNotifier {
  String fname = '';
  String lname = '';
  String email = '';
  String phone = '';

  void updateData({required String fname, required String lname, required String email, required String phone}) {
    this.fname = fname;
    this.lname = lname;
    this.email = email;
    this.phone = phone;
    notifyListeners();
  }
}



class Patient {
  final int id;
  final String fname;
  final String lname;
  final String email;
  final String phone;
  final String password;
   final String gender;
   final String date_birth;
  final String home_add;
  final String bloodgroup;
  final String genotype;
  final String height;
  final String weight;
  final String marital_status;
  final String emergency_contact_name;
  final String emergency_contact_phone;
  final String habit;
  final String allergies;
   final String occupation;

  Patient({
    required this.id,
    required this.fname,
    required this.lname,
    required this.email,
    required this.phone,
    required this.password,
     required this.gender,
    required this.date_birth,
    required this.home_add,
    required this.bloodgroup,
    required this.weight,
    required this.height,
    required this.genotype,
    required this.marital_status,
    required this.allergies,
    required this.habit,
    required this.emergency_contact_name,
    required this.emergency_contact_phone,
    required this.occupation,

  });

  @override
  String toString() {
    return 'patient(id: $id, fname: $fname, lname: $lname, email: $email, phone: $phone, password: $password, '
        'gender: $gender, date_birth: $date_birth, home_add: $home_add, weight: $weight, '
        'genotype: $genotype, bloodgroup: $bloodgroup, height: $height, '
        'marital_status: $marital_status, allergies: $allergies, emergency_contact_name: $emergency_contact_name, emergency_contact_phone: $emergency_contact_phone, habit: $habit, occupation: $occupation)';
  }


  factory Patient.fromMap(Map<String, dynamic> map) {
    return Patient(
      id: map['id'],
      fname: map['fname'],
      lname: map['lname'],
      email: map['email'],
      phone: map['phone'],
      password: map['password'],
      gender: map['gender'],
      date_birth: map['date_birth'],
      home_add: map['home_add'],
      bloodgroup: map['bloodgroup'],
      genotype: map['genotype'],
      weight: map['weight'],
      height: map['height'],
      marital_status: map['marital_status'],
      emergency_contact_name: map['emergency_contact_name'],
      emergency_contact_phone: map['emergency_contact_phone'],
      habit: map['habit'],
      occupation: map['occupation'],
      allergies: map['allergies'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fname': fname,
      'lname': lname,
      'email': email,
      'phone': phone,
      'password':password,
      'gender': gender,
      'date_birth': date_birth,
      'home_add': home_add,
      'bloodgroup': bloodgroup,
      'genotype': genotype,
      'weight': weight,
      'height': height,
      'marital_status': marital_status,
      'emergency_contact_name': emergency_contact_name,
      'emergency_contact_phone': emergency_contact_phone,
      'habit': habit,
      'occupation': occupation,
      'allergies': allergies,
    };
  }
}


class PatientProfile extends ChangeNotifier {
  late String fname;
  late String lname;
  late String email;
  late String gender;
  late String password;
  late String date_birth;
  late String home_add;
  late String phone;
  late String marital_status;
  late String bloodgroup;
  late String genotype;
  late String height;
  late String weight;
  late String emergency_contact_name;
  late String emergency_contact_phone;
  late String habit;
  late String allergies;
   late String occupation;


    PatientProfile({
    required this.fname,
    required this.lname,
    required this.email,
    required this.gender,
    required this.password,
    required this.date_birth,
    required this.home_add,
    required this.phone,
    required this.marital_status,
    required this.bloodgroup,
    required this.weight,
    required this.height,
    required this.genotype,
    required this.allergies,
    required this.habit,
    required this.emergency_contact_name,
    required this.emergency_contact_phone,
    required this.occupation,
  });


 factory PatientProfile.fromDatabase(Map<String, dynamic> data) {
    return PatientProfile(
      fname: data['fname'],
      lname: data['lname'],
      email: data['email'],
      gender: data['gender'],
      password:data['password'],
      date_birth: data['date_birth'],
      home_add: data['home_add'],
      phone: data['phone'],
      marital_status: data['marital_status'],
      bloodgroup: data['bloodgroup'],
      genotype: data['genotype'],
      weight: data['weight'],
      height: data['height'],
      emergency_contact_name: data['emergency_contact_name'],
      emergency_contact_phone: data['emergency_contact_phone'],
      habit: data['habit'],
      occupation: data['occupation'],
      allergies: data['allergies'],
      
    );
  }
  

  void updatePatientProfile({
    required String fname,
    required String lname,
    required String email,
    required String gender,
    required String date_birth,
    required String home_add,
    required String phone,
    required String bloodgroup,
    required String marital_status,
  required String genotype,
  required String height,
  required String weight,
  required String emergency_contact_name,
  required String emergency_contact_phone,
  required String habit,
  required String allergies,
   required String occupation,


  }) {
    this.fname = fname;
    this.lname = lname;
    this.email = email;
    this.gender = gender;
    this.date_birth = date_birth;
    this.home_add  = home_add;
    this.phone = phone;
    this.marital_status = marital_status;
    this.bloodgroup = bloodgroup;
    this.weight = weight;
    this.height =height; 
    this.genotype = genotype;
    this.allergies =allergies;
    this.habit = habit;
    this.emergency_contact_name = emergency_contact_name;
    this.emergency_contact_phone = emergency_contact_phone;
    this.occupation = occupation;
    notifyListeners(); 
  }


  void clearPatientData(
    {
    bool clearFname= true,
    bool clearLname= true,
    bool clearEmail= true,
    bool clearGender= true,
    bool clearPhone= true,
    bool clearMarital_status= true,
    bool clearHome_add= true,
    bool  clearbloodgroup = true,
    bool clearweight = true,
    bool clearheight =  true,
    bool cleargenotype = true,
    bool clearallergies = true,
    bool clearhabit = true,
    bool clearemergency_contact_name = true,
    bool clearemergency_contact_phone = true,
    bool clearoccupation = true,
      
    
  }) {

  print('Before clearing:');
  print('fname: $fname');
  print('lname: $lname');
  print('gender: $gender');
  print('phone: $phone');
  print('marital_status: $marital_status');
  print('bloodgroup: $bloodgroup');

  
    fname = '';
    lname = '';
    email = '';
    gender = '';
    date_birth = '';
    home_add  = '';
    phone = '';
    marital_status = '';
    bloodgroup = '';
    weight = '';
    height =''; 
    genotype = '';
    allergies ='';
    habit = '';
    emergency_contact_name = '';
    emergency_contact_phone = '';
    occupation = '';
      
  print('After clearing:');
  print('fname: $fname');
  print('lname: $lname');
   print('gender: $gender');
  print('phone: $phone');
  print('marital_status: $marital_status');
  print('speciality: $bloodgroup');

    notifyListeners();

  }
}

class PatientData extends ChangeNotifier {
  String fname = '';
  String lname = '';
  String email = '';
  String phone = '';

  void updatePatientData({required String fname, required String lname, required String email, required String phone}) {
    this.fname = fname;
    this.lname = lname;
    this.email = email;
    this.phone = phone;
    notifyListeners();
  }
}



class AllDoctors {
  final int doc_id;
  final String doc_fname;
  final String doc_lname;
  final String doc_department;
  final String doc_speciality;
  final String doc_clinic_name;

  AllDoctors({
    required this.doc_id,
    required this.doc_fname,
    required this.doc_lname,
    required this.doc_department,
    required this. doc_speciality,
    required this. doc_clinic_name
  });
}








