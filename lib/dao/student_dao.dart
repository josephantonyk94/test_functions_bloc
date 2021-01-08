import 'package:test_functions/db/database.dart';
import 'package:test_functions/model/student.dart';

class StudentDao{
  final dbProvider = DataBaseProvider.dbProvider;

  Future createStudent(Student student)async{
    final db =dbProvider.createDataBase();
    var result=db.insert("student",student.toStudentMap());
    return result;
  }
  Future<List<Student>> getStudentList()async{
final db=await dbProvider.createDataBase();
List<Map<String,dynamic>> result;
result=await db.query("student");
List<Student> studentList=result.isNotEmpty?result.map((e) => Student.fromJson(e)).toList():[];
return studentList;
  }
  Future getStudent(Student student)async{

  }
}