import 'package:flutter/material.dart';
import 'patient.dart';
import 'database.dart';
import 'class.dart';


class PatientSignupPage extends StatefulWidget {
  const PatientSignupPage({super.key});

  @override
 _PatientSignupPageState createState() => _PatientSignupPageState();

}

class _PatientSignupPageState extends State<PatientSignupPage> {
  int? patientId;
  String? sessionToken;
   
  final _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  final _phoneRegex = RegExp(r'^[0-9]{10,13}$');

  final _formKey = GlobalKey<FormState>();

  TextEditingController _fnameController = TextEditingController();
  TextEditingController _lnameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();


  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  

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
      // body:Stack(
      //   fit: StackFit.expand, 
      //   children: [
      //     Image.asset(
      //       'assets/docct.jpg',
      //       fit: BoxFit.cover,
      //     ),
         body: SingleChildScrollView( 
      child: Padding(
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
                  }else if (!_emailRegex.hasMatch(value)) {
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
            const SizedBox(height: 24,),
            ElevatedButton(
              
              onPressed: () async {
                 if ( _formKey.currentState!.validate()) {
                     ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );
      try {
             await   _databaseHelper.insertPatient(
                  fname : _fnameController.text,
                  lname: _lnameController.text,
                  email: _emailController.text,
                  phone: _phoneController.text,
                  password: _passwordController.text,
                  gender: '',
                  date_birth: '',
                  home_add:   '', 
                  weight:     '',
                  height:      '',
                  bloodgroup:  '', 
                  genotype:      '',
                  marital_status:  '', 
                  emergency_contact_name: '', 
                  emergency_contact_phone:  '',
                  occupation:  '', 
                  habit:   '', 
                  allergies: '', 
        
                  
                );
                
        print('Patient saved successfully.');
         
                  Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PatientPage()),
            );
              } catch (e) {
                 print('Error saving patient: $e');
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
          ),
      );
  }
}