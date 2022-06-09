// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_10/api/funtion.dart';
import 'package:http/http.dart' as http;

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Createddata obj = Createddata();
  TextEditingController nameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController deathsController = TextEditingController();
  TextEditingController recoveredController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  @override
  void initState() {
    super.initState();
    getdata();
    datadelet(id);
    obj.datacreated(nameController.text,lNameController.text,deathsController.text,recoveredController.text,monthController.text);
  }

  List data = [];
  String? id;
  Future getdata() async {
    final responce =
    await http.get(Uri.parse('http://127.0.0.1:8000/api/dengue-info'));
    if (responce.statusCode == 200) {
      setState(() {
        data = jsonDecode(responce.body);
      });
      print('Add data$data');
    } else {
      print('error');
    }
  }

  Future datadelet(id) async {
    final responce = await http
        .delete(Uri.parse('http://127.0.0.1:8000/api/dengue-info/$id'));
    print(responce.statusCode);

    if (responce.statusCode == 200) {
      print('DELETE COMPLETE');
    } else {
      print('nOT dELET');
    }
  }

  Future update() async {
    final responce = await http
        .put(Uri.parse('http://127.0.0.1:8000/api/dengue-info/1'),
        body: jsonEncode({
          "name": nameController.text,
          "lName": lNameController.text,
          "deaths": deathsController.text,
          "recovered": recoveredController.text,
          "month": monthController.text,

        }),
        headers: {
          'Content-type': 'application/json; ',
        });
    print(responce.statusCode);
    if (responce.statusCode == 200) {
      print('Data Update Successfully');
      nameController.clear();

    } else {
      print('error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: 'Name',
                  ),
                ),
                TextField(
                  controller: lNameController,
                  decoration: InputDecoration(
                    hintText: 'Last Name',
                  ),
                ),
                TextField(
                  controller: deathsController,
                  decoration: InputDecoration(
                    hintText: 'Deaths',
                  ),
                ),
                TextField(
                  controller: recoveredController,
                  decoration: InputDecoration(
                    hintText: 'Recovered',
                  ),
                ),
                TextField(
                  controller: monthController,
                  decoration: InputDecoration(
                    hintText: 'Month',
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            obj.datacreated(
                              nameController.text,
                              lNameController.text,
                              deathsController.text,
                              recoveredController.text,
                              monthController.text,
                            );
                          });
                        },
                        child: Text('Submit')),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            update();
                          });
                        },
                        child: Text('Update')),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(data[index]['name'])
                                  ],
                                ),
                                Row(
                                children: [
                                Text(data[index]['lName'])
                                ],
                                ),
                                Row(
                                children: [
                                Text(data[index]['deaths'])
                                ],
                                ),
                                Row(
                                children: [
                                Text(data[index]['recovered'])
                                ],
                                ),
                                Row(
                                children: [
                                Text(data[index]['month'])
                                ],
                                ),
                             Container(
                              width: 100,
                              child: Column(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        brandController.text =
                                        data[index]['name'];

                                        nameController.text =
                                        data[index]['lName'];

                                        colorController.text =
                                        data[index]['deaths'];

                                        sizeController.text =
                                        data[index]['recovered'];

                                        prizeController.text =
                                        data[index]['month'];

                                      },
                                      icon: Icon(Icons.edit)),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          datadelet(data[index]['id']);
                                        });
                                      },
                                      icon: Icon(Icons.delete))
                                ],
                              ),
                            ),
                                ]
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

