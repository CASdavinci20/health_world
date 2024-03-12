import 'dart:async';
import 'doctorprofile.dart';
import 'package:flutter/material.dart';
import 'database.dart';
import 'doctorsignup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'class.dart';
import 'package:provider/provider.dart';



class DoctorRegistrationPage extends StatefulWidget {
  const DoctorRegistrationPage({super.key});
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  static final TextEditingController fnameController = TextEditingController();
  static final TextEditingController lnameController = TextEditingController();
  static final TextEditingController passwordController = TextEditingController();
  static final TextEditingController emailController = TextEditingController();
  static final TextEditingController dobController = TextEditingController();
  static final TextEditingController phoneController = TextEditingController();
  static final TextEditingController genderController = TextEditingController();
  static final TextEditingController homeAddController = TextEditingController();
  static final TextEditingController clinicController = TextEditingController();
  static final TextEditingController clinicaddController = TextEditingController();
  static final TextEditingController departmentController = TextEditingController();
  static final TextEditingController specialtyController = TextEditingController();
  static final TextEditingController maritalController = TextEditingController();
  static final TextEditingController imageUrlController = TextEditingController();



  @override
  _DoctorRegistrationPageState createState() => _DoctorRegistrationPageState();
  
}

class _DoctorRegistrationPageState extends State<DoctorRegistrationPage> {
  final _formKey = GlobalKey<FormState>();

  SharedPreferences? _prefs;

   TextEditingController _fnameController = TextEditingController();
  TextEditingController _lnameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
   TextEditingController   _homeAddController = TextEditingController();
   TextEditingController   _clinicController = TextEditingController();
   TextEditingController   _specialtyController = TextEditingController();
   TextEditingController   _maritalController = TextEditingController();
   TextEditingController   _clinicaddController = TextEditingController();
   TextEditingController   _departmentController = TextEditingController();
   TextEditingController   _imageUrlController = TextEditingController();

 final DatabaseHelper _databaseHelper = DatabaseHelper.instance;


void clearDoctorProfile() {
  print('Doctor Profile Cleared');
}
 
  @override
  void initState() {
    super.initState(); 
    _fetchPatientProfileData();   
  }



  void _fetchPatientProfileData() async {
  int? doctorId = await _databaseHelper.getDoctorId(); 
  if (doctorId != null) {
    Doctor? doctor = await _databaseHelper.getDoctor(doctorId);

    if (doctor != null) {
      _fnameController.text = doctor.fname;
      _lnameController.text = doctor.lname;
      _emailController.text = doctor.email;
      _phoneController.text = doctor.phone;
      _passwordController.text = doctor.password;
      _genderController.text = doctor.gender;
      _dobController.text = doctor.date_birth;
      _homeAddController.text = doctor.home_add;
      _clinicController.text = doctor.clinic_name;
      _clinicaddController.text = doctor.clinic_address;
      _specialtyController.text = doctor.speciality;
      _departmentController.text = doctor.department;
      _maritalController.text = doctor.marital_status;
      _imageUrlController.text = doctor.imageUrl;

      // // Clear form if the retrieved data matches the data in the text controllers
      // if (_fnameController.text == doctor.fname &&
      //     _lnameController.text == doctor.lname &&
      //     _emailController.text == doctor.email &&
      //     _phoneController.text == doctor.phone &&
      //     _passwordController.text == doctor.password &&
      //     _genderController.text == doctor.gender &&
      //     _dobController.text == doctor.date_birth &&
      //     _homeAddController.text == doctor.home_add &&
      //     _clinicController.text == doctor.clinic_name &&
      //     _clinicaddController.text == doctor.clinic_address &&
      //     _specialtyController.text == doctor.speciality &&
      //     _departmentController.text == doctor.department &&
      //     _maritalController.text == doctor.marital_status &&
      //     _imageUrlController.text == doctor.imageUrl) {
        // clearForm();
      // }
    } else {
      print('Doctor data not found');
    }
  } else {
    print('Doctor ID not found');
  }
}




  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text(
          'Update Doctor Profile',
          style: TextStyle(
            color: Colors.lightBlueAccent,
            fontFamily: 'Agbalumo',
          ),
          ),
      ),
      body:SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 20, 30, 10),
        child: Form(
          key: _formKey,
          child:Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
              TextFormField(
              controller: _fnameController,
              decoration:const InputDecoration(labelText: 'First Name'),
            ),
           const SizedBox(height: 4.0),
             TextFormField(
              controller: _lnameController,
              decoration:const InputDecoration(labelText: 'Last Name'),
            ),
           const SizedBox(height: 4.0),
           
            TextFormField(
              controller: _genderController,
              decoration:const InputDecoration(labelText: 'Gender'),
               validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field cannot be empty';
                  }
                  return null; 
                },
            ),
           const SizedBox(height: 4.0),
            TextFormField(
              controller: _dobController,
              decoration:const InputDecoration(labelText: 'Date of Birth'),
              keyboardType: TextInputType.datetime,
               validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field cannot be empty';
                  }
                  return null; 
                },
            ),
           const SizedBox(height: 4.0),
             TextFormField(
              controller: _homeAddController,
              decoration:const InputDecoration(labelText: 'Home Address'),
             validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field cannot be empty';
                  }
                  return null; 
                },
            ),
           const SizedBox(height: 4.0),
            
              TextFormField(
              controller: _clinicController,
              decoration:const InputDecoration(labelText: 'Clinic Name'),
             validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field cannot be empty';
                  }
                  return null; 
                },
            ),
           const SizedBox(height: 4.0),
           TextFormField(
              controller: _clinicaddController,
              decoration:const InputDecoration(labelText: 'Clinic Address'),
              validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field cannot be empty';
                  }
                  return null; 
                },
            ),
           const SizedBox(height: 4.0),
             TextFormField(
              controller: _specialtyController,
              decoration:const InputDecoration(labelText: 'Speciality'),
              validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field cannot be empty';
                  }
                  return null; 
                },
            ),
           const SizedBox(height: 4.0),
           TextFormField(
              controller: _departmentController,
              decoration:const InputDecoration(labelText: 'Department'),
              validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field cannot be empty';
                  }
                  return null; 
                },
            ),
           const SizedBox(height: 4.0),
             TextFormField(
              controller: _maritalController,
              decoration:const InputDecoration(labelText: 'Marital Status'),
              validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field cannot be empty';
                  }
                  return null; 
                },
            ),
            const SizedBox(height: 4.0),
             TextFormField(
              controller: _imageUrlController,
              decoration:const InputDecoration(
                    labelText: 'Image URL',
                    hintText: 'Enter the image URL',
                  ),
              validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field cannot be empty';
                  }
                  return null; 
                },
            ),
           const SizedBox(height: 7.0),
            ElevatedButton(
  onPressed: () async {
  
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );
      
    
    // Ensure that all text controllers have valid values before inserting
                int? id =  await  _databaseHelper.getDoctorId();
                 if (id != null) {
                await _updateProfile(id);

                 final dbHelper = DatabaseHelper();

           final data = await dbHelper.getDoctorProfile(); // Call getDoctorProfile() on the instance
                     String? fname = data?['fname'];
                    String? lname = data?['lname'];
                    String? email = data?['email'];
                    String? gender = data?['gender'];
                    String? date_birth = data?['date_birth'];
                    String? home_add = data?['home_add'];
                    String? phone = data?['phone'];
                    String? clinic_name = data?['clinic_name'];
                    String? clinic_address = data?['clinic_address'];
                    String? speciality = data?['speciality'];
                    String? department = data?['department'];
                    String? marital_status = data?['marital_status'];
                    String? imageUrl = data?['imageUrl'];
  
   
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(fullscreenDialog: true,
        builder: (context) => DoctorProfilePage(data:{
          'fname':fname,
           'lname':lname,
            'email': email,
            'gender': gender,
            'date_birth': date_birth,
            'home_add': home_add,
            'phone': phone,
            'clinic_name': clinic_name,
            'clinic_address': clinic_address,
            'speciality': speciality,
            'department': department,
            'marital_status': marital_status,
            'imageUrl': imageUrl,
        },
        clearProfile: clearDoctorProfile,
        ),
        
      ),
      
    );
     

        } else {
           print('Doctor ID not found');
              }

    }
  },

               style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 92, 190, 236),
               padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 10),
                shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), 
            ),
            elevation: 4, 
             ),
              child:const Text(
                'Register',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
                ),
            ),
          ],
        ),
      ),
      ),
      ),
    );
  }


  Future<void> _saveDoctorDataInSharedPreferences(Doctor doctor) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('fname', _fnameController.text);
    prefs.setString('lname', _lnameController.text);
    prefs.setString('email', _emailController.text);
    prefs.setString('phone', _phoneController.text);
    prefs.setString('password', _passwordController.text);
    prefs.setString('gender', _genderController.text);
    prefs.setString('date_birth', _dobController.text);
    prefs.setString('home_add', _homeAddController.text);
    prefs.setString('clinic_name', _clinicController.text);
    prefs.setString('clinic_address', _clinicaddController.text);
    prefs.setString('speciality', _specialtyController.text);
    prefs.setString('department', _departmentController.text);
    prefs.setString('marital_status', _maritalController.text);
    prefs.setString('imageUrl', _imageUrlController.text);

    print('saved the rest');
  }



  Future<void> _updateProfile(int id) async {
    if (_formKey.currentState!.validate()) {
      try{

   Doctor  updatedDoctor =  Doctor (
        id: id,
        fname: _fnameController.text,
        lname: _lnameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        password: _passwordController.text,
        gender:       _genderController.text,
        date_birth:      _dobController.text,
        home_add:      _homeAddController.text, 
        clinic_name:      _clinicController.text,
        clinic_address:      _clinicaddController.text,
        speciality:      _specialtyController.text, 
        department:      _departmentController.text,
        marital_status:      _maritalController.text, 
        imageUrl:  _imageUrlController.text,
      );

     await  _databaseHelper.updateDoctor(updatedDoctor);
     print('$updatedDoctor updated doctor for here' );
    
    //   Doctor? doctorDetails = await _databaseHelper.getDoctor(id);
    //   if (doctorDetails != null &&
    //   doctorDetails.fname == updatedDoctor.fname &&
    // doctorDetails.lname == updatedDoctor.lname &&
    // doctorDetails.email == updatedDoctor.email &&
    // doctorDetails.phone == updatedDoctor.phone &&
    // doctorDetails.home_add == updatedDoctor.home_add &&
    // doctorDetails.date_birth == updatedDoctor.date_birth &&
    // doctorDetails.clinic_name == updatedDoctor.clinic_name &&
    // doctorDetails.clinic_address == updatedDoctor.clinic_address &&
    // doctorDetails.department == updatedDoctor.department &&
    // doctorDetails.speciality == updatedDoctor.speciality &&
    // doctorDetails.marital_status == updatedDoctor.marital_status &&
    // doctorDetails.imageUrl == updatedDoctor.imageUrl
    //   ) {
        

    _saveDoctorDataInSharedPreferences(updatedDoctor);
      //   print('$doctorDetails ffffffffffffffffff' );
      // } else {
      //   print('Doctor details not found');
      // }
 
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );
      print(updatedDoctor);
     } catch (e) {
       print('Error updating doctor: $e');
      rethrow; 
    }
    } else {
      throw Exception('Form is not valid');

    }
  }
  


}
