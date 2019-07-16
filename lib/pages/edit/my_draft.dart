import 'package:flutter/material.dart';

class draft extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return draftState();
  }
}

class draftState extends State<draft> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          leading: InkWell(
              child: Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.pop(context);
              }),
          title: Text(
            "草稿",
            style: TextStyle(
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
          ),
        ),
        body: Container(
          height: 260,
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: Color.fromRGBO(242, 242, 242, 1), width: 1))),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 20, top: 8),
                    width: 50,
                    height: 40,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          child: Image.asset(
                            "image/nologin@2x.png",
                            width: 30,
                            height: 30,
                          ),
                        ),
                        Positioned(
                          child: Container(
                            width: 20,
                            height: 20,
                            alignment: Alignment.center,
                            child: Image.asset(
                              "image/vipicon.png",
                              width: 20,
                              height: 20,
                              fit: BoxFit.fill,
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25)),
                          ),
                          left: 18,
                          top: 15,
                        )
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 40,
                    child: Text(
                      "用户名-192",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Row(
                  children: <Widget>[
                    //标签
                    Container(
                      alignment: Alignment.center,
                      height: 26,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color.fromRGBO(242, 242, 242, 1)),
                      width: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Image.asset(
                              "image/biaoqian.png",
                              height: 15,
                              width: 15,
                            ),
                            margin: EdgeInsets.only(right: 7),
                          ),
                          Text(
                            "无",
                            style: TextStyle(
                                color: Color.fromRGBO(16, 130, 255, 1)),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text(
                        "写到吐血",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 20, top: 10),
                    child: Image.asset(
                      "image/img5.png",
                      width: 150,
                      height: 150,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
