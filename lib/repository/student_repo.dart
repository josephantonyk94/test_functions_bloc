import 'package:test_functions/dao/student_dao.dart';
import 'package:test_functions/model/student.dart';

class StudentRepo{
    final StudentDao _studentDao=StudentDao();
    Future getStudentList()=>_studentDao.getStudentList();
    Future createStudent(Student student)=>_studentDao.createStudent(student);

}