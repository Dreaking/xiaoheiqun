import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xiaoheiqun/microMall/my/addAddress.dart';

class manageAddress extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return manageAddressState();
  }
}

class manageAddressState extends State<manageAddress> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = new ScreenUtil(width: 1080, height: 2340)
      ..init(context);
    // TODO: implement build
    return Scaffold(
      appBar: PreferredSize(
          child: AppBar(
            elevation: 0,
            title: Text(
              "管理地址",
              style: TextStyle(fontSize: 18),
            ),
          ),
          preferredSize: Size(ScreenUtil().setWidth(1080), 50)),
      body: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    left: BorderSide(
                        color: Color.fromRGBO(165, 210, 6, 1),
                        width: ScreenUtil().setWidth(15)))),
            child: Column(
              children: <Widget>[
                Container(
                  width: ScreenUtil().setWidth(1027),
                  height: ScreenUtil().setHeight(15),
                  child: Image.asset(
                    "image/top_line.png",
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: ScreenUtil().setWidth(47)),
                  child: Column(
                    children: <Widget>[
                      Padding(
                          padding:
                              EdgeInsets.only(top: ScreenUtil().setHeight(38))),
                      Row(
                        children: <Widget>[
                          Text("XXX先生"),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: ScreenUtil().setHeight(38))),
                          Text("1588490292")
                        ],
                      ),
                      Padding(
                          padding:
                              EdgeInsets.only(top: ScreenUtil().setHeight(20))),
                      Row(
                        children: <Widget>[
                          Text(
                            "山东省 济南市 天桥区 胜利庄路17号",
                            style: TextStyle(color: Colors.black45),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: ScreenUtil().setHeight(30))),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.only(top: ScreenUtil().setHeight(204))),
          GestureDetector(
            child: Container(
              padding:
                  EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(28)),
              margin: EdgeInsets.only(
                left: ScreenUtil().setWidth(104),
                right: ScreenUtil().setWidth(104),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color.fromRGBO(165, 210, 6, 1),
              ),
              alignment: Alignment.center,
              child: Text(
                "新增地址",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            onTap: () {
              Navigator.push(context,
                  CupertinoPageRoute(builder: (context) => addAddress()));
            },
          )
        ],
      ),
    );
  }
}
