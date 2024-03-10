import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{

//Add employee function
  Future addEmployeeDetails(Map<String,dynamic> employeeInfoMap, String id )async{
    return await FirebaseFirestore.instance
    .collection("Employee")
    .doc(id)
    .set(employeeInfoMap);
  }

  //Retrieve Employee data

  Future<Stream<QuerySnapshot>> getEmployeeDetails() async{
    return await FirebaseFirestore.instance.collection("Employee").snapshots();
  }
}