import 'package:test_functions/db/database.dart';
import 'package:test_functions/model/student.dart';
import 'package:uuid/uuid.dart';

class StudentDao{
  final dbProvider = DataBaseProvider.dbProvider;

  Future<List<Student>> createStudent(Student student)async{

    var uid= Uuid().v1();
    student.uniqueId=uid;
Student student1=Student(uniqueId: uid,name: student.name,mobileNo: student.mobileNo);
    print(student.uniqueId);
    final db =await dbProvider.createDataBase();
    var result=db.insert("student",student.toStudentMap());
    print(result);

      return getStudentList();

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