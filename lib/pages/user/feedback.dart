import 'package:flutter/material.dart';
import 'package:xiaoheiqun/common/tinker.dart';

class feedback extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return feedbackState();
  }
}

class feedbackState extends State<feedback> {
  @override
  var radio_sel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    radio_sel = "0";
  }

  Widget build(BuildContext context) {
    // TODO: implement build
    final size = MediaQuery.of(context).size;
    final width = size.width;
    return Material(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          title: Text(
            "反馈",
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
        body: ConstrainedBox(
          constraints: BoxConstraints.expand(),
          child: Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Flexible(
                          child: RadioListTile<String>(
                            value: '0',
                            activeColor: Colors.red,
                            title: Text('遇到问题'),
                            groupValue: radio_sel,
                            onChanged: (value) {
                              setState(() {
                                radio_sel = value;
                              });
                            },
                          ),
                        ),
                        Flexible(
                          child: RadioListTile<String>(
                            value: '1',
                            title: Text('新功能建议'),
                            activeColor: Colors.red,
                            groupValue: radio_sel,
                            onChanged: (value) {
                              setState(() {
                                radio_sel = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      width: double.infinity,
                      height: 310,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color.fromRGBO(245, 245, 245, 1)),
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: TextField(
                              maxLength: 500,
                              maxLines: 9,
                              decoration: InputDecoration(
                                disabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                hintText: "请输入您的反馈，帮助我们完善",
                              ),
                            ),
                            margin: EdgeInsets.symmetric(horizontal: 10),
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 15, top: 10),
                                child: Tinker.Select_Image_picker(
                                  Image_height: 70,
                                  Image_width: 70,
                                  count: 1,
                                  Click_Image_file: Image.asset(
                                    "image/upload@2x.png",
                                    height: 70,
                                    width: 70,
                                  ),
                                  spacing: 0,
                                  line_count: 1,
                                  runSpacing: 0,
                                  callback: (path) {},
                                ),
                              ),
                              Container(
                                child: Text("添加图片"),
                                margin: EdgeInsets.only(left: 10),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                  bottom: 0,
                  height: 50,
                  child: Container(
                    alignment: Alignment.center,
                    color: Color.fromRGBO(234, 6, 59, 1),
                    width: width,
                    child: Text(
                      "提交",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
