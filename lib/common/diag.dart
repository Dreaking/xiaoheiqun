import 'package:flutter/material.dart';

// 自定义弹层
class LoadingDialog extends Dialog {
  String text;

  LoadingDialog({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        return Future.value(false);
      },
      child: Material(
        type: MaterialType.transparency,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            GestureDetector(onTap: () {
              Navigator.pop(context, "$text");
            }),
            Sex(
              text: text,
            ), //构建具体的对话框布局内容
          ],
        ),
      ),
    );
  }
}

class Sex extends StatefulWidget {
  var text;

  Sex({Key key, @required this.text}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SexState();
  }
}

class SexState extends State<Sex> {
  @override
  Widget build(BuildContext context) {
    var sex_value = widget.text;
    final size = MediaQuery.of(context).size;
    final width = size.width;
    // TODO: implement build
    return new Center(
      //保证控件居中效果
      child: new SizedBox(
        width: width * 0.9,
        height: 120.0,
        child: new Container(
          decoration: ShapeDecoration(
            color: Color(0xffffffff),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
          ),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
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
                    Navigator.pop(context, "$sex_value");
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
                    Navigator.pop(context, "$sex_value");
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
