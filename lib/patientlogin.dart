import 'package:flutter/material.dart';
import 'package:health_world/patient.dart';
import 'patientsignup.dart';
import 'database.dart';
import 'authentication.dart';
import 'class.dart';


class PatientLoginPage extends StatefulWidget {
  // const PatientLoginPage({super.key});
   final Map<String, dynamic>? data;

  const PatientLoginPage({Key? key,  this.data}) : super(key: key);
  
  @override
 _PatientLoginPageState createState() => _PatientLoginPageState();

}

class _PatientLoginPageState extends State<PatientLoginPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  bool _isObscure = true;

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
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child:Form(
          key: _formKey,
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _usernameController,
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
                    return 'Please enter your username';
                  }
                  return null; 
                },
                ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _passwordController,
              obscureText: _isObscure, 
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle:const TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
                suffixIcon: IconButton(
                     icon: Icon(
                    _isObscure ? Icons.visibility : Icons.visibility_off,
                     color: Colors.grey,
                     ),
                     onPressed: () {
                           setState(() {
                          _isObscure = !_isObscure;
                          });
                       },
                  ),
                enabledBorder:const OutlineInputBorder(
                   borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                   borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
               validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid password';
                  }
                  return null; 
                },
            ),
           const SizedBox(height: 15.0),
             Row(
              children: [
               const Text(
                  'You dont have an account ?',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
               const SizedBox(width: 50,),
                GestureDetector(
                  onTap: () {
           Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>const PatientSignupPage()),
            );
                  },
                child:const Text(
                  'Sign up',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.red,
                  ),
                ),
                ),
              ],
             ),
            const SizedBox(height: 24,),
            ElevatedButton(

              onPressed: () async {
               
                if (_formKey.currentState!.validate()) {
                 bool isAuthenticated = await PatientAuthentication.authenticatePatient(
                _usernameController.text,
                _passwordController.text,
             );
            //  await _simulateLogin();
              if (isAuthenticated) {
                // await PatientSessionManager.saveSession('session_token',widget.data['id'] as int);
                                 Navigator.push(
                       context,
                      MaterialPageRoute(builder: (context) => PatientPage()),
                   );       
           } else {
         showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Invalid Credentials',
            style: TextStyle(color: Colors.red),
            ),
            content: Text('Invalid email or password. Please try again.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
           );
           }
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
                'Login',
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