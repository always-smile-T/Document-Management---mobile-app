import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../blocs/login_bloc.dart';
import 'dash_board/ui_view/doma_app_home_screen.dart';
import 'dash_board/ui_view/doma_app_theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc bloc = LoginBloc();

  bool _showPass = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void checkLogin() async{
    //thu cai nay di
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? val = pref.getString("login");
    if(val != null) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: gotoDashboard), (route) => false);
      Navigator.push(context, MaterialPageRoute(builder: gotoDashboard));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        constraints: const BoxConstraints.expand(),
        color: DomaAppTheme.nearlyDarkBlue
            .withOpacity(0.6),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 120,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 60),
                child: Text(
                  "Hello\nWelcome to login page",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 30),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                  child: StreamBuilder(
                      stream: bloc.emailStream,
                      builder: (context, snapshot) =>
                          TextField(
                            cursorColor: Colors.white,
                            style: const TextStyle(
                                fontSize: 18, color: Colors.white),
                            controller: _emailController,
                            decoration: InputDecoration(
                                labelText: "USERNAME",
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black38),
                                ),
                                errorText: snapshot.hasError
                                    ? snapshot.error.toString()
                                    : null,
                                labelStyle:
                                const TextStyle(
                                    color: Colors.white, fontSize: 15)),
                          ))),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children: <Widget>[
                    StreamBuilder(
                      stream: bloc.passStream,
                      builder: (context, snapshot) =>
                          TextField(
                            cursorColor: Colors.white,
                            style: const TextStyle(
                                fontSize: 18, color: Colors.white),
                            controller: _passController,
                            obscureText:
                            !_showPass,
                            //cho nay true thi giau pass, con failse thi ...
                            //cho nay true thi giau pass
                            decoration: InputDecoration(
                                labelText: "PASSWORD",
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black38),
                                ),
                                errorText: snapshot.hasError
                                    ? snapshot.error.toString()
                                    : null,
                                labelStyle: const TextStyle(
                                    color: Colors.white, fontSize: 15)),
                          ),),
                    GestureDetector(
                      onTap: onToggleShowPass,
                      child: Text(
                        _showPass ? "HIDE" : "SHOW",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                      child: const Text('SIGN IN', style: TextStyle(color: Colors.white)),
                      onPressed: login,
                      style: ButtonStyle(
                          backgroundColor:
                          //MaterialStateProperty.all<Color>(Colors.deepPurple),
                          MaterialStateProperty.all<Color>(Colors.blueAccent),
                          overlayColor: MaterialStateProperty.all<Color>(
                              Colors.white70),
                          foregroundColor:
                          // MaterialStateProperty.all<Color>(Colors.lightBlueAccent),
                          MaterialStateProperty.all<Color>(Colors.white70),
                          elevation: MaterialStateProperty.resolveWith<double>(
                                (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed) ||
                                  states.contains(MaterialState.disabled)) {
                                return 0;
                              }
                              return 10;
                            },
                          ))

                  ),
                ),
              ),
              SizedBox(
                height: 130,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const <Widget>[
                    Text(
                      'FORGOT PASSWORD?',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    )
                  ],
                ),
              ),
            ],
          ),
        )

        //child: Text("data"),
        // SvgPicture.asset('assets/images/logo.svg'),
      ),
    );
  }

  void onToggleShowPass() {
    setState(() {
      _showPass = !_showPass; //lay phu dinh
    });
  }

  /*Widget gotoDocument(BuildContext context) {
    return const DocumentPage();
    //nay de test o local
  }*/

  Widget gotoDashboard(BuildContext context) {
    return const DoMaAppHomeScreen();
  }

  //CREATE FUNCTION TO CAL LOGIN POST API
  Future<void> login() async {
    if(_passController.text.isNotEmpty && _emailController.text.isNotEmpty){
      if (bloc.isValidUsername(_emailController.text) && bloc.isValidPassword(_passController.text))
      {
        var response = await http.post(Uri.parse("http://doma.hexon.systems:4000/api/auth/login"),
            body: ({
              "username": _emailController.text,
              "password": _passController.text
            }));
        if (response.statusCode == 200) {
          final body = jsonDecode(response.body);
          //print("Login token " + body.toString());
          //ScaffoldMessenger.of(context)
          //   .showSnackBar(SnackBar(content: Text("Token : ${body['access_token']}")));
          //Here , i store value or token inside shared preferences
          SharedPreferences pref = await SharedPreferences.getInstance();
          await pref.setString("login", body['access_token']);
          //Navigator.push(context, MaterialPageRoute(builder: gotoDashboard));
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: gotoDashboard), (route) => false);
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("wrong email or password")));
        }
      }
      else {
      }
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Email and password cannot be blank")));
    }

  }


}