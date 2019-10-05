import 'package:flutter/material.dart';

class about extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return aboutState();
  }
}

class aboutState extends State<about> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "关于小黄鱼",
            style:
                TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
          ),
          leading: InkWell(
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 20,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Image.asset(
                      "image/logo@2x.jpg",
                      width: 60,
                      height: 60,
                    ),
                    margin: EdgeInsets.only(top: 50),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 30),
                    child: Text(
                      "小黄鱼   V1.0.4",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                        "        小黄鱼是一款火爆的同城社交软件，快来和你附近的TA聊天、约会、交友吧。同时还可以发送私信、图片、语音以及动态等多种聊天方式，让交友更加多样化。"),
                  )
                ],
              ),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        "image/line_copy23@2x.png",
                        width: 140,
                      ),
                      Text(
                        "官方粉丝群",
                        style: TextStyle(fontSize: 17),
                      ),
                      Image.asset(
                        "image/line_copy23@2x.png",
                        width: 140,
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("官网"),
                        Text(
                          "www.fuful.com",
                          style: TextStyle(
                              color: Color.fromRGBO(162, 162, 174, 1)),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("客服邮箱"),
                        Text(
                          "843841789@qq.com",
                          style: TextStyle(
                              color: Color.fromRGBO(162, 162, 174, 1)),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("商务合作"),
                        Text(
                          "18857378957",
                          style: TextStyle(
                              color: Color.fromRGBO(162, 162, 174, 1)),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "山东福满网络科技有限公司  版权所有",
                          style: TextStyle(
                              fontSize: 11,
                              color: Color.fromRGBO(162, 162, 174, 1)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
