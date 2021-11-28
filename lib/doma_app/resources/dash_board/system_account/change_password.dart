import 'dart:io';
import 'package:doma_app/doma_app/model/personal_info/info.dart';
import 'package:doma_app/doma_app/rest_api/rest_api_get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePassScreen extends StatefulWidget {
  const ChangePassScreen({Key? key}) : super(key: key);

  @override
  _ChangePassScreenState createState() => _ChangePassScreenState();
}

class _ChangePassScreenState extends State<ChangePassScreen> {
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
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
                                    const Text('Change password', style: TextStyle(fontSize: 18, color: Colors.black54),textAlign:  TextAlign.center)
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                            height: 40,
                            alignment: Alignment.bottomLeft,
                            margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                            child: const Text('Current password', style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500),textAlign: TextAlign.start,)
                        ),
                        Container(
                          height: 50,
                          margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              width: 1,
                              color: Colors.deepPurpleAccent,
                            ),
                          ),
                          child: TextField(
                            cursorColor: Colors.black,
                            controller: _currentPasswordController,
                            obscureText: true,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.black),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(borderSide: BorderSide.none),
                              hintText: 'Type your current password',
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),

                            ),
                          ),
                        ),
                        Container(
                            height: 40,
                            margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                            alignment: Alignment.bottomLeft,
                            child: const Text('New password', style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500),textAlign: TextAlign.start,)
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
                          child: TextField(
                            obscureText: true,
                            cursorColor: Colors.black,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.black),
                            controller: _newPasswordController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(borderSide: BorderSide.none),
                              hintText: 'Must have at least 6 characters',
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        Container(
                            height: 40,
                            margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                            alignment: Alignment.bottomLeft,
                            child: const Text('Confirm new password', style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500),textAlign: TextAlign.start,)
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
                          child: TextField(
                            cursorColor: Colors.black,
                            obscureText: true,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.black),
                            controller: _confirmPasswordController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(borderSide: BorderSide.none),
                              hintText: 'Must have at least 6 characters',
                              focusedBorder: OutlineInputBorder(
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
                              child: const Text('Change', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),),
                              onPressed: changePassword,
                              style: ButtonStyle(
                                fixedSize: MaterialStateProperty.all(const Size.fromHeight(40)),
                                backgroundColor:
                                //MaterialStateProperty.all<Color>(Colors.deepPurple),
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
  Future changePassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('login');
    if(_currentPasswordController.text.isNotEmpty &&
        _newPasswordController.text.isNotEmpty &&
        _confirmPasswordController.text.isNotEmpty){
      if(_newPasswordController.text.toString() == _confirmPasswordController.text.toString()){
        var response = await http.post(
            Uri.parse("http://doma.hexon.systems:4000/api/users/password"),
            headers: <String, String>{
              'Context-Type': 'application/json;charset=UTF-8',
              HttpHeaders.authorizationHeader: "Bearer $token",
            },
            body: <String, String>{
              "oldPassword": _currentPasswordController.text,
              "newPassword": _newPasswordController.text,
            });
        if (response.statusCode == 201) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Your password has been changed")));
        }else{
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Your password is wrong")));
        }
      }else{
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("New password not confirm")));
      }
    }else{
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("First Name, last name or phone number cannot be blank")));
    }

  }
}
