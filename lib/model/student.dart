import 'package:flutter/cupertino.dart';

class Student{
  int id;
  String name;
  String mobileNo;
  Student({this.id,this.name,this.mobileNo});
  Map<String,dynamic> toStudentMap()=>{
  "id":this.id,
   "name":this.name,
   "mobile_no":this.mobileNo
  };
 factory Student.fromJson(Map<String,dynamic>json)=>Student(id: json['id'],mobileNo: json['mobile_no'],name: json['name']);

}