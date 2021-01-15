import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_functions/dao/student_dao.dart';
import 'package:test_functions/repository/student_services.dart';

import '../../model/student.dart';
import '../../repository/student_repo.dart';
import 'events.dart';
import 'states.dart';


class StudentBloc extends Bloc<StudentEvents,StudentState>{
  List<Student> studentList;
 final StudentRepo studentRepo;
  StudentBloc({this.studentRepo}) : super(StudentInitState());

   mapevent()async*{
     print("hello");
     yield "helloo";
   }
  @override
Stream<StudentState> mapEventToState(StudentEvents event) async*{

switch(event.runtimeType){
  case FetchStudent:yield StudentLoadingState();
  try{
    print("in repo cretion");
    studentList= await studentRepo.getStudentList();
    print(studentList);
    yield StudentLoadedState(studentList);
  } catch(e){
  }
  break;
  case CreateStudent: yield StudentLoadingState();
  try{
   if(event is CreateStudent){
     print(event.student.name);

    studentList= await StudentRepo().createStudent(event.student);
    if(studentList!=null){
      print("list has darta $studentList");
    }
    print(studentList.first.name);
    yield StudentLoadedState(studentList);
    }
  }catch(e){

  }
  break;

}
if (event is GenPdf){
  yield StudentLoadingState();
  try {
    studentList= await studentRepo.getStudentList();
    bool generatedpdf=await genPdf(studentList);
    if(generatedpdf==true ){
      yield StudentLoadedState(studentList);
    }
  } on Exception catch (e) {
    // TODO
  }
}
  }
}