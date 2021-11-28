// cho avata ne
// khung thanh account
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../app_theme.dart';


class HomeDrawer extends StatefulWidget {
  const HomeDrawer(
      {Key? key,
        this.screenIndex,
        this.iconAnimationController,
        this.callBackIndex})
      : super(key: key);

  final AnimationController? iconAnimationController;
  final DrawerIndex? screenIndex;
  final Function(DrawerIndex)? callBackIndex;

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  List<DrawerList>? drawerList;

  @override
  void initState() {
    setDrawerListArray();
    super.initState();
  }

  void setDrawerListArray() {
    drawerList = <DrawerList>[
      DrawerList(
        index: DrawerIndex.info,
        labelName: 'Personal Info',
        icon: const Icon(Icons.info),
      ),
      DrawerList(
        index: DrawerIndex.changePass,
        labelName: 'Change Password',
        isAssetsImage: true,
        icon: const Icon(Icons.password),
      ),
      /*DrawerList(
        index: DrawerIndex.notification,
        labelName: 'Notifications',
        icon: const Icon(Icons.doorbell),
      ),
      DrawerList(
        index: DrawerIndex.status,
        labelName: 'Working Status',
        icon: const Icon(Icons.book),
      ),
      DrawerList(
        index: DrawerIndex.preference,
        labelName: 'Preferences',
        icon: const Icon(Icons.face),
      ),
      DrawerList(
        index: DrawerIndex.AIM,
        labelName: 'AIM',
        icon: const Icon(Icons.backpack),
      ),*/
      DrawerList(
        index: DrawerIndex.logout,
        labelName: 'Logout',
        icon: const Icon(Icons.power),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.notWhite.withOpacity(0.5),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 40.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  /* Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 40),//EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                child: IconButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DoMaAppHomeScreen(),));
                  }
                , icon: Icon(Icons.close)),
              ),*/
                  AnimatedBuilder(
                    animation: widget.iconAnimationController!,
                    builder: (BuildContext context, Widget? child) {
                      return ScaleTransition(
                        scale: AlwaysStoppedAnimation<double>(1.0 -
                            (widget.iconAnimationController!.value) * 0.2),
                        child: RotationTransition(
                          turns: AlwaysStoppedAnimation<double>(Tween<double>(
                              begin: 0.0, end: 24.0)
                              .animate(CurvedAnimation(
                              parent: widget.iconAnimationController!,
                              curve: Curves.fastOutSlowIn))
                              .value /
                              360),
                          child: Container(
                            margin: EdgeInsets.only(right: 40, left: 40),
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: AppTheme.grey.withOpacity(0.6),
                                    offset: const Offset(2.0, 4.0),
                                    blurRadius: 8),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius:
                              const BorderRadius.all(Radius.circular(80.0)),
                              child: SvgPicture.asset(
                                  'assets/images/avatar.svg'),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 8, left: 12),
                    child: Text(
                      'This is your account',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.grey,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Divider(
            height: 1,
            color: AppTheme.grey.withOpacity(0.6),
          ),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(0.0),
              itemCount: drawerList?.length,
              itemBuilder: (BuildContext context, int index) {
                return inkwell(drawerList![index]);
              },
            ),
          ),
          Divider(
            height: 1,
            color: AppTheme.grey.withOpacity(0.6),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ListTile(
                // sau nay lam du cho nay la logout
                /*title: const Text(
                  'Logout',
                  style: TextStyle(
                    fontFamily: AppTheme.fontName,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: AppTheme.darkText,
                  ),
                  textAlign: TextAlign.left,
                ),
                //onTap: logout,*/
              ),
              SizedBox(
                //height: MediaQuery.of(context).padding.bottom,
                height: 60, //MediaQuery.of(context).padding.bottom,
              )
            ],
          ),
        ],
      ),
    );
  }


  Widget inkwell(DrawerList listData) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.grey.withOpacity(0.1),
        highlightColor: Colors.transparent,
        onTap: () {
          navigationtoScreen(listData.index!);
        },
        child: Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Row(
                children: <Widget>[
                  const SizedBox(
                    width: 6.0,
                    height: 46.0,
                    // decoration: BoxDecoration(
                    //   color: widget.screenIndex == listData.index
                    //       ? Colors.blue
                    //       : Colors.transparent,
                    //   borderRadius: new BorderRadius.only(
                    //     topLeft: Radius.circular(0),
                    //     topRight: Radius.circular(16),
                    //     bottomLeft: Radius.circular(0),
                    //     bottomRight: Radius.circular(16),
                    //   ),
                    // ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  Text(
                    listData.labelName,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: widget.screenIndex == listData.index
                          ? Colors.deepPurpleAccent
                          : AppTheme.nearlyBlack,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            widget.screenIndex == listData.index
                ? AnimatedBuilder(

              animation: widget.iconAnimationController!,
              builder: (BuildContext context, Widget? child) {
                return Transform(
                  transform: Matrix4.translationValues(
                      (MediaQuery
                          .of(context)
                          .size
                          .width * 0.75 - 64) *
                          (1.0 -
                              widget.iconAnimationController!.value -
                              1.0),
                      0.0,
                      0.0),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Container(
                      width:
                      MediaQuery
                          .of(context)
                          .size
                          .width * 0.75 - 64,
                      height: 46,
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.2),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(28),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(28),
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
                : const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  Future<void> navigationtoScreen(DrawerIndex indexScreen) async {
    widget.callBackIndex!(indexScreen);
  }
}

enum DrawerIndex {
  info,
  changePass,
  //notification,
  //status,
  //preference,
  //AIM,
  logout
}

class DrawerList {
  DrawerList({
    this.isAssetsImage = false,
    this.labelName = '',
    this.icon,
    this.index,
    this.imageName = '',
  });

  String labelName;
  Icon? icon;
  bool isAssetsImage;
  String imageName;
  DrawerIndex? index;
}

