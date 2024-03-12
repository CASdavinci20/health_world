import 'package:flutter/material.dart';
import 'database.dart';
import 'doctoraptm.dart';


class Status{
   final String status;

   Status({
    required this.status,
   });
} 

class AppointmentData {
  final Person person;
  final Status status;

  AppointmentData({
     required this.person,
     required this.status
     });
}


class patientAppointmentViewPage  extends StatefulWidget {
  
  @override
  _patientAppointmentViewPageState createState() => _patientAppointmentViewPageState();
}

class _patientAppointmentViewPageState extends State<patientAppointmentViewPage> { 
  late List<AppointmentData>  appointmentsWithStatus =[];
   late List<Status> status = [];

  
@override
void initState() {
  super.initState();

    initializeStatus();
displayAppointmentsWithStatus();
}


Future<void> initializeStatus() async {
  status = await DatabaseHelper.instance.getAllStatus();
  setState(() {}); 
}

Future<void> displayAppointmentsWithStatus() async {
   appointmentsWithStatus = await DatabaseHelper.instance. getAllAppointmentsWithStatus();
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
      body:appointmentsWithStatus.isEmpty
        ? const Center(
            child: Text('No appointments with status available.'),
          )

      :ListView.builder(
        itemCount: status.length,
        itemBuilder: (context, index) {
          final AppointmentData appointmentData = appointmentsWithStatus[index];
          final Person person = appointmentData.person;
          // final Status appointmentStatus = appointmentData.status;
          return Column(
            children: [
          ListTile(
            title: Text('Replyed ${person.firstname} '),
            subtitle: Text(
                "Dear ${person.firstname.toUpperCase()} ${person.lastname.toUpperCase()} your appointment with Dr. ${person.doctorName.toUpperCase()}  Department schedule for ${person.date_time} has been ${status[index].status}.\n \nThank you. "
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
            fontSize: 18,
            letterSpacing: 1.5,
            fontWeight: FontWeight.w500,
          ),
          ),
          if (index < status.length - 1)const Divider(),
            ],
          );
        }
      ),
        );
  }
 
}

