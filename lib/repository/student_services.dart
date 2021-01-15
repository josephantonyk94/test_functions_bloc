import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:test_functions/model/student.dart';


Future<bool> genPdf(List<Student> list)async{
  _askForPermission();
   Uint8List uint8list=await _generateDocument(list);
   _savePdf(uint8list);
   return true;

 }
Future<Uint8List> _generateDocument(List<Student> list) async {
  _askForPermission();
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
                <String>[
                  '${i + 1}) ${list.elementAt(i).id}',
                  '${list.elementAt(i).name}',
                  '${list.elementAt(i).mobileNo}'
                ],
            ]),
        pw.Paragraph(text: ""),
        //  pw.Paragraph(text: "Subtotal: $total"),
        pw.Padding(padding: const pw.EdgeInsets.all(10)),
      ]));

  return doc.save();
}
Future<bool> _askForPermission() async {
  if (await Permission.storage.isGranted) {
    print(
        "permission granted"); // Either the permission was already granted before or the user just granted it.
  } else {
// You can request multiple permissions at once.
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();
    print(statuses[Permission.location]);
  }
}


_savePdf(Uint8List uint8list) async {
  File file;
  await getExternalStorageDirectory();
  String output = "/storage/emulated/0/Download";
  file = File(output + "/example.pdf");
    file.writeAsBytes(uint8list);

}
