import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xiaoheiqun/common/events_bus.dart';
import 'package:xiaoheiqun/common/tinker.dart';
import 'package:xiaoheiqun/pages/edit/release_success.dart';
import 'my_draft.dart';
import 'package:xiaoheiqun/data/Draft.dart';

class EditIndex extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return EditIndexState();
  }
}

class EditIndexState extends State<EditIndex> {
  @override
  //监听Bus events
  List ImgList1 = [];
  var _control;
  Draft draft1;
  void _listen() {
    _control = eventBus.on<CaoClickInEvent>().listen((event) {
      setState(() {
        draft1 = event.draft;
      });
    });
    if (draft1 != null) {
      setState(() {
        title.text = draft1.title;
        content.text = draft1.content;
        biaoqian.text = draft1.biaoqian;
      });
      print("最终数组：");
      print(draft1.img);
      for (var i = 0; i < draft1.img.length; i++) {
        setState(() {
          ImgList1.add(draft1.img[i]);
        });
      }
    }
  }

  var xieyi = "image/sel_@2x_290.png";
  var select = 0;
  var xieyiColor = Colors.black12;
  TextEditingController title = new TextEditingController();
  TextEditingController content = new TextEditingController();
  TextEditingController biaoqian = new TextEditingController();
  var imgList, isCaogao, imgListUpload = [], imgListNet = [];
  Future submit(String isCaogao) async {
    String userId = await Tinker.getuserID();
    if (title.text.toString() == "") {
      Tinker.toast("标题不能为空");
    } else if (content.text == "") {
      Tinker.toast("内容不能为空");
    } else if (biaoqian.text == "") {
      Tinker.toast("标签不能为空");
    } else if (select == 0) {
      Tinker.toast("请同意相关协议");
    } else {
      print(imgList);
      for (var i = 0; i < imgList.length; i++) {
        if (imgList[i].runtimeType != String) {
          imgListUpload.add(imgList[i]);
        } else {
          imgListNet.add(imgList[i]);
        }
      }
      Tinker.uploadImageList(imgListUpload, (data) {
        print(imgListNet);
        for (var i = 0; i < imgListNet.length; i++) {
          data.add(imgListNet[i]);
        }
        FormData param = FormData.from({
          "merchantId": userId,
          "img": data,
          "title": title.text,
          "content": content.text,
          "biaoqian": biaoqian.text,
          "isCaogao": isCaogao
        });
        Tinker.post("/api/product/doSaveProduct", (data) {
          if (isCaogao == "false") {
            Navigator.push(context,
                CupertinoPageRoute(builder: (context) => release_success()));
          } else {
            Tinker.toast("保存草稿成功");
            Navigator.push(context,
                CupertinoPageRoute(builder: (context) => TinkerScaffold()));
          }
        }, params: param);
      });
    }
  }

  Widget build(BuildContext context) {
    _listen();
    final size = MediaQuery.of(context).size;
    final width = size.width;
    //监听系统返回操作
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        title: Text(
          "动态编辑",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
        ),
        actions: <Widget>[
          InkWell(
            child: Container(
              alignment: Alignment.center,
              child: Text(
                "存为草稿",
                style: TextStyle(color: Colors.black),
              ),
              margin: EdgeInsets.symmetric(horizontal: 10),
            ),
            onTap: () {
              submit("true");
            },
          ),
        ],
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
                        fontSize: 14, color: Color.fromRGBO(155, 155, 155, 1)),
                  ),
                ),
                onTap: () {
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (context) => draft()));
                },
              ),
            ),
            //输入标题
            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
              decoration: BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(color: Color.fromRGBO(242, 242, 242, 1)))),
              child: TextField(
                controller: title,
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
                      bottom:
                          BorderSide(color: Color.fromRGBO(242, 242, 242, 1)))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "标签",
                    style: TextStyle(fontSize: 18),
                  ),
                  Container(
                    width: 100,
                    child: TextField(
                      controller: biaoqian,
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
                controller: content,
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
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Tinker.Select_Image_picker(
                      Image_height: width / 5,
                      Image_width: width / 5,
                      count: 5,
                      line_count: 3,
                      spacing: 10,
                      runSpacing: 10,
                      ImgList: ImgList1,
                      Click_Image_file: Image.asset(
                        "image/tianjiatupian.png",
                        width: width / 5,
                        height: width / 5,
                      ),
                      callback: (path) {
                        imgList = path;
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
                          if (select == 0) {
                            setState(() {
                              xieyi = "image/sel_@2x_294.png";
                              select = 1;
                              xieyiColor = Colors.red;
                            });
                          } else {
                            setState(() {
                              xieyi = "image/sel_@2x_290.png";
                              select = 0;
                              xieyiColor = Colors.black12;
                            });
                          }
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
              child: GestureDetector(
                child: Container(
                  width: 100,
                  height: 40,
                  alignment: Alignment.center, //设置子控件的位置
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(207, 171, 113, 1),
                      borderRadius: new BorderRadius.all(Radius.circular(40))),
                  child: Text(
                    "发布",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                onTap: () {
                  submit("false");
                },
              ),
              margin: EdgeInsets.only(top: 120),
            )
          ],
        ),
      )),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _control.cancel();
  }
}
