import 'package:flutter/material.dart';

class OrderIndex extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OrderIndexState();
  }
}

class OrderIndexState extends State<OrderIndex> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // TODO: implement build
    return Scaffold(
      appBar: PreferredSize(
          child: AppBar(
            title: Text("订单"),
          ),
          preferredSize: Size(size.width, 50)),
      body: Column(
        children: <Widget>[
          TabBar(tabs: <Widget>[
            Text("全部订单"),
            Text("待付款"),
            Text("待收货"),
            Text("待评价"),
            Text("售后")
          ]),
        ],
      ),
    );
  }
}
