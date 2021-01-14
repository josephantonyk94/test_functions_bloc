import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
 import 'package:test_functions/bloc/student/bloc.dart';
import 'package:test_functions/model/student.dart';
import 'package:test_functions/screens/student_details.dart';
import '../bloc/student/events.dart';
import '../bloc/student/states.dart';
import 'addpage.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

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
    List<Student> studentList=[];
    return Scaffold(key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Student screen"),
      ),
      body: Column(
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
          BlocConsumer<StudentBloc, StudentState>(listener: (context, state) {
            print("some event happened");
          }, builder: (context, state) {
            if (state is StudentLoadedState) {
              List<Student> listStudent = state.list;
              studentList=state.list;

              return Expanded(
                child: ListView.builder(
                  itemBuilder: (context, int index) {
                    print(listStudent.last.mobileNo);
                    return Container(
                      child: ListTile(
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => StudentDetails(listStudent[index]))),
                        contentPadding: EdgeInsets.all(10),
                        title: Text(listStudent[index].name,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        trailing:Text(
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
                    ),);
                  },
                  itemCount: listStudent.length,
                ),
              );
            }
            return CircularProgressIndicator();
          }),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                  onPressed: () async {
                    final result =
                    await Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            BlocProvider.value(
                              value: StudentBloc(),
                              child: AddPage(),
                            )));
                    result != null ? _loadStudent() : print("no result");
                  },
                  child: Text("add"),
                ),
                RaisedButton(
                  onPressed:()=> _genPdf(studentList),
                  child: Text(
                    "Gen Pdf",
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<Uint8List> generateDocument(List<Student> list) async {
    print("in gene doc");
    final pw.Document doc = pw.Document();

    doc.addPage(pw.MultiPage(
        pageFormat:
        PdfPageFormat.letter.copyWith(marginBottom: 1.5 * PdfPageFormat.cm),
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        header: (pw.Context context) {
          if (context.pageNumber == 1) {
            return null;
          }
          return pw.Container(
              alignment: pw.Alignment.centerRight,
              margin: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
              padding: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
               decoration: const pw.BoxDecoration(
              //     border: pw.BoxBorder(
              //         bottom: true, width: 0.5, color: PdfColors.grey)
              ),
              child: pw.Text('Student Data List',
                  style: pw.TextStyle(font: pw.Font.courierBold())));
        },
        build: (pw.Context context) => <pw.Widget>[
          pw.Table.fromTextArray(
              context: context,
              border: null,
              headerAlignment: pw.Alignment.centerLeft,
              data: <List<String>>[
                <String>['sl no', 'Name', 'mobile'],
                for (int i = 0; i < list.length; i++)
                  <String>['${i+1}) ${list.elementAt(i).id}', '${list.elementAt(i).name}', '${list.elementAt(i).mobileNo}'],
              ]),
          pw.Paragraph(text: ""),
        //  pw.Paragraph(text: "Subtotal: $total"),
          pw.Padding(padding: const pw.EdgeInsets.all(10)),
        ]));

    return doc.save();
  }
  _genPdf(List<Student> list) async{
   await askForPermission();
 Uint8List uint8list=await generateDocument(list);
 savePdf(uint8list);
  }
  savePdf(Uint8List uint8list)async{
    File file;
    await getExternalStorageDirectory();
      String output = "/storage/emulated/0/Download";
      file = File(output+"/example.pdf");
    setState(() {
      file.writeAsBytes(uint8list);
    });
    
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("downloaded")));
  }
  Future<bool> askForPermission() async{
    if (await Permission.storage.isGranted) {
     print("permission granted"); // Either the permission was already granted before or the user just granted it.
    } else {
// You can request multiple permissions at once.
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
      ].request();
      print(statuses[Permission.location]);
    }
  }

  void _loadStudent() async {
    context.read<StudentBloc>().add(FetchStudent());
  }
}
