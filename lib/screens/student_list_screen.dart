import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:test_functions/bloc/student/bloc.dart';
import 'package:test_functions/model/student.dart';
import 'package:test_functions/repository/student_services.dart';
import 'package:test_functions/screens/student_details.dart';
import '../bloc/student/events.dart';
import '../bloc/student/states.dart';
import 'addpage.dart';
import 'package:pdf/pdf.dart';
import 'package:qrscan/qrscan.dart' as scanner;


class StudentListScreen extends StatefulWidget {
  @override
  _StudentListScreenState createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _loadStudent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Student> studentList = [];
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Student screen"),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              ListTile(
                leading: Text(
                  "Id",
                  style: TextStyle(
                      color: Colors.purple,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                title: Text(
                  "Name",
                  style: TextStyle(
                      color: Colors.purple,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                trailing: Text(
                  "Mobile",
                  style: TextStyle(
                      color: Colors.purple,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
              BlocConsumer<StudentBloc, StudentState>(
                  listener: (context, state) {
                print("some event happened");
              }, builder: (context, state) {
                if (state is StudentLoadedState) {
                  List<Student> listStudent = state.list;
                  studentList = state.list;

                  return Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, int index) {
                        print(listStudent.last.mobileNo);
                        return Container(
                          child: ListTile(
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        StudentDetails(listStudent[index]))),
                            contentPadding: EdgeInsets.all(10),
                            title: Text(listStudent[index].name,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            trailing: Text(
                              listStudent[index].mobileNo,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            // trailing: FittedBox(fit: BoxFit.fitWidth,
                            //   child: Text(listStudent[index].uniqueId == null
                            //       ?
                            //       "no id":listStudent[index].uniqueId),
                            // ),
                            leading: Text(listStudent[index].id.toString(),
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        );
                      },
                      itemCount: listStudent.length,
                    ),
                  );
                }
                return CircularProgressIndicator();
              }),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.green,
                    onPressed: () async {
                      final result =
                          await Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => BlocProvider.value(
                                    value: StudentBloc(),
                                    child: AddPage(),
                                  )));
                      result != null ? _loadStudent() : print("no result");
                    },
                    child: Text("add"),
                  ),
                ),
                OutlineButton(
                  shape: CircleBorder(),
                  child: Icon(
                    Icons.picture_as_pdf,
                    color: Colors.purple,
                  ),
                  borderSide: BorderSide(width: 2, color: Colors.blue),
                  onPressed: () => context.read<StudentBloc>().add(GenPdf()),
                ),
                Material(
                    type: MaterialType.transparency,
                    //Makes it usable on any background color, thanks @IanSmith
                    child: Ink(
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.indigoAccent, width: 4.0),
                        color: Colors.indigo[900],
                        shape: BoxShape.circle,
                      ),
                      child: InkWell(
                        //This keeps the splash effect within the circle
                        borderRadius: BorderRadius.circular(100.0),
                        //Something large to ensure a circle
                        onTap: () async {
                          String photoScanResult = await scanner.scanPhoto();

                        },
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.qr_code_scanner,
                            size: 15.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _loadStudent() async {
    context.read<StudentBloc>().add(FetchStudent());
  }
}
