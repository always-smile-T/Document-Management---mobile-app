import 'package:doma_app/doma_app/component/file.dart';
import 'package:doma_app/doma_app/component/folder.dart';
import 'package:doma_app/doma_app/model/document/personal_document.dart';
import 'package:doma_app/doma_app/resources/dash_board/ui_view/doma_app_theme.dart';
import 'package:doma_app/doma_app/rest_api/rest_api_get.dart';
import 'package:flutter/material.dart';
import '../glass_view.dart';


class MyDocumentScreen extends StatefulWidget {
  const MyDocumentScreen({Key? key, this.animationController})
      : super(key: key);

  final AnimationController? animationController;

  @override
  _MyDocumentScreenState createState() => _MyDocumentScreenState();
}

class _MyDocumentScreenState extends State<MyDocumentScreen>
    with TickerProviderStateMixin {
  String? idFolder = "";
  String? search = "";
  Animation<double>? topBarAnimation;
  static const int count = 9;

  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  double topBarOpacity = 0.0;

  @override
  void initState() {
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController!,
            curve: const Interval(0, 0.5, curve: Curves.fastOutSlowIn)));

    scrollController.addListener(() {
      if (scrollController.offset >= 24) {
        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
          });
        }
      } else if (scrollController.offset <= 24 &&
          scrollController.offset >= 0) {
        if (topBarOpacity != scrollController.offset / 24) {
          setState(() {
            topBarOpacity = scrollController.offset / 24;
          });
        }
      } else if (scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          setState(() {
            topBarOpacity = 0.0;
          });
        }
      }
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      color: DomaAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10),
              child: getAppBarUI(),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: getMainListViewUI(),
            ),
          ],
        ),
      ),
    );
  }

  Widget getMainListViewUI() {
    return FutureBuilder<Document>(
      future: showDocument(idFolder.toString(), search.toString()),
      builder: (context, snapshot) {
        //print('con meo ma treo cay cau');
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.deepPurpleAccent,
            ),
          );
        }
        if (snapshot.hasData) {
          if (snapshot.data!.files!.isEmpty &&
              snapshot.data!.folders!.isEmpty) {
            return PageView.builder(
                itemCount: 1,
                scrollDirection: Axis.vertical,

                itemBuilder: (ctx, index) {
                  widget.animationController?.forward();
                  return Center(
                      child: SizedBox(
                        height: 100,
                        width: 300,
                        child: GlassView(
                            animation: Tween<double>(begin: 0.0, end: 1.0).animate(
                                CurvedAnimation(
                                    parent: widget.animationController!,
                                    curve: const Interval((1 / count) * 8, 1.0,
                                        curve: Curves.fastOutSlowIn))),
                            animationController: widget.animationController!),
                      )
                  );
                });
          } else {
            int item = snapshot.data!.folders!.length + snapshot.data!.files!.length;
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                ),
                controller: scrollController,
                padding: EdgeInsets.only(
                  top: AppBar().preferredSize.height +
                      MediaQuery.of(context).padding.top +
                      140,
                  bottom: 62 + MediaQuery.of(context).padding.bottom,
                ),
                itemCount: item,
                scrollDirection: Axis.vertical,

                itemBuilder: (ctx, index) {
                  widget.animationController?.forward();
                  if(index < snapshot.data!.folders!.length){
                    Folders folders = snapshot.data!.folders![index];
                    //print('id:' + folders.id.toString());
                    return Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        Container(
                          height: 130,
                          width: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              width: 1.2,
                              color: Colors.deepPurpleAccent,
                            ),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                idFolder = folders.id.toString();
                              });
                            },
                            child: FolderWidget(folders.name, folders.size),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                overlayColor: MaterialStateProperty.all<Color>(Colors.white70),
                                foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white70),
                                elevation: MaterialStateProperty.resolveWith<double>(
                                      (Set<MaterialState> states) {
                                    if (states.contains(MaterialState.pressed) ||
                                        states.contains(MaterialState.disabled)) {
                                      return 0;
                                    }
                                    return 10;
                                  },
                                )
                            ),
                          ),
                        )
                      ],
                    );
                  }
                  else{
                    index = index - snapshot.data!.folders!.length;
                    Files files = snapshot.data!.files![index];
                    return Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        FileWidget(files.name, files.size),
                      ],
                    );
                  }
                });
          }
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

  Widget getAppBarUI() {
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: widget.animationController!,
          builder: (BuildContext context, Widget? child) {
            return FadeTransition(
              opacity: topBarAnimation!,
              child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 30 * (1.0 - topBarAnimation!.value), 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: DomaAppTheme.white.withOpacity(topBarOpacity),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32.0),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: DomaAppTheme.grey
                              .withOpacity(0.4 * topBarOpacity),
                          offset: const Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'My Document',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: DomaAppTheme.fontName,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 22 + 6 - 6 * topBarOpacity,
                                      letterSpacing: 1.2,
                                      color: DomaAppTheme.darkerText,
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          //////////////////////////
                          // cho nay de breadcrumbs
                          //////////////////////////
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text(
                              "My Documents",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black38,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0),
                        child: SizedBox(
                          width: 250,
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: <Widget>[
                              StreamBuilder(
                                  builder: (context, snapshot) => TextField(
                                    cursorColor: Colors.black,
                                    style: const TextStyle(fontSize: 15),
                                    textAlignVertical:
                                    TextAlignVertical.bottom,
                                    controller: _searchController,
                                    //cho nay true thi giau pass, con failse thi ...
                                    decoration: const InputDecoration(
                                      hintText: "Search Document",
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black38),
                                      ),
                                      labelStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15),
                                    ),
                                  )),
                              IconButton(
                                alignment: Alignment.bottomRight,
                                onPressed: () {
                                  setState(() {
                                    search = _searchController.text.toString();
                                  });
                                },
                                icon: const Icon(Icons.search),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }


}
