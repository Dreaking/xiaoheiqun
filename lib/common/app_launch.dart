import 'dart:async';

import 'package:flutter/material.dart';

import 'app_advert.dart';
import 'app_config.dart';

class TinkerLaunch extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TinkerLaunchState();
  }
}

class TinkerLaunchState extends State<TinkerLaunch>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;
  Timer _timer;

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
                Duration(milliseconds: 1000),
                () => {
                  Navigator.of(context).pushAndRemoveUntil(
                    PageRouteBuilder(
                      pageBuilder: (
                        ctx,
                        animation1,
                        animation2,
                      ) {
                        return AppDvert();
                      },
                    ),
                    (route) => route == null,
                  ),
                },
              ),
            },
        },
      );
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
    return Image.asset(
      AppConfig.APP_LAUNCH_IMAGE,
      fit: BoxFit.cover,
    );
  }
}
