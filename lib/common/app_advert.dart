import 'dart:async';

import 'package:flutter/material.dart';
import 'package:xiaoheiqun/common/LeftPageView.dart';

import 'tinker.dart';
import 'app_config.dart';

class AppDvert extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AppDvertState();
  }
}

class AppDvertState extends State<AppDvert>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;
  Timer _timer, _second;
  int seconds = 5;
  void timer() {
    _second = Timer.periodic(Duration(seconds: 1), (timer) {
      if (seconds < 0) {
        timer.cancel(); // 取消重复计时
        return;
      }
      setState(() {
        seconds--; //
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    _animation = CurveTween(
      curve: Curves.fastOutSlowIn,
    ).animate(_animationController)
      ..addStatusListener(
        (status) => {
          if (AnimationStatus.completed == status)
            {
              _timer = Timer(
                Duration(milliseconds: 5000),
                () => {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LeftPageView()),
                    (route) => route == null,
                  ),
                },
              ),
            },
        },
      );
    timer();
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _timer.cancel();
    _second.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // TODO: implement build
    return ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: Stack(
        fit: StackFit.loose,
        overflow: Overflow.visible,
        children: <Widget>[
          Container(
            child: Image.asset(
              "image/app_advert.jpg",
              fit: BoxFit.fill,
            ),
            width: size.width,
            height: size.height,
          ),
          Positioned(
            child: SafeArea(
                child: GestureDetector(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 13, vertical: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white)),
                child: Text(
                  "$seconds秒跳过",
                  style: TextStyle(
                      fontSize: 11,
                      color: Colors.white,
                      decoration: TextDecoration.none),
                ),
                alignment: Alignment.center,
              ),
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                  PageRouteBuilder(
                    pageBuilder: (
                      ctx,
                      animation1,
                      animation2,
                    ) {
                      return LeftPageView();
                    },
                  ),
                  (route) => route == null,
                );
              },
            )),
            top: 10,
            right: 13,
          )
        ],
      ),
    );
  }
}
