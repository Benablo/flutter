import 'dart:convert';

import 'package:http/http.dart' as http;



class Createddata {



  Future datacreated(nametext,lNametext,deathstext,recoveredtext,monthtext) async {
    final responce =
    await http.post(Uri.parse('http://127.0.0.1:8000/api/dengue-info'),
        body: jsonEncode({
          "name":nametext,
          "lName":lNametext,
          "deaths":deathstext,
          "recovered":recoveredtext,
          "month":monthtext,

        }),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        });
    print(responce.statusCode);
    if (responce.statusCode == 200) {

      print('Data Created Successfully');
    } else {
      print('error');
    }
  }

}

