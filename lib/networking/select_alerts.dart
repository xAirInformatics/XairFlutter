import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import './constants.dart';

Future selectAlertNumbers({required String from, required String to}) async {
  try {
    late var response;
    if (from!= '' && to !='') {
      Map <String, String> data = {
        'from': from,
        'to': to
      };

      response = await http.post(
          Uri.parse('$root/api/method/fual_doc.api.cards_api.get_data'),
          headers: headers,
          body:{
            "filters" : json.encode(data)
          }
      );
    }
    else {
      response = await http.post(
          Uri.parse('$root/api/method/fual_doc.api.cards_api.get_data'),
          headers: headers
      );
    }
    if (response.statusCode == 200) {
      var issues = await json.decode(response.body);
      return issues;
    } else {
      return [];
    }
  } on SocketException catch (_) {
    print("Error Happened");
    return [];
  }
}

Future selectAlertsHome(String from, String to) async {
  try {
    Map <String, String> data = {
      'from': from,
      'to': to
    };
    final response = await http.post(
        Uri.parse('$root/api/method/fual_doc.api.tables_api.get_alerts'),
        headers: headers,
        body: {
          "filters" : json.encode(data)
        });
    if (response.statusCode == 200) {
      var issues = await json.decode(response.body);
      return issues;
    } else {
      return [];
    }
  } on SocketException catch (_) {
    if (kDebugMode) {
      print("Error Happened");
    }
    return [];
  }
}

Future selectUsers() async {
  try {
    final response = await http.get(
        Uri.parse('$root/api/resource/User'),
        headers: headers
    );

    if (response.statusCode == 200) {
      var users = await json.decode(response.body);
      return users;
    } else {
      return [];
    }
  } on SocketException catch (_) {
    if (kDebugMode) {
      print("Error Happened");
    }
    return [];
  }
}

Future<String> assignAlertToUser({alert, user, from_date, to_date}) async {
  try {
    final response = await http.post(
      Uri.parse('$root/api/method/fual_doc.api.assignment.assign_to_user'),
      headers: headers,
      body: {'alert': alert, 'user' : user, 'from_date' : from_date , 'to_date': to_date},
    );
    print (response.toString());
    if (response.statusCode == 200) {
      var re = await json.decode(response.body);
      re = re["message"]["status"];
      return re;
    }
    else {
      return "Error";
    }
  }
  catch (e) {
    return "Error Happend";
  }
}