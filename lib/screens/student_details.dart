import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:test_functions/model/student.dart';

class StudentDetails extends StatefulWidget {
  Student student;

  StudentDetails(this.student);

  @override
  _StudentDetailsState createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
  Student student;

  @override
  void initState() {
    // TODO: implement initState
    student = widget.student;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Student Details"),
      ),
      body: Column(
        children: [
          Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(student.name, style: TextStyle(fontWeight: FontWeight.bold)),
              Text(student.mobileNo,
                  style: TextStyle(fontWeight: FontWeight.bold))
            ],
          )),
          Container(
            child: QrImage(
              data: student.uniqueId,
              size: 250,
            ),
          )
        ],
      ),
    );
  }
}
