import 'dart:convert';
import 'dart:io';
import 'package:doma_app/doma_app/model/document/personal_document.dart';
import 'package:doma_app/doma_app/model/personal_info/info.dart';
import 'package:doma_app/doma_app/model/template/template.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<Document> showDocument(String id, String name) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('login');
  final response = await http.get(
    Uri.parse('http://doma.hexon.systems:4000/api/personal-documents/folders?id=$id&name=$name'),
    headers: {
      HttpHeaders.contentTypeHeader: "application/json; charset=utf-8",
      HttpHeaders.authorizationHeader: "Bearer $token",
    },
  );

  final responseJson = jsonDecode(response.body);
  //print(responseJson);
  return Document.fromJson(responseJson);
}


Future<Template_> showTemplate(String id, String name) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('login');
  final response = await http.get(
      Uri.parse('http://doma.hexon.systems:4000/api/folders?id=$id&name=$name'),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json; charset=utf-8",
        HttpHeaders.authorizationHeader: "Bearer $token",
      }
  );

  final responseJson = jsonDecode(response.body);
  //print(responseJson);
  return Template_.fromJson(responseJson);
}

Future<PersonalInfo> fetchInfo() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('login');
  final response = await http.get(
    Uri.parse('http://doma.hexon.systems:4000/api/users/profile'),
    headers: {
      HttpHeaders.contentTypeHeader: "application/json; charset=utf-8",
      HttpHeaders.authorizationHeader: "Bearer $token",
    },
  );
  final responseJson = jsonDecode(response.body);
  //print(responseJson);
  return PersonalInfo.fromJson(responseJson);
}