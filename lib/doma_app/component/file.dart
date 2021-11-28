// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FileWidget extends StatelessWidget {

  late final String name;
  late final int size ;

  FileWidget(this.name, this.size, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      width: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          width: 1,
          color: Colors.deepPurpleAccent,
        ),
      ),
      child: ElevatedButton(onPressed: (){},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/opendocument.svg',
              alignment: Alignment.centerRight,
              height: 30,
              width: 30,
            ),
            Text(name,
              style: const TextStyle(color: Colors.black, overflow: TextOverflow.ellipsis),
              textAlign: TextAlign.center,),
            Text('Size: $size',
                style: const TextStyle(color: Colors.black38),
                textAlign: TextAlign.center),
          ],
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          overlayColor: MaterialStateProperty.all<Color>(Colors.white70),
        ),),

    );
  }
}
