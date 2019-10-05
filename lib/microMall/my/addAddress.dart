import 'package:city_pickers/city_pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class addAddress extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return addAddressState();
  }
}

class addAddressState extends State<addAddress> {
  var address = null;
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = new ScreenUtil(width: 1080, height: 2340)
      ..init(context);
    // TODO: implement build
    return GestureDetector(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            child: AppBar(
              elevation: 0,
              title: Text(
                "管理地址",
                style: TextStyle(fontSize: 18),
              ),
            ),
            preferredSize: Size(ScreenUtil().setWidth(1080), 50)),
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                child: TextField(
                  controller: TextEditingController(),
                  decoration:
                      InputDecoration(hintText: "姓名", border: InputBorder.none),
                ),
                width: ScreenUtil().setWidth(1080),
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.black54))),
              ),
              Container(
                child: TextField(
                  controller: TextEditingController(),
                  decoration: InputDecoration(
                      hintText: "联系电话", border: InputBorder.none),
                ),
                width: ScreenUtil().setWidth(1080),
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.black54))),
              ),
              GestureDetector(
                child: Container(
                  width: ScreenUtil().setWidth(1080),
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Colors.black54))),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    address == null ? "地址" : address,
                    style: TextStyle(color: Colors.black54, fontSize: 16),
                  ),
                ),
                onTap: () async {
                  Result result2 = await CityPickers.showCityPicker(
                      context: context,
                      theme: ThemeData(
                          fontFamily: "Arial",
                          primaryColor: Colors.black,
                          accentColor: Colors.blue,
                          textTheme:
                              TextTheme(caption: TextStyle(fontSize: 18))));
                  setState(() {
                    address = result2.areaName +
                        " " +
                        result2.cityName +
                        " " +
                        result2.provinceName;
                  });
                },
              ),
              Container(
                child: TextField(
                  controller: TextEditingController(),
                  decoration: InputDecoration(
                      hintText: "详细地址", border: InputBorder.none),
                ),
                width: ScreenUtil().setWidth(1080),
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.black54))),
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 10),
        ),
      ),
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
    );
  }
}
