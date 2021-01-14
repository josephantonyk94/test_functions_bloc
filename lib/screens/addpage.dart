import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_functions/bloc/student/bloc.dart';
import 'package:test_functions/bloc/student/events.dart';
import 'package:test_functions/model/student.dart';
import 'package:test_functions/screens/student_list_screen.dart';

class AddPage extends StatefulWidget {

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {super.dispose();
    nameController.dispose();
    mobileController.dispose();
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Text("name of student"),
        TextField(controller: nameController,),
        Text("mobile"),
        TextField(controller: mobileController,),
        RaisedButton(onPressed: () {
          if (nameController.text.isNotEmpty &&
              mobileController.text.isNotEmpty) {
            Student s= Student(
                mobileNo: mobileController.text,
                name: nameController.text);
           context.read<StudentBloc>().add(CreateStudent(s));
           Navigator.of(context).pop("REsultt");
          }
        }, child: Text("add"),)
      ]),
      appBar: AppBar(leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: ()=>Navigator.pop(context)),
        title: Text("add Student"),
      ),
    );
  }
}
