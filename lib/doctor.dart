
import 'package:flutter/material.dart';
import 'doctoraptm.dart';
import 'doctorprofile.dart';
import 'database.dart';
import 'class.dart';
import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';





class DoctorPage extends StatelessWidget {

// Future<void> _clearDoctorDataInSharedPreferences() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   prefs.remove('fname');
//   prefs.remove('lname');
//   prefs.remove('email');
//   prefs.remove('phone');
//   prefs.remove('password');
//   prefs.remove('gender');
//   prefs.remove('date_birth');
//   prefs.remove('home_add');
//   prefs.remove('clinic_name');
//   prefs.remove('clinic_address');
//   prefs.remove('speciality');
//   prefs.remove('department');
//   prefs.remove('marital_status');
//   prefs.remove('imageUrl');
// }

void clearDoctorProfile() {
  // Clear doctor's profile data
  print('Doctor Profile Cleared');
}
  
  
  
  // void logOut(BuildContext context) {
  //   Provider.of<DoctorProfile>(context, listen: false).clearData();
  //   clearDoctorProfile();

  //   print('data cleared successfully');
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 50,
        title:const Text(
          'DOCTOR PORTAL',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            color: Colors.black54,
            fontFamily: 'Agbalumo',
          ),
          ),
          
      ),
      body: Padding(
        padding: const EdgeInsets.all(23.0),
           child: Center(
            child:  Column(
            children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.lightBlueAccent,
              ),
              padding:const EdgeInsets.all(20),
              
              height: 110,
              
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
     const SizedBox(width: 40.0),
      Column(
      
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        const  Padding(
            padding: const EdgeInsets.all(5.0),
            ),
         Consumer<DoctorProfile>(
              builder: (context, doctorProfile, child) {
                return Text(
                  '${doctorProfile.fname} ${doctorProfile.lname}',
            style:const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: 2,
            ),
             );
          },
        ),  
          SizedBox(height: 5.0),
         const Text(
            'Welcome Back', 
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
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
              onTap: () async{
                  try {
                    final dbHelper = DatabaseHelper(); 

           final data = await dbHelper.getDoctorProfile();



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

  
    Navigator.push(
      context,
      MaterialPageRoute(
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
        } ,
        clearProfile: clearDoctorProfile,
        ),
      ),
    );
  } catch (error) {
    print('Error fetching doctor data: $error');
  }

              },
            ),
           
           const SizedBox(width:10.0),
          
            _buildSectionCard(
              title: 'Appointments',
              icon: Icons.event,
              onTap: () {
                 
                 Navigator.push(
                       context,
                      MaterialPageRoute(fullscreenDialog: true, builder: (context) =>  doctorAppointmentPage()
                      ),
                   );
              },
            ),
            const SizedBox(width: 10.0),
             _buildSectionCard(
              title: 'Patients',
              icon: Icons.person_add,
              onTap: () {

                //  Navigator.push(
                //        context,
                //       MaterialPageRoute(builder: (context) =>const DoctorRegistrationPage()),
                //    );
              },
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
              title: 'Patients',
              icon: Icons.phone,
              onTap: () {
            
              },
            ),
           const SizedBox(width: 10.0),
            _buildSectionCard(
              title: 'Informations',
              icon: Icons.description,  
              onTap: () {
              
              },
            ), 
           
           const SizedBox(width: 10.0),
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
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      );
  }


  Widget _buildSectionCard({required String title, required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 10.0,
        child:Container(
          width: 90,
          height: 60,
          color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 20.0,
                color: Colors.lightBlueAccent,
              ),
              const SizedBox(
                height: 6.0,
                ),
              Text(
                title,
                style:const TextStyle(
                  fontSize: 9.5,
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

}    