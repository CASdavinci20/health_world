
import 'package:flutter/material.dart';
import 'package:health_world/patientprofile.dart';
import 'patientReg.dart';
import 'patientaptm.dart';
import 'patientaptmview.dart';
import 'database.dart';
import 'package:provider/provider.dart';
import 'class.dart';
import 'patientlogin.dart';
import 'package:shared_preferences/shared_preferences.dart';



class PatientPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    
    return Scaffold(
      appBar: AppBar(
         automaticallyImplyLeading: false,
        toolbarHeight: 50,
        title:const Text(
          'PATIENT PORTAL',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            color: Colors.black54,
            fontFamily: 'Agbalumo',
          ),
          ),
      ),
       body: Padding(
        padding: const EdgeInsets.all(20.0),
           child: Center(
            child:  Column(
            children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.lightBlueAccent,
              ),
              padding:const EdgeInsets.all(20),
              height: 100,
          child: Row(
             children: [
              Container(
               decoration: BoxDecoration(
                 shape: BoxShape.circle,
                  border: Border.all(
                   color: Colors.black,
                   width: 1.0,
                 ),
               ),
        child:const CircleAvatar(
          backgroundImage: AssetImage('assets/avatar.jpg'),
          radius: 30,
        ),
      ),
     const SizedBox(width: 50.0),
      Column(
      
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
         const Padding(
            padding: const EdgeInsets.all(5.0),
            ),
             Consumer<PatientProfile>(
              builder: (context, patientProfile, child) {
                return Text(
                  '${patientProfile.fname} ${patientProfile.lname}',
            style:const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              letterSpacing: 2,
              ),
            );
          },
        ),    
          SizedBox(height: 2.0),
        const  Text(
            'Welcome back', 
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: 2,
            ),
          ),
              ],
             ),
          ],
          ),
            ),

              const SizedBox(height: 40.0),
              Center(
             child: Row( 
               mainAxisAlignment: MainAxisAlignment.center,
                children: [
            const SizedBox(height: 26.0),
            _buildSectionCard(
              title: 'Profile',
              icon: Icons.person,

              onTap: () async {
                  try {
                    final dbHelper = DatabaseHelper();

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
        } ,
        // clearProfile: clearDoctorProfile,
        ),
      ),
    );
  } catch (error) {
    print('Error fetching doctor data: $error');
  }

                 }

            ), 
           const SizedBox(width:5.0),
          
            _buildSectionCard(
              title: 'Book Appointment',
              icon: Icons.event,
              onTap: () async {
                 try {
                    final dbHelper = DatabaseHelper(); 

           final data = await dbHelper.getPatientProfile();
               String? fname = data?['fname']?? '';
                    String? lname = data?['lname']?? '';
                    String? email = data?['email']?? '';  
                    String? phone = data?['phone']?? ''; 
              
              Navigator.push(
                  context,
                MaterialPageRoute(builder: (context) => PatientAppointmentPage(data:{
                  'fname':fname,
                  'lname':lname,
                  'email':email,
                  'phone':phone
                } )),
              );
               } catch (error) {
          print('Error fetching doctor data: $error');
         }
            }
               ),
            const SizedBox(width: 5.0),
             _buildSectionCard(
              title: 'View Appointment',
              icon: Icons.local_hospital,
              onTap: () { 
                Navigator.push(
                      context,
                         MaterialPageRoute(
                        builder: (context) =>  patientAppointmentViewPage(),
                     ),
                 ); 
              }
            ),
                ]
                ),
              ),
            const SizedBox(height: 20),
            Center(
             child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
           const SizedBox(height: 10.0),
             _buildSectionCard(
              title: 'Emergency',
              icon: Icons.phone,
              onTap: () {
            
              },
            ),
           const SizedBox(width:5.0),
                       _buildSectionCard(
              title: 'Lab Result',
              icon: Icons.library_books,
              onTap: () async { 
                    
              },
            ),
            
           const SizedBox(width:5.0),
            _buildSectionCard(
              title: 'Medications',
              icon: Icons.local_pharmacy,
              onTap: () {
                 
              },
            ), 
                ]
                
              ),
            ),
          const  SizedBox(height:50),
           Container(
               height: 200,
               decoration:const BoxDecoration(
               image: DecorationImage(
              image: AssetImage('assets/images3.jpg'),
               fit: BoxFit.cover,
    ),
  ),
             child: SizedBox.expand(
             child: Container(
             padding: const EdgeInsets.fromLTRB(20,17,120,10),
             color: Colors.black.withOpacity(0.4),
           child: const Text(
        'WE PROVIDE YOU WITH THE BEST MEDICAL CARE.',
        style: TextStyle(
          fontSize: 25.5,
          fontWeight: FontWeight.w900,
          color: Colors.white,
          fontFamily: 'Agbalumo',
        ),
      ),
    ),
  ),
              
         ),
            ]    
         ),

             ),
          ),
           bottomNavigationBar: Container(
        padding:const EdgeInsets.all(10.0),
        color: Colors.lightBlueAccent,
        child:const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Medical Service At Your Finger Tip',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      );
  }
}

  Widget _buildSectionCard({required String title, required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 10.0,
        child:Container(
          width: 95,
          height: 65,
          color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 20.0,
                color: Colors.lightBlueAccent,
              ),
              const SizedBox(
                height: 5.0,
                ),
              Text(
                title,
                style:const TextStyle(
                  fontSize: 8.5,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54, 
                ),
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
