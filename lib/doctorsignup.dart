import 'package:flutter/material.dart';
import 'package:health_world/class.dart';
import 'doctor.dart';
import 'database.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Doctor {
  final int id;
  final String fname;
  final String lname;
  final String email;
  final String phone;
  final String password;
   final String gender;
   final String date_birth;
  final String home_add;
  final String clinic_name;
  final String clinic_address;
  final String speciality;
  final String department;
  final String marital_status;
  final String imageUrl;

  Doctor({
    required this.id,
    required this.fname,
    required this.lname,
    required this.email,
    required this.phone,
    required this.password,
     required this.gender,
    required this.date_birth,
    required this.home_add,
    required this.clinic_name,
    required this.clinic_address,
    required this.speciality,
    required this.department,
    required this.marital_status,
    required this.imageUrl,
  });

  @override
  String toString() {
    return 'doctor(id: $id, fname: $fname, lname: $lname, email: $email, phone: $phone, password: $password, '
        'gender: $gender, date_birth: $date_birth, home_add: $home_add, clinic_name: $clinic_name, '
        'clinic_address: $clinic_address, speciality: $speciality, department: $department, '
        'marital_status: $marital_status, imageUrl: $imageUrl)';
  }


  factory Doctor.fromMap(Map<String, dynamic> map) {
    return Doctor(
      id: map['id'],
      fname: map['fname'],
      lname: map['lname'],
      email: map['email'],
      phone: map['phone'],
      password: map['password'],
      gender: map['gender'],
      date_birth: map['date_birth'],
      home_add: map['home_add'],
      clinic_name: map['clinic_name'],
      clinic_address: map['clinic_address'],
      speciality: map['speciality'],
      department: map['department'],
      marital_status: map['marital_status'],
      imageUrl: map['imageUrl'],
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
      'clinic_name': clinic_name,
      'clinic_address': clinic_address,
      'speciality': speciality,
      'department': department,
      'marital_status': marital_status,
      'imageUrl': imageUrl,
    };
  }
}


class DoctorSignupPage extends StatefulWidget {
  const DoctorSignupPage({super.key});

  @override
 _DoctorSignupPageState createState() => _DoctorSignupPageState();

}

class _DoctorSignupPageState extends State<DoctorSignupPage> {
  SharedPreferences? _prefs;


  final _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  final _phoneRegex = RegExp(r'^[0-9]{10,13}$');


  final _formKey = GlobalKey<FormState>();

  TextEditingController _fnameController = TextEditingController();
  TextEditingController _lnameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  void _saveDoctorDataInSharedPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('fname', _fnameController.text);
  prefs.setString('lname', _lnameController.text);
  prefs.setString('email', _emailController.text);
  prefs.setString('phone', _phoneController.text);
  prefs.setString('password', _passwordController.text);
  prefs.setString('gender', '');
  prefs.setString('date_birth', '');
  prefs.setString('home_add', '');
  prefs.setString('clinic_name', '');
  prefs.setString('clinic_address', '');
  prefs.setString('speciality', '');
  prefs.setString('department', '');
  prefs.setString('marital_status', '');
  prefs.setString('imageUrl', '');
}
 @override
void initState() {
  super.initState();
  _loadSharedPreferences();
}

void _loadSharedPreferences() async {
  _prefs = await SharedPreferences.getInstance();
}

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text(
          'Login Page',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.lightBlueAccent,
            fontFamily: 'Agbalumo',
          ),
          ),
      ),
      body:SingleChildScrollView( 
     child:  Padding(
        padding: const EdgeInsets.all(25.0),
        child:Form(
          key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _fnameController,
              decoration:const InputDecoration(
                labelText: 'First Name',
                 labelStyle: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
                 enabledBorder: OutlineInputBorder(
                   borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                   borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
               validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field cannot be empty';
                  }
                  return null; 
                },
                ),
            SizedBox(height: 16.0),
              TextFormField(
              controller: _lnameController,
              decoration:const InputDecoration(
                labelText: 'Last Name',
                 labelStyle: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
                 enabledBorder: OutlineInputBorder(
                   borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                   borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
               validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field cannot be empty';
                  }
                  return null; 
                },
             ), 
             const SizedBox(height: 16,),
            TextFormField(
              controller: _emailController,
              obscureText: false, 
              decoration:const InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
                enabledBorder: OutlineInputBorder(
                   borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                   borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
               validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field cannot be empty';
                  } else if (!_emailRegex.hasMatch(value)) {
                     return 'Enter a valid email';
                  }
                  return null; 
                },
            ),
            const SizedBox(height: 16,),
             TextFormField(
              controller: _phoneController,
              decoration:const InputDecoration(
                labelText: 'Phone Number',
                 labelStyle: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
                 enabledBorder: OutlineInputBorder(
                   borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                   borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
               validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field cannot be empty';
                  }else if (!_phoneRegex.hasMatch(value)) {
                      return 'Enter a valid phone number';
                  }
                  return null; 
                },
             ), 
             const SizedBox(height: 16,),
             TextFormField(
              controller: _passwordController,
              decoration:const InputDecoration(
                labelText: 'Create Password',
                 labelStyle: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
                 enabledBorder: OutlineInputBorder(
                   borderSide: BorderSide(color: Colors.lightBlue, width: 2.0),
                   borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
               validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field cannot be empty';
                  }
                  return null; 
                },
             ), 
            const SizedBox(height: 24,),
            ElevatedButton(
              
           onPressed: () async {
                 if ( _formKey.currentState!.validate()) {
                     ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );
      try {
             await   _databaseHelper.insertDoctor(
                  fname : _fnameController.text,
                  lname: _lnameController.text,
                  email: _emailController.text,
                  phone: _phoneController.text,
                  password: _passwordController.text,
                  gender: '',
                  date_birth: '',
                  home_add: '',
                  clinic_name: '',
                  clinic_address: '',
                  speciality: '',
                  department: '',
                  marital_status: '',
                  imageUrl: '',
                );
                _saveDoctorDataInSharedPreferences();
                 
  

        print('Doctor saved successfully.');
                  Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DoctorPage()),
            );
              } catch (e) {
                 print('Error saving doctor: $e');
           }
            }else{
              print('All form must be filled');
            }

           },
                style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlueAccent,
                 padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                  shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 4, 
               ),
              child:const Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  
                ),
                ),
            ),
          ],
        ),
      ),
       ),
         )
      );
  }

//   Future<void> _retrieveDoctorDataFromSharedPreferences() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
  

//   String? fname = prefs.getString('fname');
//   String? lname = prefs.getString('lname');
//   String? email = prefs.getString('email');
//   String? phone = prefs.getString('phone');
//   String? password = prefs.getString('password');
//   String? gender = prefs.getString('gender');
//   String? dateOfBirth = prefs.getString('date_birth');
//   String? homeAddress = prefs.getString('home_add');
//   String? clinicName = prefs.getString('clinic_name');
//   String? clinicAddress = prefs.getString('clinic_address');
//   String? speciality = prefs.getString('speciality');
//   String? department = prefs.getString('department');
//   String? maritalStatus = prefs.getString('marital_status');
//   String? imageUrl = prefs.getString('imageUrl');

//   if (fname != null &&
//       lname != null &&
//       email != null &&
//       phone != null &&
//       password != null &&
//       gender != null &&
//       dateOfBirth != null &&
//       homeAddress != null &&
//       clinicName != null &&
//       clinicAddress != null &&
//       speciality != null &&
//       department != null &&
//       maritalStatus != null &&
//       imageUrl != null) {
//     Doctor doctor = Doctor(
//       id: 0, 
//       fname: fname,
//       lname: lname,
//       email: email,
//       phone: phone,
//       password: password,
//       gender: gender ?? '',
//       date_birth: dateOfBirth ?? '',
//       home_add: homeAddress?? '',
//       clinic_name: clinicName?? '',
//       clinic_address: clinicAddress?? '',
//       speciality: speciality?? '',
//       department: department?? '',
//       marital_status: maritalStatus?? '',
//       imageUrl: imageUrl?? '',
//     );

//     // Do something with the retrieved Doctor object, such as displaying the data or using it for further operations
//     print('Retrieved Doctor data: $doctor');
//   } else {
//     // Handle the case where any required field is missing
//     print('Error: Doctor data is incomplete');
//   }
// }
}