import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:xiaoheiqun/common/app_config.dart';
import 'package:xiaoheiqun/login.dart';
import 'package:xiaoheiqun/microMall/home/index.dart';
import 'package:xiaoheiqun/microMall/my/index.dart';
import 'package:xiaoheiqun/microMall/order/index.dart';
import 'package:xiaoheiqun/microMall/provide/currentIndex.dart';
import 'package:xiaoheiqun/microMall/shopCat/index.dart';

class MicroMall extends StatelessWidget {
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), title: Text('首页')),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.search), title: Text('订单')),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.shopping_cart), title: Text('购物车')),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.profile_circled), title: Text('会员中心')),
  ];

  final List<Widget> tabBodies = [
    HomeIndex(),
    OrderIndex(),
    ShopCatIndex(),
    MyIndex()
  ];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      child: Provide<CurrentIndexProvide>(builder: (context, child, val) {
        int currentIndex =
            Provide.value<CurrentIndexProvide>(context).currentIndex;
        return Scaffold(
          backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Color.fromRGBO(238, 121, 44, 1),
            currentIndex: currentIndex,
            items: bottomTabs,
            onTap: (index) {
              Provide.value<CurrentIndexProvide>(context).changeIndex(index);
            },
          ),
          body: tabBodies[currentIndex],
        );
      }),
    );
  }
}
