import 'dart:io';
import 'package:doma_app/doma_app/model/personal_info/info.dart';
import 'package:doma_app/doma_app/rest_api/rest_api_get.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({Key? key}) : super(key: key);

  @override
  _PersonalInfoScreenState createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  static TextEditingController _firstNameController = TextEditingController();
  static TextEditingController _lastNameController = TextEditingController();
  static TextEditingController _phoneNumberController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PersonalInfo>(
      future: fetchInfo(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.deepPurpleAccent,
            ),
          );
        }
        if (snapshot.hasData) {
          _firstNameController = TextEditingController(text: snapshot.data!.firstName);
          _lastNameController = TextEditingController(text: snapshot.data!.lastName);
          _phoneNumberController = TextEditingController(text: '${snapshot.data!.phoneNumber}');
          return Scaffold(
              body: Column(
                children: [
                  Expanded(
                    child:ListView(
                      children: <Widget>[
                        SizedBox(
                          height: 200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 120,
                                width: 120,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: ClipRRect(
                                  borderRadius:
                                  const BorderRadius.all(Radius.circular(80.0)),
                                  child: SvgPicture.asset('assets/images/avatar.svg'),
                                ),
                              ),
                              SizedBox(
                                height: 70,
                                child: Column(
                                  children: [
                                    Text(snapshot.data!.firstName + ' ' + snapshot.data!.lastName, style: const TextStyle(fontSize: 28, color: Colors.black, fontWeight: FontWeight.bold),textAlign:  TextAlign.center,),
                                    const Text('Personal info', style: TextStyle(fontSize: 18, color: Colors.black54),textAlign:  TextAlign.center)
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(child: Column(
                              children: [
                                Container(
                                    margin: const EdgeInsets.fromLTRB(25, 0, 10, 0),
                                    height: 40,
                                    //width: 165,
                                    alignment: Alignment.bottomLeft,
                                    child: const Text('First name', style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500),textAlign: TextAlign.start,)
                                ),
                                Container(
                                  margin:const EdgeInsets.fromLTRB(25, 0, 10, 0),
                                  height: 50,
                                  //width: 165,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.deepPurpleAccent,
                                    ),
                                  ),
                                  child: TextField(
                                    cursorColor: Colors.black,
                                    style: const TextStyle(
                                        fontSize: 20, color: Colors.black),
                                    controller: _firstNameController,
                                    decoration: InputDecoration(
                                      border: const OutlineInputBorder(borderSide: BorderSide.none,),
                                      hintText: snapshot.data!.firstName,
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                            Expanded(child: Column(
                              children: [
                                Container(
                                    margin:const EdgeInsets.fromLTRB(10, 0, 25, 0),
                                    height: 40,
                                    //width: 165,
                                    alignment: Alignment.bottomLeft,
                                    child: const Text('Last name', style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500),textAlign: TextAlign.start,)
                                ),
                                Container(
                                  margin: const EdgeInsets.fromLTRB(10, 0, 25, 0),
                                  height: 50,
                                  //width: 165,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.deepPurpleAccent,
                                    ),
                                  ),
                                  child: TextField(
                                    cursorColor: Colors.black,
                                    style: const TextStyle(
                                        fontSize: 20, color: Colors.black),
                                    controller: _lastNameController,
                                    decoration: InputDecoration(
                                      border:const  OutlineInputBorder(borderSide: BorderSide.none),
                                      hintText: snapshot.data!.lastName,
                                      focusedBorder:const OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ))
                          ],
                        ),
                        Container(
                            height: 40,
                            alignment: Alignment.bottomLeft,
                            margin:const EdgeInsets.fromLTRB(25, 0, 25, 0),
                            child: const Text('Email', style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500),textAlign: TextAlign.start,)
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              width: 1,
                              color: Colors.deepPurpleAccent,
                            ),
                          ),
                          height: 50,
                          margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                          alignment: Alignment.centerLeft,
                          child: Text('  ' + snapshot.data!.email, style: const TextStyle(fontSize: 20, color: Colors.black45),textAlign: TextAlign.start, ),
                        ),
                        Container(
                            height: 40,
                            margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                            alignment: Alignment.bottomLeft,
                            child: const Text('Phone', style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500),textAlign: TextAlign.start,)
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              width: 1,
                              color: Colors.deepPurpleAccent,
                            ),
                          ),
                          child: TextField(
                            cursorColor: Colors.black,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.black),
                            controller: _phoneNumberController,
                            decoration: InputDecoration(
                              border: const  OutlineInputBorder(borderSide: BorderSide.none),
                              hintText: snapshot.data!.phoneNumber,
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 40,
                          width: 50,
                          alignment: Alignment.centerRight,
                          margin: const EdgeInsets.fromLTRB(0, 20, 25, 0),
                          child: ElevatedButton(
                              child: const Text('Update', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600), textAlign: TextAlign.center,),
                              onPressed: updateInfo,
                              style: ButtonStyle(
                                fixedSize: MaterialStateProperty.all(const Size.fromHeight(40)),
                                backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.deepPurpleAccent),
                                overlayColor: MaterialStateProperty.all<Color>(
                                    Colors.white70),
                                foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white70),)
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    //height: MediaQuery.of(context).padding.bottom,
                    height: 70,//MediaQuery.of(context).padding.bottom,
                  ),
                ],
              )
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }
        return const Center(
          child: Text('Error'),
        );
      },
    );
  }

  Future updateInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('login');
    if(_firstNameController.text.isNotEmpty && _lastNameController.text.isNotEmpty && _phoneNumberController.text.isNotEmpty){
      var response = await http.put(
          Uri.parse("http://doma.hexon.systems:4000/api/users/profile"),
          headers: <String, String>{
            'Context-Type': 'application/json;charset=UTF-8',
            HttpHeaders.authorizationHeader: "Bearer $token",
          },
          body: <String, String>{
            "firstName": _firstNameController.text,
            "lastName": _lastNameController.text,
            "phoneNumber": _phoneNumberController.text
          });
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Your info has been updated")));
      }else{
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("unsuccessful")));
      }
    }else{
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("First Name, last name or phone number cannot be blank")));
    }
  }
}
