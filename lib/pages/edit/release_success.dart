import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xiaoheiqun/common/tinker.dart';

class release_success extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return release_successState();
  }
}

class release_successState extends State<release_success> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    // TODO: implement build
    return Material(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          title: Text(
            "动态发布成功",
            style:
                TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
          ),
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(size: 10),
          leading: GestureDetector(
            child: Container(
              child: Icon(
                Icons.arrow_back_ios,
                size: 20,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: ConstrainedBox(
          constraints: BoxConstraints.expand(),
          child: Stack(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      "image/finish@2x.png",
                      width: width * 0.4,
                      height: width * 0.4,
                      fit: BoxFit.fill,
                    ),
                    Container(
                      child: Text("发布成功"),
                    ),
                    Container(
                      child: Text("等待管理员审核"),
                    )
                  ],
                ),
              ),
              Positioned(
                child: SafeArea(
                    child: InkWell(
                  child: Container(
                    height: 40,
                    width: width,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                              color: Color.fromRGBO(234, 6, 59, 1),
                              alignment: Alignment.center,
                              child: Container(
                                child: Text(
                                  "完成",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                                margin: EdgeInsets.only(left: 10),
                              )),
                          flex: 1,
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      CupertinoPageRoute(
                          builder: (context) => TinkerScaffold()),
                      (route) => route == null,
                    );
                  },
                )),
                bottom: 0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
