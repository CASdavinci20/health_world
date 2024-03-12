
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'class.dart'; 
import 'doctorreg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'doctorlogin.dart';




class DoctorProfilePage extends StatefulWidget {
   final  Map<String, dynamic> data;
   final Function clearProfile;

   const DoctorProfilePage({Key? key, required this.data,required this.clearProfile}) : super(key: key);
  

    @override
  _DoctorProfilePageState createState() => _DoctorProfilePageState();
}

  
class _DoctorProfilePageState extends State<DoctorProfilePage> {
  late Map<String, dynamic> _data;
  late bool _editMode = false;
  SharedPreferences? _prefs;
  bool shouldLogout = true; 
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

   @override
  void initState() {
    super.initState();
    _loadDoctorProfile();
}

 void _loadDoctorProfile() {
    Provider.of<DoctorProfile>(context, listen: false).updateProfile(
      fname: widget.data['fname'],
      lname: widget.data['lname'],
      email: widget.data['email'],
      gender: widget.data['gender'],
      date_birth: widget.data['date_birth'],
      home_add: widget.data['home_add'],
      phone: widget.data['phone'],
      clinic_name: widget.data['clinic_name'],
      clinic_address: widget.data['clinic_address'],
      speciality: widget.data['speciality'],
      department: widget.data['department'],
      marital_status: widget.data['marital_status'],
      imageUrl: widget.data['imageUrl'],
    );
  }


  File? _image;

  Future getImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);


    setState(() {
      if (pickedFile != null ) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
 
    });

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
          'Doctor Profile',
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
                  MaterialPageRoute(builder: (context) => DoctorRegistrationPage()),
                 
                );
               
              } if (value == 'logout') {
                 setState(() {
                clearDoctorProfile(context, _formKey);
                _clearDoctorDataInSharedPreferences();
                
              });
         
               print('data cleared successfully');
             
              Navigator.pushReplacement(
                context,

                MaterialPageRoute(builder: (context) => DoctorLoginPage()),);
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

    
     body: Consumer<DoctorProfile>(
      builder: (context, doctorProfile, child) {
    return SingleChildScrollView(
       child: Padding(
        padding: const EdgeInsets.all(15),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
          child:  GestureDetector(
                onTap: getImage,
            child: CircleAvatar(
            radius: 70,
              backgroundImage: _image != null ? FileImage(_image!) : null,
                  child: _image == null
                      ?const Icon(
                          Icons.camera_alt,
                          size: 50,
                        )
                      : null,
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
            '${doctorProfile.fname} ${doctorProfile.lname}',
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
            'Date of Birth:',
          ),
          subtitle: Text(
            doctorProfile.date_birth,
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
            doctorProfile.gender,
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
            doctorProfile.phone,
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
            doctorProfile.email,
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
            doctorProfile.home_add,
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
          'HOSPITAL INFORMATION',
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
            'Hospital Name:',
          ),
          subtitle: Text(
            doctorProfile.clinic_name,
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
            'Hospital Address:',
          ),
          subtitle: Text(
            doctorProfile.clinic_address,
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
            'Speciality:',
          ),
          subtitle: Text(
            doctorProfile.speciality,
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
            'Department:',
          ),
          subtitle: Text(
            doctorProfile.department,
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

            ]
            )
       )
     );
      // }else{
      // }
      // return SizedBox.shrink(); 
      }
     )
    );
  }



void clearDoctorProfile(BuildContext context, GlobalKey<FormState> formKey) {
  DoctorProfile doctorProfile = Provider.of<DoctorProfile>(context, listen: false);
  doctorProfile.clearData(clearFname: true);
    formKey.currentState?.reset();

  DoctorRegistrationPage.fnameController.clear();
  DoctorRegistrationPage.lnameController.clear();
  DoctorRegistrationPage.passwordController.clear();
  DoctorRegistrationPage.emailController.clear();
  DoctorRegistrationPage.phoneController.clear();
  DoctorRegistrationPage.dobController.clear();
  DoctorRegistrationPage.genderController.clear();
  DoctorRegistrationPage.homeAddController.clear();
  DoctorRegistrationPage.clinicController.clear();
  DoctorRegistrationPage.specialtyController.clear();
  DoctorRegistrationPage.maritalController.clear();
  DoctorRegistrationPage.clinicaddController.clear();
  DoctorRegistrationPage.departmentController.clear();
  DoctorRegistrationPage.imageUrlController.clear();

    print('done');
  }



Future<void> _clearDoctorDataInSharedPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('fname');
  prefs.remove('lname');
  prefs.remove('email');
  prefs.remove('phone');
  prefs.remove('password');
  prefs.remove('gender');
  prefs.remove('date_birth');
  prefs.remove('home_add');
  prefs.remove('clinic_name');
  prefs.remove('clinic_address');
  prefs.remove('speciality');
  prefs.remove('department');
  prefs.remove('marital_status');
  prefs.remove('imageUrl');
}

  
}


 


