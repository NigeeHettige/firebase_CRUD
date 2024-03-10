import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
//Add employee function
  Future addEmployeeDetails(
      Map<String, dynamic> employeeInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Employee")
        .doc(id)
        .set(employeeInfoMap);
  }

  //Retrieve Employee data

  Future<Stream<QuerySnapshot>> getEmployeeDetails() async {
    return await FirebaseFirestore.instance.collection("Employee").snapshots();
  }

  //Update Employee details

  Future updateEmployeeDetails(
      String id, Map<String, dynamic> updateInfo) async {
    return await FirebaseFirestore.instance
        .collection("Employee")
        .doc(id)
        .update(updateInfo);
  }
  Future deleteEmployeeDetails(
      String id) async {
    return await FirebaseFirestore.instance
        .collection("Employee")
        .doc(id).delete()
        ;
  }
}
