import 'package:doma_app/doma_app/resources/dash_board/bottom_navigator_view/bottom_bar_view.dart';
import 'package:doma_app/doma_app/resources/dash_board/models/tab_icon_data.dart';
import 'package:doma_app/doma_app/resources/dash_board/my_account/account_sreen.dart';
import 'package:doma_app/doma_app/resources/dash_board/my_dashboard/my_dashboard_sreen.dart';
import 'package:doma_app/doma_app/resources/dash_board/my_document/document_screen.dart';
import 'package:doma_app/doma_app/resources/dash_board/template/template_screen.dart';
import 'package:flutter/material.dart';
import 'doma_app_theme.dart';

class DoMaAppHomeScreen extends StatefulWidget {
  const DoMaAppHomeScreen({Key? key}) : super(key: key);

  @override
  _DoMaAppHomeScreenState createState() => _DoMaAppHomeScreenState();
}

class _DoMaAppHomeScreenState extends State<DoMaAppHomeScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: DomaAppTheme.background,
  );

  @override
  void initState() {
    for (var tab in tabIconsList) {
      tab.isSelected = false;
    }
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    tabBody = DashboardScreen(animationController: animationController);
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: DomaAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder<bool>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              return Stack(
                children: <Widget>[
                  tabBody,
                  bottomBar(),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          tabIconsList: tabIconsList,
          addClick: () {},
          changeIndex: (int index) {
            if (index == 0) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      DashboardScreen(animationController: animationController);
                });
              });
            } else if (index == 1) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody = SystemTemplateScreen(
                      animationController: animationController);
                });
              });
            } else if (index == 2) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody = MyDocumentScreen(
                      animationController: animationController);
                });
              });
            } else if (index == 3) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody = const MyAccountScreen();
                });
              });
            }
          },
        ),
      ],
    );
  }
}
