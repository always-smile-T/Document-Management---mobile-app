import 'dart:async';

import 'package:doma_app/doma_app/validators/validation.dart';




class LoginBloc {
  final StreamController _emailController = StreamController();
  final StreamController _passController = StreamController();

  Stream get emailStream => _emailController.stream;
  // cu fap vjt tat
  Stream get passStream => _passController.stream;
  // k viet tat thi viet nhu under

  //Stream getUserStream(){
  // return _userController.stream;
  //}

  bool isValidUsername(String username) {
    if (!Validation.isValidUser(username)) {
      _emailController.sink.addError("wrong email format");
      //sink la input
      //stream la output
      return false;
    }
    _emailController.sink.add("OK");
    return true;
  }
  bool isValidPassword(String password) {
    if (!Validation.isValidPass(password)) {
      _passController.sink.addError("min is 6 characters");
      return false;
    }
    _passController.sink.add("OK");
    return true;
  }


  void dispose() {
    // huy stream khi k dung toi
    _emailController.close();
    _passController.close();
  }
}
