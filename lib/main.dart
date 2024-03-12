import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'patientlogin.dart';
import 'doctorlogin.dart';
import 'database.dart';
import 'package:provider/provider.dart';
import 'package:health_world/class.dart';
import 'doctor.dart';




void main() async{
   WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.instance.initDatabase();
 
runApp(

  MultiProvider(
      providers: [
         ChangeNotifierProvider(create: (_) => PatientProfile(
                  fname: 'fname',
                lname: 'lname',
                email:  'email',
                gender: 'gender',
                date_birth: 'date_birth',
                home_add: 'home_add',
                phone: 'phone',
                password: 'password',
                marital_status: 'marital_ststus',
                height:'height',
                weight:'weight',
                genotype: 'genotype',
                bloodgroup: 'bloodgroup',
                emergency_contact_name: 'emergency_contact_name',
                emergency_contact_phone: 'emergency_contact_phone',
                occupation: 'occupation',
                habit: 'habit',
                allergies: 'allergies',
                             )),
        ChangeNotifierProvider(create: (Context) => DoctorProfile(
          fname: 'fname',
          lname: 'lname',
          email: 'email',
          gender: 'gender',
          password: 'password',
          date_birth: 'date_birth',
          home_add: 'home_add',
          phone: 'phone',
          clinic_name: 'clinic_name',
          clinic_address: 'clinic_address',
          speciality: 'speciality',
          department: 'department',
          marital_status: 'marital_status',
          imageUrl: 'imageUrl',
        )),
         
      ],
      child: const MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health World',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const HealthWorld(),
    );
  }
}



class HealthWorld extends StatelessWidget {
  const HealthWorld({super.key});
  

  @override
  Widget build(BuildContext context) {
     return Scaffold(
           body: Padding(
              padding:const EdgeInsets.fromLTRB(25,50,25,30),
               child: Container(
                padding: const EdgeInsets.all(10.0),
                width: 500.0,
                 decoration: BoxDecoration(
                  color: Colors.transparent,
                   borderRadius: BorderRadius.circular(20.0),
                     boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.0),
                  spreadRadius: 9,
                  blurRadius: 7, 
                  offset:const Offset(0, 6), 
                ),
              ],
                  border: Border.all(
                  color: Colors.lightBlueAccent,
                  width: 1.5,
            
                  ),
                 ),
             child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
             GestureDetector(
              onTap:() {
                Navigator.push(
                       context,
                      MaterialPageRoute(builder: (context) => DoctorPage()),
                   );      
              },
            child:  const Text(
                'HEALTH WORLD',
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.lightBlueAccent,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.0, 
                  fontFamily: 'Monoton',
                ),
              ),
             ),
            const  SizedBox(height: 40,),
                 Container(

                  height: 120,
                  width: 120,
                
                 decoration:const BoxDecoration(
                 image: DecorationImage(
                image: AssetImage('assets/logo1.jpg'),
                 fit: BoxFit.cover,
              
             ),
             borderRadius: BorderRadius.all(
              Radius.circular(30)
             )
              ),
                ),
              const SizedBox(height: 250), 
               ElevatedButton(
                onPressed: () async {
  //                final dbHelper = DatabaseHelper(); 

  // final data = await dbHelper.getPatientProfile();

  // if (data != null && data.containsKey('id')) {
    // String? id = data['id'] as String?;
    // // Here you need to retrieve sessionToken from your data, 
    // // assuming it's stored in the database
    // String? sessionToken = data['sessionToken'] as String?;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PatientLoginPage(),
      ),
    );
  // } else {
  //   print('seesion not good');
  // }
                },
    // Handle case where patient profile data is not available
    // For example, display an error message
              //      onPressed: () async{
              //        final dbHelper = DatabaseHelper(); 

              //       final data = await dbHelper.getPatientProfile();
              //       String? id = data?['id']?? '';

              //           Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => PatientLoginPage(data: {'sessionToken': sessionToken, 'id': patientId})),
              // );
              //      },
                   style: ElevatedButton.styleFrom(
                backgroundColor:  Colors.lightBlueAccent,
                 padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                  shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 4, 
               ),
               child: const Text('PATIENT',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ) ,
              ),
            ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>const DoctorLoginPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlueAccent,
                 padding: const EdgeInsets.symmetric(horizontal:100, vertical: 10),
                  shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 4, 
               ),
                  child: const Text('DOCTOR',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ) ,
              ),
                ),
              ]
            ),
               ),
            ),
          
        
           );
     
      // );
   
  }
  }

