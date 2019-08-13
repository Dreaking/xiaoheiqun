import 'package:flutter/material.dart';

class download extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return downloadState();
  }
}

class downloadState extends State<download> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            elevation: 0,
            title: Text(
              "下载小黑裙",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            leading: InkWell(
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 20,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            )),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: 50),
                child: Image.asset(
                  "image/logo@2x.png",
                  width: 60,
                  height: 60,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: Text("扫描二维码即可下载APP"),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: Image.asset("image/download.png"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
