
import 'package:flutter/material.dart';
import 'database.dart';



class Person {
  final int id;
  final String firstname;
  final String lastname;
  final String email;
  final String phone;
  final String doctorName;
  // final String department;
  final String reason;
  final String date_time;


  Person({
   required this.id,
   required this.firstname,
   required this.lastname,
   required this.email,
   required this.phone,
   required this.doctorName, 
  //  required this.department, 
   required this.reason, 
   required this.date_time, 
   });
}



class doctorAppointmentPage extends StatefulWidget {
  @override
  _doctorAppointmentPageState createState() => _doctorAppointmentPageState();


}

class _doctorAppointmentPageState extends State<doctorAppointmentPage> {
  late List<Person> appointments = [];
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;



@override
void initState() {
  super.initState();
  initializeAppointments();
}


Future<void> initializeAppointments() async {
  appointments = await DatabaseHelper.instance.getAllAppointments();
  setState(() {}); 
}
  



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text(
          'APPOINTMENTS',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily:'Agbalumo', 
            color: Colors.lightBlueAccent,
          ),
          ),
         ),
                body: ListView.builder(
  itemCount: appointments.length,
  itemBuilder: (context, index) {
    return Column(
      children: [
        ListTile(
          title: Text(
            '${appointments[index].date_time}\n',
          ),
          subtitle: Text(
            'Full Name: ${appointments[index].firstname.toUpperCase()} ${appointments[index].lastname.toUpperCase()} \n'
            'Email Address: ${appointments[index].email}\n'
            'Phone Number : ${appointments[index].phone}\n' 
            'Doctors Name : Dr ${appointments[index].doctorName.toUpperCase()} Department\n'
            // 'Doctors Department: ${appointments[index].department}\n'
            'Reason For Appointment: ${appointments[index].reason}\n'
            'Date And Time For Appointment : ${appointments[index].date_time}'
          ),
          contentPadding: const EdgeInsets.fromLTRB(20, 10, 5, 5),
          tileColor: Colors.white,
          titleTextStyle: const TextStyle(
            color: Colors.black26,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          subtitleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 15,
            letterSpacing: 1.5,
            fontWeight: FontWeight.w500,
          ),
          trailing: Container(
            padding: const EdgeInsets.fromLTRB(8,10,8,8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.thumb_up),
                  color: const Color.fromARGB(255, 71, 71, 71),
                  iconSize: 30,
                      onPressed: () async {

                      await  _databaseHelper.insertStatus(
                         status: 'Accepted',

                        );
                  },
                ),
                IconButton(
                  icon:const Icon(Icons.thumb_down),
                  color: Colors.grey,
                  iconSize: 30,
                  onPressed: () async{
                      await  _databaseHelper.insertStatus(
                         status: 'Rejected, reschedule for another date',

                        );
                  },
                ),
              ],
            ),
          ),
        ),
        if (index < appointments.length - 1)const Divider(),
      ],
    );
  },
),
    );  
  }

  }
