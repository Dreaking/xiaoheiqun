import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xiaoheiqun/common/app_config.dart';
import 'package:xiaoheiqun/common/tinker.dart';
import 'package:xiaoheiqun/common/app_launch.dart';
import 'package:xiaoheiqun/pages/edit/index.dart';
import 'package:oktoast/oktoast.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OKToast(
        child: MaterialApp(
      title: AppConfig.APP_NAME,
      debugShowCheckedModeBanner: false,
      theme: Tinker.getThemeData(),
      home: TinkerLaunch(),
    ));
  }
}
