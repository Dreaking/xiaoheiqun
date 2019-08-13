import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:ui' as ui;
import 'package:xiaoheiqun/common/app_config.dart';
import 'package:xiaoheiqun/common/dataPicker.dart';
import 'package:xiaoheiqun/common/diag.dart';
import 'package:xiaoheiqun/common/events_bus.dart';
import 'package:xiaoheiqun/common/tinker.dart';
import 'package:xiaoheiqun/data/person_data.dart';
import 'package:xiaoheiqun/pages/user/index.dart';

class person extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _personState();
}

class _personState extends State<person> {
  @override
  //初始化
  String _time;
  var value;
  var headimg = null;
  var sex_value = "男";
  var username = "用户名-75";
  var qq = "";
  var alipay = "";
  var age = "28";
  TextStyle textStyle = TextStyle(fontFamily: "Arial", fontSize: 16);
  TextStyle textRight = TextStyle(
      fontSize: 15,
      color: Color.fromRGBO(158, 158, 158, 1),
      fontFamily: "Arial");
  String MIN_DATETIME = '1900-05-12';
  String MAX_DATETIME = '2019-11-25';
  String INIT_DATETIME = '2019-05-17';
  String _format = 'yyyy-MMMM-dd';
  DateTime _dateTime = DateTime.parse("1991-01-01");
  DateTimePickerLocale _locale = DateTimePickerLocale.zh_cn;
  bool _showTitle = true;
  FixedExtentScrollController _scrollController;
  List<String> Sex = ["男", "女"];

//ios风格底部弹层，性别选择器
  void showSexIos() {
    int a;
    if (sex_value == "男")
      a = 0;
    else
      a = 1;
    _scrollController = new FixedExtentScrollController(initialItem: a);
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return new Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Container(
              color: Colors.yellow,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      "取消",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  InkWell(
                    child: Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Text(
                        "确认",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        sex_value = Sex[_scrollController.selectedItem];
                      });
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
              height: 50,
            ),
            Container(
              width: double.infinity,
              height: 180,
              child: CupertinoPicker.builder(
                  backgroundColor: null,
                  itemExtent: 30,
                  scrollController: _scrollController,
                  childCount: 2,
                  itemBuilder: (context, index) => Center(
                        child: Container(
                          child: Text(
                            Sex[index],
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      )),
            )
          ]);
        });
  }

  //Ios风格底部弹层，时间选择器
  void _showDatePicker() {
    DatePicker.showDatePicker(
      context,
      pickerTheme: DateTimePickerTheme(
        showTitle: _showTitle,
        confirm: Text('确认', style: TextStyle(color: Colors.black)),
        cancel: Text('取消', style: TextStyle(color: Colors.black)),
      ),
      minDateTime: DateTime.parse(MIN_DATETIME),
      maxDateTime: DateTime.parse(MAX_DATETIME),
      initialDateTime: _dateTime,
      dateFormat: _format,
      locale: _locale,
      onCancel: () {
        debugPrint('onCancel');
      },
      onChange: (dateTime, List<int> index) {},
      onConfirm: (dateTime, List<int> index) {
        String month, day;
        if (dateTime.month < 10) {
          month = "0" + dateTime.month.toString();
        } else
          month = dateTime.month.toString();
        if (dateTime.day < 10) {
          day = "0" + dateTime.day.toString();
        } else
          day = dateTime.day.toString();

        setState(() {
          _time = dateTime.year.toString() + "-" + month + "-" + day;
          _dateTime = dateTime;
          age = (DateTime.now().year - dateTime.year).toString();
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    initView();
  }

  bool imgUpdate = false;
  void save() {
    var sex;
    if (sex_value == "女") {
      sex = 1;
    } else
      sex = 0;
    if (imgUpdate) {
      Tinker.uploadImage(headimg, (data) {
        print(data);
        print("图片");

        FormData param = FormData.from({
          "userId": userId,
          "birthday": _time,
          "sex": sex,
          "age": age,
          "qq": qq,
          "userName": username,
          "alipayNumber": alipay,
          "headImg": data
        });
        Tinker.post("/api/user/updateUserMessage", (data) {
          initView();
        }, params: param);
      });
    } else {
      FormData param = FormData.from({
        "userId": userId,
        "birthday": _time,
        "sex": sex,
        "age": age,
        "qq": qq,
        "userName": username,
        "alipayNumber": alipay,
        "headImg": headimg
      });
      Tinker.post("/api/user/updateUserMessage", (data) {
        print("保存1");
        initView();
      }, params: param);
    }
    eventBus.fire(new UserLoggedInEvent("10"));
  }

  var userId;
  Person_data user;
  Future initView() async {
    userId = await Tinker.getuserID();
    Tinker.queryUserInfo(userId, (data) {
      user = Person_data.fromJson(data);
      setState(() {
        imgUpdate = false;
        if (user.headImg != null) {
          headimg = user.headImg;
        }
        _time = user.birthday;
        username = user.userName;
        if (user.sex == "0") {
          sex_value = "男";
        } else {
          sex_value = "女";
        }
        age = user.age.toString();
        if (user.qq != null) qq = user.qq;
        if (user.alipayNumber != null) alipay = user.alipayNumber;
      });
    });
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime _picked = await showDatePicker(
      context: context,
      initialDate: _dateTime, // 不能传入null
      firstDate: new DateTime(2017),
      lastDate: new DateTime(2021),
    );

    if (_picked != null) {
      print(_picked);
      setState(() {
        String a = _picked.toString();
        var array1 = a.split(" ");
        _time = array1[0];
        print(a);
      });
    }
  }

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;

    //用户名形式的弹层
    void showUserName(BuildContext context, var title, var msg, int i) {
      var log;
      if (i == 0) {
        log = "请输入用户名";
      } else if (log == 1) {
        log = "请输入支付宝账号";
      } else {
        log = "请输入QQ号";
      }
      var _control = TextEditingController.fromValue(TextEditingValue(
        // 设置内容
        text: msg == null ? "" : msg,

        // 保持光标在最后
      ));
      showCupertinoDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text(title),
              content: Card(
                elevation: 0.0,
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: _control,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: log,
                        border: InputBorder.none,
                      ),
                    ),
                    Text(
                      "可编辑",
                      style: TextStyle(fontSize: 10, color: Colors.red),
                    )
                  ],
                ),
              ),
              actions: <Widget>[
                CupertinoDialogAction(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('取消'),
                ),
                CupertinoDialogAction(
                  onPressed: () {
                    setState(() {
                      if (i == 0)
                        username = _control.text;
                      else if (i == 1)
                        alipay = _control.text;
                      else
                        qq = _control.text;
                    });
                    Navigator.pop(context);
                  },
                  child: Text('确定'),
                ),
              ],
            );
          });
    }

    /*拍照*/
    Future _takePhoto() async {
      var image = await ImagePicker.pickImage(source: ImageSource.camera);
      if (image != null) {
        setState(() {
          headimg = image.path;
          imgUpdate = true;
        });
      }
    }

    /*相册*/
    Future _openGallery() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          imgUpdate = true;
          headimg = image.path;
        });
      }
    }

    //Android风格的弹层，性别选择器
    void showSexAndroid(BuildContext context) {
      showDialog(
          context: context,
          builder: (context) {
            return new SimpleDialog(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Color.fromRGBO(230, 230, 230, 1)))),
                  width: width * 0.9,
                  height: 50,
                  alignment: Alignment.topCenter,
                  child: new SimpleDialogOption(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "男",
                          style: TextStyle(fontSize: 18),
                        ),
                        Radio(
                          value: "男",
                          groupValue: sex_value,
                          onChanged: (value) {},
                          activeColor: Colors.red,
                        )
                      ],
                    ),
                    onPressed: () {
                      setState(() {
                        sex_value = "男";
                      });
                      Navigator.of(context).pop("SimpleDialogOption One");
                    },
                  ),
                ),
                Container(
                  width: width * 0.9,
                  height: 50,
                  alignment: Alignment.bottomCenter,
                  child: new SimpleDialogOption(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "女",
                          style: TextStyle(fontSize: 18),
                        ),
                        Radio(
                          value: "女",
                          groupValue: sex_value,
                          onChanged: (value) {},
                          activeColor: Colors.red,
                        )
                      ],
                    ),
                    onPressed: () {
                      setState(() {
                        sex_value = "女";
                      });
                      Navigator.of(context).pop("SimpleDialogOption One");
                    },
                  ),
                ),
              ],
            );
          });
    }

    var mediaQueryData = MediaQueryData.fromWindow(ui.window);

    return MaterialApp(
      theme: Tinker.getThemeData(),
      debugShowCheckedModeBanner: false,
      home: user == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              resizeToAvoidBottomPadding: false,
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
                actions: <Widget>[
                  InkWell(
                    child: Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Text(
                        "保存",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      alignment: Alignment.center,
                    ),
                    onTap: () {
                      save();
                    },
                  )
                ],
                elevation: 0,
                brightness: Brightness.light,
                backgroundColor: Colors.white,
                centerTitle: true,
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
              ),
              body: new Container(
                color: Colors.white,
                child: new Column(
                  children: <Widget>[
                    new Align(
                      alignment: Alignment.center,
                      child: new Column(
                        children: <Widget>[
                          InkWell(
                            child: new Container(
                              child: headimg == null
                                  ? Image.asset(
                                      "image/nologin@2x.png",
                                      width: 80,
                                      height: 80,
                                    )
                                  : Container(
                                      height: 80,
                                      width: 80,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(80),
                                          border: Border.all(
                                              color: Colors.black12)),
                                      child: ClipOval(
                                          child: new SizedBox(
                                        width: 80,
                                        height: 80,
                                        child: imgUpdate
                                            ? Image.file(
                                                File(headimg),
                                                fit: BoxFit.cover,
                                              )
                                            : Image.network(
                                                AppConfig.AJAX_IMG_SERVER +
                                                    "$headimg",
                                                fit: BoxFit.cover,
                                              ),
                                      )),
                                    ),
                              margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                            ),
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SafeArea(
                                        child: new Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        new ListTile(
                                          leading: AppConfig.Image_picker_icon1,
                                          title: new Text(
                                              AppConfig.Image_picker_name1),
                                          onTap: () async {
                                            _takePhoto();
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        new ListTile(
                                          leading: AppConfig.Image_picker_icon2,
                                          title: new Text(
                                              AppConfig.Image_picker_name2),
                                          onTap: () async {
                                            _openGallery();
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    ));
                                  });
                            },
                          ),
                          new Text("修改头像")
                        ],
                      ),
                    ),
                    new Container(
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: new Column(
                        children: <Widget>[
                          InkWell(
                            child: new Container(
                              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                              decoration: new BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color:
                                              Theme.of(context).dividerColor))),
                              child: new Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  new Text(
                                    "用户名",
                                    style: textStyle,
                                  ),
                                  new Container(
                                    child: new Row(
                                      children: <Widget>[
                                        Container(
                                          child: new Align(
                                            child: new ConstrainedBox(
                                              constraints: BoxConstraints(
                                                  maxHeight: 50, maxWidth: 90),
                                              child: new TextField(
                                                enabled: false,
                                                style: textRight,
                                                textDirection:
                                                    TextDirection.rtl,
                                                controller:
                                                    TextEditingController
                                                        .fromValue(
                                                            TextEditingValue(
                                                  // 设置内容
                                                  text: "$username",

                                                  // 保持光标在最后
                                                )),
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                            ),
                                            alignment: Alignment.topCenter,
                                          ),
                                          margin: EdgeInsets.only(right: 10),
                                        ),
                                        new Image.asset(
                                          "image/shape_copy2@2x.png",
                                          height: 15,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              showUserName(context, "用户名", username, 0);
                            },
                          ),
                          new Container(
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            decoration: new BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color:
                                            Theme.of(context).dividerColor))),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new Text(
                                  "生日",
                                  style: textStyle,
                                ),
                                new Container(
                                  child: new Row(
                                    children: <Widget>[
                                      Container(
                                        child: new Align(
                                          child: new InkWell(
                                            child: new Text(
                                              "${_time ?? "1991-01-01"}",
                                              style: textRight,
                                            ),
                                            onTap: () async {
                                              if (Platform.isIOS)
                                                _showDatePicker();
                                              else {
                                                var result = await showDialog(
                                                    context:
                                                        context, //BuildContext对象
                                                    barrierDismissible: false,
                                                    builder:
                                                        (BuildContext context) {
                                                      return new Load(
                                                        text: _time ??
                                                            "1991-01-01",
                                                        //调用对话框
                                                      );
                                                    });
                                                setState(() {
                                                  _time = result;
                                                  age = (DateTime.now().year -
                                                          int.parse(result
                                                              .toString()
                                                              .split("-")[0]))
                                                      .toString();
                                                });
                                              }
                                            },
                                          ),
                                          alignment: Alignment.topCenter,
                                        ),
                                        margin: EdgeInsets.only(right: 10),
                                      ),
                                      new Image.asset(
                                        "image/shape_copy2@2x.png",
                                        height: 15,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            child: new Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              decoration: new BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color:
                                              Theme.of(context).dividerColor))),
                              child: new Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  new Text(
                                    "性别",
                                    style: textStyle,
                                  ),
                                  new Container(
                                    child: new Row(
                                      children: <Widget>[
                                        Container(
                                          child: new Align(
                                            child: new ConstrainedBox(
                                              constraints: BoxConstraints(
                                                  maxHeight: 50, maxWidth: 90),
                                              child: new TextField(
                                                enabled: false,
                                                style: textRight,
                                                textDirection:
                                                    TextDirection.rtl,
                                                controller:
                                                    TextEditingController
                                                        .fromValue(
                                                            TextEditingValue(
                                                  // 设置内容
                                                  text: "$sex_value",

                                                  // 保持光标在最后
                                                )),
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                            ),
                                            alignment: Alignment.topCenter,
                                          ),
                                          margin: EdgeInsets.only(right: 10),
                                        ),
                                        new Image.asset(
                                          "image/shape_copy2@2x.png",
                                          height: 15,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () async {
                              if (Platform.isIOS) {
                                //ios相关代码
                                showSexIos();
                              } else if (Platform.isAndroid) {
                                //android相关代码
                                var result = await showDialog(
                                    context: context, //BuildContext对象
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return new LoadingDialog(
                                        //调用对话框
                                        text: sex_value,
                                      );
                                    });
                                print("result=$result");
                                setState(() {
                                  sex_value = result;
                                });
                              }
                            },
                          ),
                          new Container(
                            height: 50,
                            decoration: new BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color:
                                            Theme.of(context).dividerColor))),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new Text(
                                  "年龄",
                                  style: textStyle,
                                ),
                                new Container(
                                  child: new Row(
                                    children: <Widget>[
                                      Container(
                                        child: new Text(
                                          "$age",
                                          style: textRight,
                                        ),
                                        margin: EdgeInsets.only(right: 10),
                                      ),
                                      new Image.asset(
                                        "image/shape_copy2@2x.png",
                                        height: 15,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            child: new Container(
                              decoration: new BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color:
                                              Theme.of(context).dividerColor))),
                              child: new Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  new Text(
                                    "支付宝",
                                    style: textStyle,
                                  ),
                                  new Container(
                                    child: new Row(
                                      children: <Widget>[
                                        Container(
                                          child: new Align(
                                            child: new ConstrainedBox(
                                              constraints: BoxConstraints(
                                                  maxHeight: 50, maxWidth: 140),
                                              child: new TextField(
                                                textAlign: TextAlign.right,
                                                enabled: false,
                                                style: textRight,
                                                textDirection:
                                                    TextDirection.rtl,
                                                controller:
                                                    TextEditingController
                                                        .fromValue(
                                                            TextEditingValue(
                                                  // 设置内容
                                                  text: "$alipay",
                                                  // 保持光标在最后
                                                )),
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: "请输入支付宝账号",
                                                    hintStyle: textRight),
                                              ),
                                            ),
                                            alignment: Alignment.topCenter,
                                          ),
                                          margin: EdgeInsets.only(right: 10),
                                        ),
                                        new Image.asset(
                                          "image/shape_copy2@2x.png",
                                          height: 15,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              showUserName(context, "支付宝", null, 1);
                            },
                          ),
                          InkWell(
                            child: new Container(
                              decoration: new BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color:
                                              Theme.of(context).dividerColor))),
                              child: new Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  new Text(
                                    "QQ",
                                    style: textStyle,
                                  ),
                                  new Container(
                                    child: new Row(
                                      children: <Widget>[
                                        Container(
                                          child: new Align(
                                            child: new ConstrainedBox(
                                              constraints: BoxConstraints(
                                                  maxHeight: 50, maxWidth: 90),
                                              child: new TextField(
                                                enabled: false,
                                                style: textRight,
                                                textDirection:
                                                    TextDirection.rtl,
                                                controller:
                                                    TextEditingController
                                                        .fromValue(
                                                            TextEditingValue(
                                                  // 设置内容
                                                  text: "$qq",

                                                  // 保持光标在最后
                                                )),
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: "请输入QQ号",
                                                    hintStyle: textRight),
                                              ),
                                            ),
                                            alignment: Alignment.topCenter,
                                          ),
                                          margin: EdgeInsets.only(right: 10),
                                        ),
                                        new Image.asset(
                                          "image/shape_copy2@2x.png",
                                          height: 15,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              showUserName(context, "QQ", null, 2);
                            },
                          ),
                          new Container(
                            decoration: new BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color:
                                            Theme.of(context).dividerColor))),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new Text(
                                  "手机号",
                                  style: textStyle,
                                ),
                                new Container(
                                  height: 50,
                                  child: new Row(
                                    children: <Widget>[
                                      Container(
                                        child: new Text(
                                          user.phone,
                                          style: textRight,
                                        ),
                                        margin: EdgeInsets.only(right: 10),
                                      ),
                                      new Image.asset(
                                        "image/shape_copy2@2x.png",
                                        height: 15,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          new Container(),
//                  new Container(
//                    child: new MaterialButton(
//                      color: Colors.blue,
//                      child: new Text('点我'),
//                      onPressed: () {
//
//                      },
//                    ),
//                  ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
