import 'package:flutter/material.dart';
import 'package:xiaoheiqun/common/tinker.dart';

import 'my_draft.dart';

class EditIndex extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return EditIndexState();
  }
}

class EditIndexState extends State<EditIndex> {
  @override
  var xieyi = "image/sel_@2x_290.png";
  var select = 1;
  var xieyiColor = Colors.black12;
  Widget build(BuildContext context) {
    //监听系统返回操作
    return WillPopScope(
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              resizeToAvoidBottomPadding: false,
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: Text(
                  "动态编辑",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.normal),
                ),
                actions: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "存为草稿",
                      style: TextStyle(color: Colors.black),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 10),
                  ),
                ],
                elevation: 0,
                centerTitle: true,
                iconTheme: IconThemeData(size: 10),
                leading: InkWell(
                  child: Container(
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 20,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => TinkerScaffold()),
                      (route) => route == null,
                    );
                  },
                ),
              ),
              body: SingleChildScrollView(
                  child: Container(
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(245, 245, 245, 1),
                          borderRadius: BorderRadius.circular(10)),
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: InkWell(
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            "我的草稿",
                            style: TextStyle(
                                fontSize: 14,
                                color: Color.fromRGBO(155, 155, 155, 1)),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => draft()));
                        },
                      ),
                    ),
                    //输入标题
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Color.fromRGBO(242, 242, 242, 1)))),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "请输入标题",
                          disabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    //请输入标签

                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Color.fromRGBO(242, 242, 242, 1)))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("标签"),
                          Container(
                            width: 100,
                            child: TextField(
                              textAlign: TextAlign.right,
                              decoration: InputDecoration(
                                hintText: "请输入标签",
                                disabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //请输入内容
                    Container(
                      child: TextField(
                        maxLines: 8,
                        decoration: InputDecoration(
                          hintText: "请输入内容",
                          disabledBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),

                    //添加图片
                    Container(
                        child: SingleChildScrollView(
                      child: Tinker.Select_Image_picker(
                          Image_height: 100,
                          Image_width: 100,
                          count: 5,
                          line_count: 3,
                          spacing: 10,
                          runSpacing: 10,
                          Click_Image_file: Image.asset(
                            "image/tianjiatupian.png",
                            width: 100,
                            height: 100,
                          ),
                          callback: (path) {
                            //              print(da);
                          }),
                    )),
                    //协议
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            children: <Widget>[
                              InkWell(
                                child: Image.asset(
                                  "$xieyi",
                                  width: 20,
                                  height: 20,
                                ),
                                onTap: () {
                                  setState(() {
                                    if (select == 0) {
                                      xieyi = "image/sel_@2x_294.png";
                                      select = 1;
                                      xieyiColor = Colors.red;
                                    } else {
                                      xieyi = "image/sel_@2x_290.png";
                                      select = 0;
                                      xieyiColor = Colors.black12;
                                    }
                                  });
                                },
                              ),
                              Container(
                                child: Text(
                                  "本人承诺发布内容符合网络文明规范",
                                  style: TextStyle(color: xieyiColor),
                                ),
                                margin: EdgeInsets.symmetric(horizontal: 10),
                              ),
                            ],
                          ),
                        )),
                    //发布按钮
                    Container(
                      width: 100,
                      height: 40,
                      margin: EdgeInsets.fromLTRB(0, 120, 0, 0),
                      alignment: Alignment.center, //设置子控件的位置
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(207, 171, 113, 1),
                          borderRadius:
                              new BorderRadius.all(Radius.circular(40))),
                      child: Text(
                        "发布",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    )
                  ],
                ),
              )),
            )),
        //重写返回操作
        onWillPop: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => TinkerScaffold()),
            (route) => route == null,
          );
        });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
