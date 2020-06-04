import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter3dflipmenu/screens/home.dart';
import 'package:flutter3dflipmenu/screens/menu.dart';
import 'package:flutter3dflipmenu/utils/config.dart';
import 'package:flutter3dflipmenu/utils/string.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeConfig().init(constraints, orientation);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: MyHomePage(),
        );
      });
    });
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with TickerProviderStateMixin {
  AnimationController _controller,_controller_1, _controller_2;
  Animation<double> _bodyAnimation,
      _menuAnimation,
      _iconAnimation,
      _bottomAnimationLeft,
      _bottomAnimationRight,
  _specsTextOpacityAnimation,
  _specsImageOpacityAnimation,
  _specsTextTranslateAnimation, _specsImageTranslateAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 400),
      vsync: this,
    );

    _controller_1 = AnimationController(
      duration: Duration(milliseconds: 550),
      vsync: this,
    );

    _controller_2 = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );

    _bodyAnimation = Tween<double>(begin: 0, end: pi / 2).animate(_controller);
    _menuAnimation = Tween<double>(begin: pi / 2, end: 0).animate(_controller);
    _iconAnimation = Tween<double>(
            begin: SizeConfig.widthMultiplier * 4,
            end: SizeConfig.widthMultiplier * 80)
        .animate(_controller);
    _bottomAnimationLeft =
        Tween<double>(begin: 0, end: pi / 2).animate(_controller);
    _bottomAnimationRight =
        Tween<double>(begin: 1, end: 0).animate(_controller);

    _specsTextOpacityAnimation = Tween<double>(begin: 0, end: 1).animate(_controller_1);
    _specsImageOpacityAnimation = Tween<double>(begin: 0, end: 1).animate(_controller_2);

    _specsTextTranslateAnimation = Tween<double>(begin: SizeConfig.heightMultiplier * 10, end: 0).animate(_controller_1);
    _specsImageTranslateAnimation = Tween<double>(begin: SizeConfig.heightMultiplier * 10, end: 0).animate(_controller_2);

    _controller.addStatusListener((status) {
      if (y == 0 && status == AnimationStatus.dismissed) {
        switchAnimation = false;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _controller_1.dispose();
    _controller_2.dispose();
  }

  bool switchAnimation = false;

  int i = 0;
  _openMenu() {
    switchAnimation = false;
    if (i == 0) {
      _controller.forward();
      i = 1;
    } else {
      _controller.reverse();
      i = 0;
    }
  }

  int y = 0;
  _openSpec() {
    switchAnimation = true;
    if (y == 0) {
      _controller.forward();
      _controller_1.forward();
      _controller_2.forward();
      y = 1;
    } else {
      _controller.reverse();
      _controller_1.reverse();
      _controller_2.reverse();
      y = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: Center(
          child: Stack(
            children: <Widget>[
              //Home
              AnimatedBuilder(
                animation: _bodyAnimation,
                child: HomeXD(),
                builder: (BuildContext context, Widget child) {
                  return switchAnimation
                      ? Transform(
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.004)
                            ..rotateX(-_bodyAnimation.value),
                          alignment: Alignment(0, -0.6),
                          child: child)
                      : Transform(
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.004)
                            ..rotateY(-_bodyAnimation.value),
                          alignment: Alignment(0.3, 0),
                          child: child);
                },
              ),

              //Specs
              Positioned(
                bottom: 0,
                child: AnimatedBuilder(
                  animation: _specsImageOpacityAnimation,
                  builder: (BuildContext context, Widget child) {
                    return switchAnimation
                        ? Transform(
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0)
                              ..rotateX(-_menuAnimation.value),
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.8,
                              color: Colors.grey[100],
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: SizeConfig.heightMultiplier * 23,
                                    left: SizeConfig.widthMultiplier * 9,
                                    right: SizeConfig.widthMultiplier * 9),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Transform.translate(
                                      offset: Offset(0, _specsTextTranslateAnimation.value),
                                      child: Opacity(
                                        opacity: _specsTextOpacityAnimation.value,
                                        child: Text(
                                          specs,
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                              height: 1.8),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: SizeConfig.heightMultiplier * 5,
                                    ),
                                    Transform.translate(
                                      offset: Offset(0, _specsImageTranslateAnimation.value),
                                      child: Opacity(
                                        opacity: _specsImageOpacityAnimation.value,
                                        child: Stack(
                                          children: <Widget>[
                                            ClipRRect(
                                                borderRadius: BorderRadius.circular(
                                                    SizeConfig.heightMultiplier),
                                                child: Image.asset(
                                                  'img/video.jpg',
                                                )),
                                            Positioned(
                                                top:
                                                    SizeConfig.heightMultiplier * 9,
                                                left:
                                                    SizeConfig.widthMultiplier * 37,
                                                child: Icon(
                                                  Icons.play_arrow,
                                                  color: Colors.white,
                                                  size:
                                                      SizeConfig.heightMultiplier *
                                                          3.4,
                                                ))
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Container();
                  },
                ),
              ),

              //Bottom description.
              Positioned(
                bottom: SizeConfig.heightMultiplier * 2,
                left: SizeConfig.widthMultiplier * 8,
                child: AnimatedBuilder(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Fender',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: SizeConfig.textMultiplier * 3.4,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey[800].withOpacity(0.6)),
                      ),
                      Text(
                        'American',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: SizeConfig.textMultiplier * 4.1,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey[900],
                            height: 1.3),
                      ),
                      Text(
                        'Elite Strat',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: SizeConfig.textMultiplier * 3,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey[900],
                            height: 1.3),
                      ),
                    ],
                  ),
                  animation: _bottomAnimationLeft,
                  builder: (BuildContext context, Widget child) {
                    return switchAnimation
                        ? Transform.translate(
                            offset: Offset(
                                0,
                                -_bottomAnimationLeft.value *
                                    SizeConfig.heightMultiplier *
                                    38),
                            child: child,
                          )
                        : Transform(
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.004)
                              ..rotateY(-_bottomAnimationLeft.value),
                            alignment: Alignment(0.3, 0),
                            child: child,
                          );
                  },
                ),
              ),

              //Bottom button.
              Positioned(
                bottom: SizeConfig.heightMultiplier * 2,
                right: SizeConfig.widthMultiplier * 8,
                child: AnimatedBuilder(
                  child: GestureDetector(
                    onTap: () {
                      if(i==0 && y==0){
                        _openSpec();
                      }
                    },
                    child: Padding(
                      padding:
                          EdgeInsets.only(bottom: SizeConfig.widthMultiplier),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'SPEC',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: SizeConfig.textMultiplier * 1.6,
                                fontWeight: FontWeight.w700,
                                color: Colors.grey[800]),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.grey[800],
                            size: SizeConfig.imageSizeMultiplier * 5,
                          )
                        ],
                      ),
                    ),
                  ),
                  animation: _bottomAnimationRight,
                  builder: (BuildContext context, Widget child) {
                    return Opacity(
                      opacity: _bottomAnimationRight.value,
                      child: child,
                    );
                  },
                ),
              ),

              //Menu
              AnimatedBuilder(
                animation: _menuAnimation,
                child: MenuXD(),
                builder: (BuildContext context, Widget child) {
                  return switchAnimation
                      ? Container()
                      : Transform(
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0)
                            ..rotateY(_menuAnimation.value),
                          alignment: Alignment.centerLeft,
                          child: child,
                        );
                },
              ),

              //App bar
              AnimatedBuilder(
                animation: _iconAnimation,
                child: Row(
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        switchAnimation ? _openSpec() : _openMenu();
                      },
                      icon: AnimatedIcon(
                        icon: AnimatedIcons.menu_close,
                        progress: _controller,
                        size: SizeConfig.heightMultiplier * 3,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: SizeConfig.widthMultiplier * 20,
                    ),
                    Text(
                      'PRODUCT DETAIL',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: SizeConfig.textMultiplier * 2,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.2,
                          color: Colors.grey[800]),
                    )
                  ],
                ),
                builder: (BuildContext context, Widget child) {
                  return switchAnimation
                      ? Positioned(
                          top: SizeConfig.heightMultiplier * 6,
                          left: SizeConfig.widthMultiplier * 4,
                          child: child)
                      : Positioned(
                          top: SizeConfig.heightMultiplier * 6,
                          left: _iconAnimation.value,
                          child: child);
                },
              ),
            ],
          ),
        ));
  }
}
