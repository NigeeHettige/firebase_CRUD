import 'package:firebase_crud/services/database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart';

class Employee extends StatefulWidget {
  const Employee({super.key});

  @override
  State<Employee> createState() => _EmployeeState();
}

class _EmployeeState extends State<Employee> {
  TextEditingController namecontroller =  TextEditingController();
  TextEditingController agecontroller = TextEditingController();
  TextEditingController locationcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Employee',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Form',
              style: TextStyle(
                color: Color.fromARGB(255, 243, 227, 83),
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20.0, top: 30.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Name',
              style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Container(
              padding: const EdgeInsets.only(left: 10.0),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: namecontroller,
                decoration: const InputDecoration(border: InputBorder.none),
              ),
            ),
            const Text(
              'Age',
              style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Container(
              padding: const EdgeInsets.only(left: 10.0),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: agecontroller,
                decoration: const InputDecoration(border: InputBorder.none),
              ),
            ),
            const Text(
              'Location',
              style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Container(
              padding: const EdgeInsets.only(left: 10.0),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: locationcontroller,
                decoration: const InputDecoration(border: InputBorder.none),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Center(
                child: ElevatedButton(
                    onPressed: () async {
                      String id = randomAlphaNumeric(10);
                      Map<String, dynamic> employeeInfoMap = {
                        "Id" : id,
                        "Name": namecontroller.text,
                        "Age": agecontroller.text,
                        "Location": locationcontroller.text,
                      };

                      await DatabaseMethods()
                          .addEmployeeDetails(employeeInfoMap, id)
                          .then((value) => {
                                Fluttertoast.showToast(
                                    msg: "Successfully added the Employee",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 2,
                                    backgroundColor: const Color.fromARGB(255, 127, 233, 130),
                                    textColor: Colors.white,
                                    fontSize: 16.0)
                              });
                    },
                    child: const Text(
                      'Add',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    )))
          ],
        ),
      ),
    );
  }
}
