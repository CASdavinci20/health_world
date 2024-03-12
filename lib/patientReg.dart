import 'package:flutter/material.dart';
import 'database.dart';
import 'class.dart';
import 'patientprofile.dart';


class PatientRegistrationPage extends StatefulWidget {
  
   const PatientRegistrationPage({super.key});
   static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

   static final TextEditingController fnameController = TextEditingController();
  static final TextEditingController lnameController = TextEditingController();
  static final TextEditingController passwordController = TextEditingController();
  static final TextEditingController emailController = TextEditingController();
  static final TextEditingController phoneController = TextEditingController();
  static final TextEditingController dobController = TextEditingController();
  static final  TextEditingController homeAddController = TextEditingController();
   static final TextEditingController   bloodGController = TextEditingController();
     static final TextEditingController   genotypeController = TextEditingController();
   static final TextEditingController   heightController = TextEditingController();
   static final TextEditingController   weightController = TextEditingController();
   static final TextEditingController   allegController = TextEditingController();
   static final TextEditingController   emergencyNameController = TextEditingController();
   static final TextEditingController   emergencyphoneController = TextEditingController();
   static final TextEditingController   workController = TextEditingController();
   static final TextEditingController   genderController = TextEditingController();
   static final TextEditingController   maritalController = TextEditingController();
   static final TextEditingController   habitController = TextEditingController();
  
  @override
  _PatientRegistrationPageState createState() => _PatientRegistrationPageState();
}

class _PatientRegistrationPageState extends State<PatientRegistrationPage> {

    final _formKey = GlobalKey<FormState>();
  
    
  
  TextEditingController _fnameController = TextEditingController();
  TextEditingController _lnameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
   TextEditingController   _homeAddController = TextEditingController();
   TextEditingController   _bloodGController = TextEditingController();
   TextEditingController   _genotypeController = TextEditingController();
   TextEditingController   _heightController = TextEditingController();
   TextEditingController   _weightController = TextEditingController();
   TextEditingController   _allegController = TextEditingController();
   TextEditingController   _emergencyNameController = TextEditingController();
   TextEditingController   _emergencyphoneController = TextEditingController();
   TextEditingController   _workController = TextEditingController();
   TextEditingController   _genderController = TextEditingController();
   TextEditingController   _maritalController = TextEditingController();
   TextEditingController   _habitController = TextEditingController();

    final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

     
  @override
  void initState() {
    super.initState();
    _fetchPatientProfileData();
  }

  void _fetchPatientProfileData() async {
    int? patientId = await _databaseHelper.getPatientId(); 
     if (patientId != null) {
      Patient? patient = await _databaseHelper.getPatient(patientId);


    if (patient != null) {
    _fnameController.text = patient.fname;
    _lnameController.text = patient.lname;
    _emailController.text = patient.email;
    _phoneController.text = patient.phone;
    _passwordController.text =patient.password;
    _genderController.text = patient.gender;
    _dobController.text = patient.date_birth;
    _homeAddController.text = patient.home_add;
    _bloodGController.text = patient.bloodgroup;
    _heightController.text = patient.height;
    _weightController.text = patient.weight;
    _genotypeController.text = patient.genotype;
    _maritalController.text = patient.marital_status;
    _emergencyNameController.text = patient.emergency_contact_name;
    _emergencyphoneController.text = patient.emergency_contact_phone;
    _allegController.text = patient.allergies;
    _habitController.text = patient.habit;
    _workController.text = patient.occupation;
    }else{
      print('Patient data not found');
    }
     } else {
    print('Patient ID not found');
   }
  }


void clearDoctorProfile() {
  print('Doctor Profile Cleared');
}



  void clearPatientForm() {
    _formKey.currentState?.reset();
    _fnameController.clear();
    _lnameController.clear();
    _passwordController.clear();
    _emailController.clear();
    _phoneController.clear();
    _dobController.clear();
    _genderController.clear();
    _homeAddController.clear();
    _maritalController.clear();
     _bloodGController.clear();
  _heightController.clear();
  _weightController.clear();
  _genotypeController.clear();
  _maritalController.clear();
  _emergencyNameController.clear();
  _emergencyphoneController.clear();
  _allegController.clear();
  _habitController.clear();
  _workController.clear();
   
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text(
          'Update Patient Profile',
          style: TextStyle(
            color: Colors.lightBlueAccent,
            fontFamily: 'Agbalumo',
            fontSize: 20,
          ),
          ),
      ),
      body:SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 20, 30, 10),
        child:Form(
          key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _fnameController,
              decoration:const InputDecoration(labelText: 'First Name'),
               validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field cannot be empty';
                  }
                  return null; 
                },
            ),
           const SizedBox(height: 4.0),
            TextFormField(
              controller: _lnameController,
              decoration:const InputDecoration(labelText: 'Last Name'),
               validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field cannot be empty';
                  }
                  return null; 
                },
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
              controller: _bloodGController,
              decoration:const InputDecoration(labelText: 'Blood Group'),
               validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field cannot be empty';
                  }
                  return null; 
                },
            ),
           const SizedBox(height: 4.0),
             TextFormField(
              controller: _genotypeController,
              decoration:const InputDecoration(labelText: 'Genotype'),
               validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field cannot be empty';
                  }
                  return null; 
                },
            ),
           const SizedBox(height: 4.0),
             TextFormField(
              controller: _heightController,
              decoration:const InputDecoration(labelText: 'Height'),
               validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field cannot be empty';
                  }
                  return null; 
                },
            ),
             const SizedBox(height: 4.0),
             TextFormField(
              controller: _weightController,
              decoration:const InputDecoration(labelText: 'Weight'),
               validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field cannot be empty';
                  }
                  return null; 
                },
            ),
           
            const SizedBox(height: 4.0),
             TextFormField(
              controller: _allegController,
              decoration:const InputDecoration(labelText: 'Allergies'),
               validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field cannot be empty';
                  }
                  return null; 
                },
            ),
             TextFormField(
              controller: _emergencyNameController,
              decoration:const InputDecoration(labelText: 'Emergency Contact Name'),
               validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field cannot be empty';
                  }
                  return null; 
                },
            ),
           const SizedBox(height: 4.0),
            TextFormField(
              controller: _emergencyphoneController,
              decoration:const InputDecoration(labelText: 'Emergency Contact Phone'),
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
              decoration:const InputDecoration(labelText: 'Relationship with Contact'),
               validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field cannot be empty';
                  }
                  return null; 
                },
            ),
            const SizedBox(height: 4.0),
             TextFormField(
              controller: _workController,
              decoration:const InputDecoration(labelText: 'Occupation'),
               validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field cannot be empty';
                  }
                  return null; 
                },
            ),
            const SizedBox(height: 4.0),
             TextFormField(
              controller: _habitController,
              decoration:const InputDecoration(labelText: 'Habit'),
               validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field cannot be empty';
                  }
                  return null; 
                },
            ),
            

           const SizedBox(height: 7.0),
            ElevatedButton(
              
              onPressed: () async{
  
        if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );
    
    // Ensure that all text controllers have valid values before inserting
                int? id =  await  _databaseHelper.getPatientId();
                 if (id != null) {
                await _updatePatientProfile(id);
                try {
                    final dbHelper = DatabaseHelper(); // Create an instance of DatabaseHelper

           final data = await dbHelper.getPatientProfile();

           
                     String? fname = data?['fname']?? '';
                    String? lname = data?['lname']?? '';
                    String? email = data?['email']?? '';
                    String? gender = data?['gender']?? '';
                    String? date_birth = data?['date_birth']?? '';
                    String? home_add = data?['home_add']?? '';
                    String? phone = data?['phone']?? '';
                    String? marital_status = data?['marital_status']?? '';
                    String? height =data?['height']?? '';
                    String? weight = data?['weight']?? '';
                    String? bloodgroup = data?['bloodgroup']?? '';
                    String? genotype = data?['genotype']?? '';
                    String? allergies = data?['allergies']?? '';
                    String? emergency_contact_name = data?['emergency_contact_name']?? '';
                    String? emergency_contact_phone = data?['emergency_contact_phone']?? '';
                    String? occupation = data?['occupation']?? '';
                    String? habit = data?['habit']?? '';


                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>   PatientProfilePage(data:{
                          'fname':fname,
                          'lname':lname,
                            'email': email,
                            'gender': gender,
                            'date_birth': date_birth,
                            'home_add': home_add,
                            'phone': phone,
                            'marital_status':marital_status,
                            'height': height,
                            'weight':weight,
                            'genotype':genotype,
                            'bloodgroup':bloodgroup,
                            'emergency_contact_name':emergency_contact_name,
                            'emergency_contact_phone':emergency_contact_phone,
                            'occupation':occupation,
                            'habit':habit,
                            'allergies':allergies,
        } 
        ),
      ),
    );
  } catch (error) {
    print('Error fetching doctor data: $error');
  }
                 } else {
                print('Patient ID not found');
         
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

  

  Future<void> _updatePatientProfile(int id) async {
    if (_formKey.currentState!.validate()) {
      try{

   Patient  updatedPatient =  Patient (
        id: id,
        fname: _fnameController.text,
        lname: _lnameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        password: _passwordController.text,
        gender:       _genderController.text,
        date_birth:      _dobController.text,
        home_add:      _homeAddController.text, 
        weight:      _weightController.text,
        height:      _heightController.text,
        bloodgroup:      _bloodGController.text, 
        genotype:      _genotypeController.text,
        marital_status:      _maritalController.text, 
        emergency_contact_name:      _emergencyNameController.text, 
        emergency_contact_phone:      _emergencyphoneController.text,
        occupation:      _workController.text, 
        habit:      _habitController.text, 
        allergies:      _allegController.text, 
        
      );

     await  _databaseHelper.updatePatient(updatedPatient);
    
      Patient? patientDetails = await _databaseHelper.getPatient(id);
      if (patientDetails != null) {
    
      } else {
        print('Patient details not found');
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );
      print(updatedPatient);
     } catch (e) {
       print('Error updating patient: $e');
      rethrow; 
    }
    } else {
      throw Exception('Form is not valid');

    }
  }

 
}


