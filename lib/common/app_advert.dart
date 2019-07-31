import 'dart:async';

import 'package:flutter/material.dart';

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
  Timer _timer;
  int seconds = 5;
  void timer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      print('计时中...$seconds');

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
                    PageRouteBuilder(
                      pageBuilder: (
                        ctx,
                        animation1,
                        animation2,
                      ) {
                        return TinkerScaffold();
                      },
                    ),
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        Image.asset(
          "image/app_advert.jpg",
          fit: BoxFit.cover,
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
                    return TinkerScaffold();
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
    );
  }
}
