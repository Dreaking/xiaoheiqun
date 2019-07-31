import 'package:flutter/material.dart';

class balance extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _balanceState();
}

class _balanceState extends State<balance> {
  @override
  double i = 0.0;
  TextEditingController controller = TextEditingController();

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          '余额提现',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
        ),
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        centerTitle: true,
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
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: new Container(
        color: Colors.white,
        child: new Column(
          children: <Widget>[
            new Container(
              margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(
                    ""
                    "提现金额（收取1%服务费）",
                    style: TextStyle(fontSize: 18),
                  ),
                  new Container(
                    decoration: new BoxDecoration(
                      border: new Border(
                          bottom: BorderSide(
                              color: Theme.of(context).dividerColor)),
                    ),
                    child: new TextField(
                      controller: controller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        icon: Icon(Icons.attach_money),
                        border: InputBorder.none,
                        hintText: "0.00",
                      ),
                      onChanged: (String) {
                        setState(() {
                          var a = controller.text;
                          if (controller.text == "") {
                            i = 0;
                          } else
                            i = (double.parse(a) / 100);
                          print(controller.text);
                        });
                      },
                    ),
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text(
                        "服务费${i ?? 0}元",
                        style: TextStyle(fontSize: 16),
                      ),
                      new Text(
                        "全部提现",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  new Container(
                    child: new Text(
                      "温馨提示：",
                      style: TextStyle(color: Colors.deepOrange),
                    ),
                    margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                  ),
                  new Container(
                    child: new Text("       请确保再您的个人资料中支付宝账号填写正确，否则将无法正常提现",
                        style: TextStyle(
                          color: Colors.deepOrange,
                        )),
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                        child: new Text(
                          "申请提现",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
                        width: 140,
                        alignment: Alignment.center,
                        height: 40,
                        color: Colors.deepOrange,
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
