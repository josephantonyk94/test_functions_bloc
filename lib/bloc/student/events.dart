import 'package:test_functions/model/student.dart';

class StudentEvents{
}
class CreateStudent extends StudentEvents{
final Student student;
  CreateStudent(this.student);
}
class FetchStudent extends StudentEvents{
}
class GenPdf extends StudentEvents{
}
class ScanQrCode extends StudentEvents{}
