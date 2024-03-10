import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/pages/employee.dart';
import 'package:firebase_crud/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController agecontroller = TextEditingController();
  TextEditingController locationcontroller = TextEditingController();

  //Retrieve employee
  Stream? EmployeeStream;

  getontheload() async {
    EmployeeStream = await DatabaseMethods().getEmployeeDetails();
    setState(() {});
  }

  @override
  void initState() {
    getontheload();
    super.initState();
  }

  Widget allEmployeeDetails() {
    return StreamBuilder(
        stream: EmployeeStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];

                    return Container(
                      margin: const EdgeInsets.only(bottom: 20.0),
                      child: Material(
                        elevation: 5.0,
                        child: Container(
                          padding: const EdgeInsets.all(20.0),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Name: " + ds["Name"],
                                    style: const TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0),
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      EditEmployeeDetail(ds["Id"]);
                                      namecontroller.text = ds["Name"];
                                      agecontroller.text = ds["Age"];
                                      locationcontroller.text = ds["Location"];
                                    },
                                    child: const Icon(
                                      Icons.edit,
                                      color: Colors.orange,
                                    ),
                                  ),
                                  const SizedBox(width: 5.0),
                                  GestureDetector(
                                    onTap: () async {
                                      await DatabaseMethods()
                                          .deleteEmployeeDetails(ds["Id"]);
                                    },
                                    child: const Icon(
                                      Icons.delete,
                                      color: Color.fromARGB(255, 231, 113, 104),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "Age: " + ds["Age"],
                                style: const TextStyle(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                              Text(
                                "Location: " + ds["Location"],
                                style: const TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  })
              : Container();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Employee()),
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Flutter',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Firebase',
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
        margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
        child: Column(
          children: [
            Expanded(
              child: allEmployeeDetails(),
            ),
          ],
        ),
      ),
    );
  }

  Future EditEmployeeDetail(String id) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.cancel),
                    ),
                    const SizedBox(
                      width: 60.0,
                    ),
                    const Text(
                      "Edit",
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                    const Text(
                      "Details",
                      style: TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Text(
                  'Name',
                  style: TextStyle(
                      fontSize: 20.0,
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
                      fontSize: 20.0,
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
                      fontSize: 20.0,
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
                    Map<String, dynamic> updateInfo = {
                      "Name": namecontroller.text,
                      "Age": agecontroller.text,
                      "Location": locationcontroller.text,
                      "Id": id,
                    };

                    await DatabaseMethods()
                        .updateEmployeeDetails(id, updateInfo)
                        .then((value) {
                      Navigator.pop(context);
                    });
                  },
                  child: const Text("Update"),
                )),
              ],
            ),
          ),
        ),
      );
}
