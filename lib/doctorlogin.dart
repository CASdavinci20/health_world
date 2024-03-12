import 'package:flutter/material.dart';
import 'doctor.dart';
import 'doctorsignup.dart';
import 'authentication.dart';
// import 'class.dart';
import 'package:shared_preferences/shared_preferences.dart';




class DoctorLoginPage extends StatefulWidget {
  const DoctorLoginPage({super.key});
  

  @override
 _DoctorLoginPageState createState() => _DoctorLoginPageState();
 

}

class _DoctorLoginPageState extends State<DoctorLoginPage> {
  SharedPreferences? _prefs;


  final _formKey = GlobalKey<FormState>();
  

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _isObscure = true;

  @override
void initState() {
  super.initState();
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
      body: SingleChildScrollView( 
     child: Padding(
        padding: const EdgeInsets.all(25.0),
        child:Form(
          key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
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
                    return 'Please enter your Email';
                  }
                  return null; 
                },
                ),
            const SizedBox(height: 16.0),
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
              MaterialPageRoute(builder: (context) =>const DoctorSignupPage()),
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
                 bool isAuthenticated = await Authentication.authenticateDoctor(
                _emailController.text,
                _passwordController.text,
             );
              if (isAuthenticated) {
                //_retrieveLoginDetailsFromSharedPreferences();

                 _saveLoginDetailsToSharedPreferences(
          _emailController.text,
          _passwordController.text,
        );
                
                                 Navigator.push(
                       context,
                      MaterialPageRoute(builder: (context) => DoctorPage()),
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
      )
    );
  }

  
void _saveLoginDetailsToSharedPreferences(String email, String password) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('doctor_email', email);
  prefs.setString('doctor_password', password);

  _retrieveLoginDetailsFromSharedPreferences();
}

Future<void> _retrieveLoginDetailsFromSharedPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  
  // Retrieve email and password from SharedPreferences
  String? email = prefs.getString('doctor_email');
  String? password = prefs.getString('doctor_password');

  print('email: $email' 'password: $password');
  

  // Check if both email and password are not null
 // if (email != null && password != null) {
    // Do something with the retrieved data, such as logging in automatically
  //   _emailController.text = email;
  //   _passwordController.text = password;
  // } else {
    
  // }
}
}