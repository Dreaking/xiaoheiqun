import 'package:flutter/material.dart';

// 自定义弹层
class LDialog extends Dialog {
  var text;

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
              Navigator.pop(context);
            }),
            Sex(), //构建具体的对话框布局内容
          ],
        ),
      ),
    );
  }
}

class Sex extends StatefulWidget {
  var text;
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
        width: width * 0.8,
        height: 140,
        child: new Container(
          width: width * 0.8,
          height: 100,
          decoration: ShapeDecoration(
            color: Color(0xffffffff),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
          ),
          child: Container(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "提醒",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  margin: EdgeInsets.only(
                    left: 20,
                  ),
                ),
                Container(
                  height: 60,
                  width: width * 0.7,
                  margin: EdgeInsets.only(top: 8),
                  child: Text("如有问题，请拨打客服电话18857378957"),
                ),
                GestureDetector(
                  child: Container(
                    margin: EdgeInsets.only(right: 15),
                    alignment: Alignment.centerRight,
                    child: Text(
                      "确定",
                      style: TextStyle(color: Colors.lightGreen, fontSize: 16),
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
