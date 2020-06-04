import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter3dflipmenu/utils/config.dart';

class HomeXD extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeXDState();
  }
}

class _HomeXDState extends State<HomeXD> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: SizeConfig.heightMultiplier * 14,
          ),
          Stack(children: [
            Container(),
            Stack(
              children: <Widget>[
                Positioned(
                  top: -SizeConfig.heightMultiplier * 0.4,
                  right: SizeConfig.widthMultiplier * 20,
                  child: Image.asset(
                    'img/guitar.png',
                    color: Colors.grey[700].withOpacity(0.8),
                    width: SizeConfig.imageSizeMultiplier * 64,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: ClipRect(
                      child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                          child: Image.asset(
                            'img/guitar.png',
                            width: SizeConfig.imageSizeMultiplier * 64,
                          ))),
                ),
              ],
            ),
            Positioned(
              right: SizeConfig.widthMultiplier * 55,
              top: SizeConfig.heightMultiplier * 28,
              child: Transform.rotate(
                  angle: -pi / 2,
                  child: Image.asset(
                    'img/logo.png',
                    width: SizeConfig.widthMultiplier * 52,
                  )),
            ),
          ]),
        ],
      ),
    );
  }
}
