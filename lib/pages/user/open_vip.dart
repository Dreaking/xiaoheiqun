import 'package:flutter/material.dart';
import 'package:xiaoheiqun/pages/user/pay.dart';

class openVip extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return openVipState();
  }
}

class openVipState extends State<openVip> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    // TODO: implement build
    return SafeArea(
        child: Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "开通会员",
            style:
                TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
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
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: ConstrainedBox(
          constraints: BoxConstraints.expand(),
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: width * 0.74,
                              height: 180,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color.fromRGBO(255, 238, 154, 1)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    width: width * 0.7,
                                    height: 160,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                            image: new AssetImage(
                                                "image/vip_copy4@2x.png"),
                                            fit: BoxFit.fitHeight)),
                                    child: Container(
                                      margin:
                                          EdgeInsets.only(top: 30, left: 10),
                                      alignment: Alignment.topCenter,
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            child: ClipOval(
                                              child: Image.asset(
                                                "image/img5.png",
                                                width: 70,
                                                height: 70,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              "用户名-912",
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            margin: EdgeInsets.only(
                                                left: 10, top: 10),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        child: Container(
                          alignment: Alignment.center,
                          width: width * 0.8,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadiusDirectional.only(
                                  bottomStart: Radius.circular(20),
                                  bottomEnd: Radius.circular(20))),
                          child: Text(
                            "点击立即申请，马上成为VIP会员",
                            style: TextStyle(
                                color: Color.fromRGBO(245, 153, 16, 1)),
                          ),
                        ),
                        left: width * 0.1,
                        bottom: 0,
                      )
                    ],
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[
                        Text(
                          "会员特权",
                          style: TextStyle(fontSize: 18),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(right: 15),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(right: 10),
                                      child: Image.asset(
                                        "image/talk@2x.png",
                                        width: 30,
                                        height: 30,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          child: Text(
                                            "与VIP用户对话",
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    255, 197, 85, 1),
                                                fontSize: 12),
                                          ),
                                          margin: EdgeInsets.only(bottom: 5),
                                        ),
                                        Container(
                                          child: Text(
                                            "无限次对话",
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(right: 10),
                                      child: Image.asset(
                                        "image/talk@2x.png",
                                        width: 30,
                                        height: 30,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          child: Text(
                                            "发表个人动态",
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    255, 197, 85, 1),
                                                fontSize: 12),
                                          ),
                                          margin: EdgeInsets.only(bottom: 5),
                                        ),
                                        Container(
                                          child: Text(
                                            "无限次发表动态",
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    margin: EdgeInsets.only(top: 70),
                  )
                ],
              ),
              Positioned(
                child: GestureDetector(
                  child: Container(
                    width: width,
                    alignment: Alignment.center,
                    height: 45,
                    color: Colors.red,
                    child: Text(
                      "立即申请",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => pay()));
                  },
                ),
                bottom: 0,
              )
            ],
          ),
        ),
      ),
    ));
  }
}
