import 'package:equatable/equatable.dart';
import 'package:test_functions/model/student.dart';

abstract class StudentState extends Equatable{
  @override
  List<Object> get props {
  }
}
class StudentInitState extends StudentState{}
class StudentLoadingState extends StudentState{
}
class StudentLoadedState extends StudentState{
  final List<Student> list;

  StudentLoadedState(this.list);

}