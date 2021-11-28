//folder document
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class FolderWidget extends StatelessWidget {
  late final String name;
  late final int size ;
  final ScrollController scrollController = ScrollController();

  FolderWidget(this.name, this.size, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/images/openfolder.svg',
          alignment: Alignment.centerRight,
          height: 30,
          width: 30,
        ),
        Text(name,
            style: const TextStyle(color: Colors.black),
            textAlign: TextAlign.center, overflow: TextOverflow.ellipsis),
        Text('folders/files: $size',
            style: const TextStyle(color: Colors.black38),
            textAlign: TextAlign.center),
      ],
    );
  }
}