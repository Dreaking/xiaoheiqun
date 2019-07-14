import 'package:flutter/material.dart';

class guanzhuPerson extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return guanzhuState();
  }
}

class guanzhuState extends State<guanzhuPerson> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(top: 10),
      height: 85,
      //单个item
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          //头像
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(
              left: 30,
            ),
            child: Image.asset(
              "image/nologin@2x.png",
              height: 40,
              width: 40,
            ),
          ),
          //右侧信息
          Container(
            margin: EdgeInsets.only(right: 20),
            width: width * 0.7,
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        width: 1, color: Color.fromRGBO(242, 242, 242, 1)))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                //中间信息
                Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "用户-0142",
                              style: TextStyle(fontSize: 17),
                            ),
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Image.asset(
                                    "image/vip@2x.png",
                                    width: 20,
                                    height: 10,
                                  ),
                                  Image.asset(
                                    "image/renzheng.png",
                                    width: 20,
                                    height: 10,
                                  ),
                                  Text(
                                    "已认证",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                new Container(
                                  child: new Row(
                                    children: <Widget>[
                                      new Container(
                                        child: Image.asset(
                                          "image/age@2x.png",
                                          height: 10,
                                        ),
                                        margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                      ),
                                      new Text("20"),
                                    ],
                                  ),
                                  margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
                                ),
                                new Container(
                                  child: new Row(
                                    children: <Widget>[
                                      new Container(
                                        child: Image.asset(
                                          "image/male@2x.png",
                                          height: 10,
                                        ),
                                        margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                      ),
                                      new Text("男"),
                                    ],
                                  ),
                                  margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
