import 'package:flutter/material.dart';
import 'package:xiaoheiqun/pages/message/sys_msg_detail.dart';

class systemMsg extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return systemState();
  }
}

class systemState extends State<systemMsg> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: <Widget>[
          InkWell(
            child: Row(
              children: <Widget>[
                Container(
                  width: 100,
                  child: Image.asset(
                    "image/logo@2x.png",
                    width: 40,
                    height: 40,
                  ),
                ),
                Container(
                  width: width - 100,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Color.fromRGBO(238, 238, 238, 1)))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "小黑裙上线",
                            style: TextStyle(fontSize: 16),
                          ),
                          Container(
                            child: Text(
                              "2019-03-04",
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Color.fromRGBO(155, 155, 155, 1)),
                            ),
                            margin: EdgeInsets.only(right: 10),
                          )
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        width: 160,
                        height: 30,
                        child: Text(
                          "小黑裙已正式上线，您已开通Vip,",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 11,
                              color: Color.fromRGBO(155, 155, 155, 1)),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => sys_msg_detail()));
            },
          )
        ],
      ),
    );
  }
}
