import 'package:doma_app/doma_app/resources/dash_board/system_account/change_password.dart';
import 'package:doma_app/doma_app/resources/dash_board/system_account/personal_info.dart';
import 'package:doma_app/doma_app/resources/dash_board/user_drawer/drawer_user_controller.dart';
import 'package:doma_app/doma_app/resources/dash_board/user_drawer/home_drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import '../../../../app_theme.dart';
import '../../login_page.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({Key? key}) : super(key: key);

  @override
  _MyAccountScreenState createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  Widget? screenView;
  DrawerIndex? drawerIndex;

  @override
  void initState() {
    drawerIndex = DrawerIndex.info;
    screenView = const PersonalInfoScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: DrawerUserController(
            screenView: screenView,
            screenIndex: drawerIndex,
            drawerWidth: MediaQuery.of(context).size.width * 0.6,
            onDrawerCall: (DrawerIndex drawerIndexdata) {
              changeIndex(drawerIndexdata);
              //callback from drawer for replace screen as user need with passing DrawerIndex(Enum index)
            },
            //we replace screen view as we need on navigate starting screens like MyHomePage, HelpScreen, FeedbackScreen, etc...
          ),
        ),
      ),
    );
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    /*setState(() {
      screenView = const PersonalInfoScreen();
    });*/ //neu muon trang my account la mot trang khac thi them cai nay de co the chon trang dau tien
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      if (drawerIndex == DrawerIndex.info) {
        setState(() {
          screenView = const PersonalInfoScreen();
        });
      } if (drawerIndex == DrawerIndex.changePass) {
        setState(() {
          screenView = const ChangePassScreen();
        });
      }
      else if (drawerIndex == DrawerIndex.logout) {
        setState(() {
          logout();
        });
      }
    }
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('login');
    final response = await http.post(
      Uri.parse('http://doma.hexon.systems:4000/api/auth/logout'),
      headers: {
        HttpHeaders.contentTypeHeader: "text/html; charset=utf-8",
        HttpHeaders.authorizationHeader: "Bearer $token",
      },
    );
    if (response.statusCode == 200) {
      prefs.remove('login');
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginPage()), (
          route) => false);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Logout unsuccessful")));
    }
  }
}
