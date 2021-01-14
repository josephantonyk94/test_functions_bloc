import 'package:test_functions/dao/student_dao.dart';
import 'package:test_functions/model/student.dart';

class StudentRepo{
    StudentDao studentDao=StudentDao();
    Future getStudentList()=>studentDao.getStudentList();
    Future createStudent(Student student)=>studentDao.createStudent(student);

}