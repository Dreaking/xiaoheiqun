import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xiaoheiqun/common/app_config.dart';
import 'package:xiaoheiqun/common/tinker.dart';
import 'package:xiaoheiqun/data/person_data.dart';

class o_person extends StatefulWidget {
  String id;
  o_person(this.id);
  @override
  State<StatefulWidget> createState() => new o_personState();
}

class o_personState extends State<o_person> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initView();
  }

  Person_data user;

  void initView() {
    Tinker.queryUserInfo(widget.id, (data) {
      setState(() {
        user = Person_data.fromJson(data);
      });
    });
  }

  final double F_size = 16.0;
  Widget build(BuildContext context) {
    return Material(
      child: user == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              backgroundColor: Colors.white,
              appBar: new AppBar(
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
                title: new Text(
                  '个人资料',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 18),
                ),
                elevation: 0,
                brightness: Brightness.light,
                backgroundColor: Colors.white,
                centerTitle: true,
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
              ),
              body: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 90,
                      width: 90,
                      margin: EdgeInsets.only(top: 28, bottom: 18),
                      child: ClipOval(
                        child: Image.network(
                          AppConfig.AJAX_IMG_SERVER + user.headImg,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        user.userName,
                        style: TextStyle(fontSize: 15, color: Colors.black26),
                      ),
                      margin: EdgeInsets.only(bottom: 15),
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.black12))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "用户名",
                                style: TextStyle(fontSize: F_size),
                              ),
                              Text(
                                user.userName,
                                style: TextStyle(
                                    fontSize: F_size, color: Colors.black45),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.black12))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "生日",
                                style: TextStyle(fontSize: F_size),
                              ),
                              Text(
                                user.birthday,
                                style: TextStyle(
                                    fontSize: F_size, color: Colors.black45),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.black12))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "性别",
                                style: TextStyle(fontSize: F_size),
                              ),
                              Text(
                                user.sex == "0" ? "男" : "女",
                                style: TextStyle(
                                    fontSize: F_size, color: Colors.black45),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.black12))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "年龄",
                                style: TextStyle(fontSize: F_size),
                              ),
                              Text(
                                user.age.toString(),
                                style: TextStyle(
                                    fontSize: F_size, color: Colors.black45),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.black12))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "QQ",
                                style: TextStyle(fontSize: F_size),
                              ),
                              Text(
                                user.qq,
                                style: TextStyle(
                                    fontSize: F_size, color: Colors.black45),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
