import 'package:flutter/material.dart';
import 'database.dart';
import 'doctorprofile.dart';
import 'class.dart';




class PatientAppointmentPage extends StatefulWidget {
   final Map<String, dynamic> data;

  const PatientAppointmentPage({Key? key, required this.data}) : super(key: key);

    @override
 _PatientAppointmentPageState createState() => _PatientAppointmentPageState();


}

class _PatientAppointmentPageState extends State<PatientAppointmentPage> {
   late String fname;
  late String lname;
  late String email;
  late String phone;
  

  final _formKey = GlobalKey<FormState>();

  
  TextEditingController _dateController = TextEditingController();

  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;
  
   String selectedValue = 'Reason For Appointment';
    String selectedDoctor = 'Select Doctor';

     List<AllDoctors> doctors = [];


    @override
  void initState() {
    super.initState();
  fetchDoctors();
  }

  
  
Future<List<AllDoctors>> fetchDoctors() async {
  List<AllDoctors> fetchedDoctors = await _databaseHelper.getAllDoctors(); 
  print(fetchedDoctors);
  setState(() {
  doctors = fetchedDoctors;
  });
  return fetchedDoctors;
}

  

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text(
          'BOOK APPOINTMENT',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily:'Agbalumo', 
            color: Colors.lightBlueAccent,
          ),
          ),
      ),
       body:SingleChildScrollView(
        
      child:Padding(
        padding: const EdgeInsets.fromLTRB(30, 20, 30, 10),
        child:Form(
          key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              initialValue:'${widget.data['fname']}  ${widget.data['lname']}',
              decoration:const InputDecoration(labelText: 'Full Name'),
              enabled: true, 
            ),
           const SizedBox(height: 4.0),
            TextFormField(
              initialValue: widget.data['email'],
              decoration:const InputDecoration(labelText: 'Email'),
              enabled: true, 
            ),
           const SizedBox(height: 4.0),
             TextFormField(
              initialValue:widget.data['phone'],
              decoration:const InputDecoration(labelText: 'Phone Number'),
              enabled: true, 
            ),
               DropdownButton<String>(
                  value: selectedDoctor,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedDoctor = newValue!;
                    });
                  },
                  items:[
                     DropdownMenuItem<String>(
              value: 'Select Doctor', // Ensure there's only one item with this value
              child: Text('Select Doctor'),
            ),
            ...doctors.map<DropdownMenuItem<String>>((AllDoctors doctor) {
              return DropdownMenuItem<String>(
                value: '${doctor.doc_fname} ${doctor.doc_lname} ${doctor.doc_department} ',
                child: Text(doctor.doc_fname),
              );
            }).toList(),
              ],
                ),
                if (selectedDoctor == 'Select Doctor')...[
                  Text('Selected Doctor: $selectedDoctor'),
                Text('Department: ${getSelectedDoctor()?.doc_department}'),
                   Text('Clinic: ${getSelectedDoctor()?.doc_clinic_name}'),
                  Text('Speciality: ${getSelectedDoctor()?.doc_speciality}'),
                ],
             
           const SizedBox(height: 4.0),
          
             DropdownButton<String>(
          value: selectedValue,
          onChanged: (String? newValue) {
            setState(() {
              selectedValue = newValue!;
            });
          },
          items: <String>[
            'Reason For Appointment', 
            'Routine Check-up', 
            'Lab Result', 
            'Consultation',
            'Refferral',
            ]
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
         Text(
          ' $selectedValue',
          ),

           const SizedBox(height: 4.0),
            TextFormField(
            controller: _dateController,
            decoration:const InputDecoration(labelText: 'Select Date & Time'),
            onTap: () {
              _selectDate(context);
            },
             validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field cannot be empty';
                  }
                  return null; 
                },
          ),
           const SizedBox(height: 7.0),
            ElevatedButton(
              onPressed: () {
                  if (_formKey.currentState!.validate()) {
                     ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Appointment has been Booked')),
      );
                 _databaseHelper.insertAppointment(
                   fname:widget.data['fname'], 
                   lname: widget.data['lname'],
                   email: widget.data['email'],
                   phone: widget.data['phone'],
                   doctor_name: selectedDoctor,
                  //  department: selectedValue,
                   reason: selectedValue,
                   date_time: _dateController.text
                 );
                 }else{
                    print("form is invalid");
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
                'Book',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
                ),
            
            ),
          ],
        ),
      ),
      )
      )
       );
  }



  
 Future<void> _selectDate(BuildContext context) async {
  DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add( const Duration(days: 365)), 
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        DateTime selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        
        String formattedDateTime = "${selectedDateTime.toLocal()}".split(' ')[0] +
            " ${pickedTime.format(context)}";

        _dateController.text = formattedDateTime;
      }
    }
  }
 

AllDoctors? getSelectedDoctor() {
  if (selectedDoctor == 'Select Doctor' || doctors.isEmpty) {
    return null; 
  } else {
    var selectedDoctorList = doctors.where((doctor) => doctor.doc_fname == selectedDoctor  || doctor.doc_speciality == selectedDoctor).toList();
    return selectedDoctorList.isNotEmpty ? selectedDoctorList.first: null ;
  }
}


}