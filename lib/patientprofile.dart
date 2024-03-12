import 'package:flutter/material.dart';
import 'package:health_world/class.dart';
import 'dart:io';
import 'patientReg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'class.dart';
import 'patientlogin.dart';



class PatientProfilePage extends StatefulWidget {
  final Map<String, dynamic> data;
 const  PatientProfilePage({Key? key, required this.data}) : super(key: key);
  

    @override
  _PatientProfilePageState createState() => _PatientProfilePageState();
}

  
class _PatientProfilePageState extends State<PatientProfilePage> {
   late Map<String, dynamic> data;
  late bool _editMode;
   late SharedPreferences _prefs; 
    bool shouldLogout = true; 
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //  late Map<String, dynamic> userData;


   @override
  void initState() {
    super.initState();
    _initPrefs();
    _loadPatientProfile();
  //      String? sessionToken = widget.data['sessionToken'];
  // int? patientId = widget.data['id']; 
  //  if (sessionToken != null && patientId != null) {
  //   PatientSessionManager.saveSession(sessionToken, patientId);
  // }
  
}

 void _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }




  File? _image;

  Future getImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
bool _editMode = false;

    setState(() {
      if (pickedFile != null ) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
 
    });

  }



 void _loadPatientProfile() {
    Provider.of<PatientProfile>(context, listen: false).updatePatientProfile(
             fname: widget.data['fname'],
            lname: widget.data['lname'],
            email: widget.data['email'],
            gender: widget.data['gender'],
            date_birth: widget.data['date_birth'],
            home_add: widget.data['home_add'],
            marital_status: widget.data['marital_status'],
            phone: widget.data['phone'],
            weight: widget.data['weight'],
            height: widget.data['height'],
            genotype:widget.data['genotype'],
            bloodgroup: widget.data['bloodgroup'],
            emergency_contact_name: widget.data['emergency_contact_name'],
            emergency_contact_phone:widget.data['emergency_contact_phone'],
            habit: widget.data['habit'],
            occupation:widget.data['occupation'],
            allergies: widget.data['allergies'],
           );

  }

   void _saveDataToPrefs() {
    // Check if _prefs is initialized
    if (_prefs != null) {
      // Save data to SharedPreferences
      _prefs.setString('fname', widget.data['fname']);
      _prefs.setString('lname', widget.data['lname']);
       _prefs.setString('email', widget.data['email'],);
            _prefs.setString('gender', widget.data['gender'],);
       _prefs.setString('date_birth', widget.data['date_birth'],);
         _prefs.setString('home_add', widget.data['home_add'],);
        _prefs.setString('marital_status', widget.data['marital_status'],);
        _prefs.setString('phone', widget.data['phone'],);
        _prefs. setString('weight', widget.data['weight'],);
          _prefs. setString('height', widget.data['height'],);
          _prefs.setString('genotype',widget.data['genotype'],);
          _prefs. setString('bloodgroup', widget.data['bloodgroup'],);
          _prefs.setString('emergency_contact_name', widget.data['emergency_contact_name'],);
          _prefs.setString('emergency_contact_phone',widget.data['emergency_contact_phone'],);
          _prefs.setString('habit', widget.data['habit'],);
          _prefs.setString('occupation',widget.data['occupation'],);
          _prefs.setString('allergies', widget.data['allergies'],);
    }
  }
  void _toggleEditMode() {
    setState(() {
      _editMode = !_editMode;
    });
  }
   

 


  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text(
          'Patient Profile',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            color: Colors.black54,
            fontFamily: 'Agbalumo',  
          ),
          ),
            actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'edit') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PatientRegistrationPage()),
                 
                );
               
              } if (value == 'logout') {
                 setState(() {
                clearPatientProfile(context, _formKey); 
                Provider.of<PatientProfile>(context, listen:false).clearPatientData();
              });
         
               print('data cleared successfully');
             
              Navigator.pushReplacement(
                context,

                MaterialPageRoute(builder: (context) => PatientLoginPage()),);
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'edit',
                child: ListTile(
                  leading: Icon(Icons.edit),
                  title: Text('Edit Profile'),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'logout',
                child: ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Logout'),
                ),
              ),
            ],
          ),
        ],

      ),



      body:Consumer<PatientProfile>(
      builder: (context, patientProfile, child) {
          
    return  SingleChildScrollView(
       child: Padding(
        
        padding: const EdgeInsets.all(15),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             Container(
            alignment: Alignment.center,
           child: GestureDetector(
             onTap: getImage,
              child: CircleAvatar(
                radius: 70,
            backgroundImage: _image != null ? FileImage(_image!) : null,
               child: _image == null ? const Icon(Icons.camera_alt, size: 50) : null,
                        ),
                      ),
          ),
          const  SizedBox(height: 20),
        const  Divider(
            thickness: 2,
            color: Colors.black,
          ),
          const  SizedBox(height: 10),
         const Text(
            'PERSONAL INFORMATION',
            style: TextStyle(
              fontSize: 17,
              color: Colors.lightBlueAccent,
            ),
          ),
          Row(
          children: [
            Expanded(
            child: ListTile(
          title: Text(
            'Full Name:',
          ),
          subtitle: Text(
            '${patientProfile.fname}  ${patientProfile.lname}',
          ),
          tileColor: Colors.white,
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
          subtitleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 17,
            letterSpacing: 1.5,
            fontWeight: FontWeight.bold,
          ),
          ),
            ),

           Expanded(    
         child: ListTile(
          title: Text(
            'Date of Birth:',
          ),
          subtitle: Text(
           patientProfile.date_birth ,
          ),
          tileColor: Colors.white,
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
          subtitleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 17,
            letterSpacing: 1.5,
            fontWeight: FontWeight.bold,
          ),
          )
           ), 
          ]    
        ),

            Row(
          children: [
            Expanded(
            child: ListTile(
          title: Text(
            'Gender:',
          ),
          subtitle: Text(
            patientProfile.gender,
          ),
          tileColor: Colors.white,
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
          subtitleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 17,
            letterSpacing: 1.5,
            fontWeight: FontWeight.bold,
          ),
          ),
            ),

            Expanded(    
         child: ListTile(
          title: Text(
            'Occupation:',
          ),
          subtitle: Text(
            patientProfile.occupation,
          ),
          tileColor: Colors.white,
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
          subtitleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 17,
            letterSpacing: 1.5,
            fontWeight: FontWeight.bold,
          ),
          )
           ), 
          ]    
        ),
       const Text(
          'CONTACT INFORMATION',
          style: TextStyle(
              fontSize: 17,
              color: Colors.lightBlueAccent,
            ),
          ),
                    Row(
          children: [
            Expanded(
            child: ListTile(
          title: Text(
            'Phone Number:',
          ),
          subtitle: Text(
            patientProfile.phone,
          ),
          tileColor: Colors.white,
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
          subtitleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 17,
            letterSpacing: 1.5,
            fontWeight: FontWeight.bold,
          ),
          ),
            ),

           Expanded(    
         child: ListTile(
          title: Text(
            'Email Address:',
          ),
          subtitle: Text(
          patientProfile.email,
          ),
          tileColor: Colors.white,
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
          subtitleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 17,
            letterSpacing: 1.5,
            fontWeight: FontWeight.bold,
          ),
          )
           ), 
          ]    
        ),


                 Row(
          children: [
            Expanded(
            child: ListTile(
          title: Text(
            'Home Address:',
          ),
          subtitle: Text(
            patientProfile.home_add,
          ),
          tileColor: Colors.white,
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
          subtitleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 17,
            letterSpacing: 1.5,
            fontWeight: FontWeight.bold,
          ),
          ),
            ),
          ]    
        ),
        const Text(
          'MEDICAL INFORMATION',
          style: TextStyle(
              fontSize: 17,
              color: Colors.lightBlueAccent,
            ),
          ),  

                       Row(
          children: [
            Expanded(
            child: ListTile(
          title: Text(
            'Bloodgroup:',
          ),
          subtitle: Text(
            patientProfile.bloodgroup,
          ),
          tileColor: Colors.white,
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
          subtitleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 17,
            letterSpacing: 1.5,
            fontWeight: FontWeight.bold,
          ),
          ),
            ),

           Expanded(    
         child: ListTile(
          title: Text(
            'Genotype:',
          ),
          subtitle: Text(
            patientProfile.genotype,
          ),
          tileColor: Colors.white,
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
          subtitleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 17,
            letterSpacing: 1.5,
            fontWeight: FontWeight.bold,
          ),
          )
           ), 
          ]    
        ),

                     Row(
          children: [
            Expanded(
            child: ListTile(
          title:const Text(
            'Weight:',
          ),
          subtitle: Text(
            '${patientProfile.weight} KG',
          ),
          tileColor: Colors.white,
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
          subtitleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 17,
            letterSpacing: 1.5,
            fontWeight: FontWeight.bold,
          ),
          ),
            ),

           Expanded(    
         child: ListTile(
          title:const Text(
            'Height:',
          ),
          subtitle: Text(
            patientProfile.height,
          ),
          tileColor: Colors.white,
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
          subtitleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 17,
            letterSpacing: 1.5,
            fontWeight: FontWeight.bold,
          ),
          )
           ), 
          ]    
        ),

                     Row(
          children: [
            Expanded(
            child: ListTile(
          title:const Text(
            'Allergies:',
          ),
          subtitle: Text(
           patientProfile.allergies,
          ),
          tileColor: Colors.white,
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
          subtitleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 17,
            letterSpacing: 1.5,
            fontWeight: FontWeight.bold,
          ),
          ),
            ),

           Expanded(    
         child: ListTile(
          title: Text(
            'Habit:',
          ),
          subtitle: Text(
           patientProfile.habit,
          ),
          tileColor: Colors.white,
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
          subtitleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 17,
            letterSpacing: 1.5,
            fontWeight: FontWeight.bold,
          ),
          )
           ), 
          ]    
        ),
       
        const Text(
          'EMERGENCY CONTACT INFORMATION',
          style: TextStyle(
              fontSize: 17,
              color: Colors.lightBlueAccent,
            ),
          ), 
          
                     Row(
          children: [
            Expanded(
            child: ListTile(
          title: Text(
            'Contact Name:',
          ),
          subtitle: Text(
            patientProfile.emergency_contact_name,
          ),
          tileColor: Colors.white,
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
          subtitleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 17,
            letterSpacing: 1.5,
            fontWeight: FontWeight.bold,
          ),
          ),
            ),

           Expanded(    
         child: ListTile(
          title: Text(
            'Contact Phone:',
          ),
          subtitle: Text(
            patientProfile.emergency_contact_phone,
          ),
          tileColor: Colors.white,
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
          subtitleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 17,
            letterSpacing: 1.5,
            fontWeight: FontWeight.bold,
          ),
          )
           ), 
          ]    
        ),
        

        
                     Row(
          children: [
            Expanded(
            child: ListTile(
          title: Text(
            'Relationship:',
          ),
          subtitle: Text(
            patientProfile.marital_status,
          ),
          tileColor: Colors.white,
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
          subtitleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 17,
            letterSpacing: 1.5,
            fontWeight: FontWeight.bold,
          ),
          ),
            ),
          ]    
        ),
        ]
      ),
       ),
      
      );
      // }else{
      //   return CircularProgressIndicator();
      // }
      //  return SizedBox.shrink(); 
      }
      ),
    );
  }

  
void clearPatientProfile(BuildContext context, GlobalKey<FormState> formKey) {
  PatientProfile patientProfile = Provider.of<PatientProfile>(context, listen: false);
  patientProfile.clearPatientData(clearFname: true);
    formKey.currentState?.reset();


  PatientRegistrationPage.fnameController.clear();
  PatientRegistrationPage.lnameController.clear();
  PatientRegistrationPage.passwordController.clear();
  PatientRegistrationPage.emailController.clear();
  PatientRegistrationPage.phoneController.clear();
  PatientRegistrationPage.dobController.clear();
  PatientRegistrationPage.genderController.clear();
  PatientRegistrationPage.homeAddController.clear();
  PatientRegistrationPage.bloodGController.clear();
  PatientRegistrationPage.heightController.clear();
  PatientRegistrationPage.weightController.clear();
  PatientRegistrationPage.genotypeController.clear();
  PatientRegistrationPage.maritalController.clear();
  PatientRegistrationPage.emergencyNameController.clear();
  PatientRegistrationPage.emergencyphoneController.clear();
  PatientRegistrationPage.allegController.clear();
  PatientRegistrationPage.habitController.clear();
  PatientRegistrationPage.workController.clear();
    print('done');
  }


  }
  