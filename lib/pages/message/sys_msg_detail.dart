import 'package:flutter/material.dart';
import 'package:xiaoheiqun/data/sys_msg.dart';

class sys_msg_detail extends StatefulWidget {
  sys_msg item;
  sys_msg_detail(this.item);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return sys_msg_detailState();
  }
}

class sys_msg_detailState extends State<sys_msg_detail> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.white,
            title: Text(
              "系统消息",
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
          body: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Text(
                    widget.item.title,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Text(
                    widget.item.createTime.split(" ")[0],
                    style: TextStyle(fontSize: 10),
                  ),
                ),
                Container(
                  child: Text(
                    widget.item.content,
                    style: TextStyle(fontSize: 16),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
