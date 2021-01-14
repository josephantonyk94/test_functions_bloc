import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class Student {
  int id;
  String name;
  String mobileNo;
  String uniqueId;

  Student({this.id, this.name, this.mobileNo, this.uniqueId});

  Map<String, dynamic> toStudentMap() => {
        "id": this.id,
        "name": this.name,
        "mobile_no": this.mobileNo,
        "unique_id": this.uniqueId
      };

  factory Student.fromJson(Map<String, dynamic> json) => Student(
      id: json['id'],
      mobileNo: json['mobile_no'],
      name: json['name'],
      uniqueId: json['unique_id']);
}
