import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xiaoheiqun/common/tinker.dart';

class Load extends Dialog {
  var text;
  Load({Key key, @required this.text}) : super(key: key);
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
            DataPicker(time: text), //构建具体的对话框布局内容
          ],
        ),
      ),
    );
  }
}

class DataPicker extends StatefulWidget {
  String time;
  DataPicker({Key key, @required this.time}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DataPckerState();
  }
}

class DataPckerState extends State<DataPicker> {
  FixedExtentScrollController scrollCtrl;
  FixedExtentScrollController MonthCtrl;
  FixedExtentScrollController DayCtrl;
  static List<String> YearList = [];
  static List<String> MonthList = [];
  static List<String> DayList = [];
  DateTime _dateTime = DateTime.now();
  void getDate() {
    for (var i = 1800; i <= _dateTime.year; i++) {
      setState(() {
        YearList.add(i.toString());
      });
    }
    for (var i = 1; i <= 12; i++) {
      if (i < 10)
        setState(() {
          MonthList.add("0" + i.toString());
        });
      else
        setState(() {
          MonthList.add(i.toString());
        });
    }
    for (var i = 1; i <= 31; i++) {
      if (i < 10)
        setState(() {
          DayList.add("0" + i.toString());
        });
      else
        setState(() {
          DayList.add(i.toString());
        });
    }
  }

  static int year, month, day;
  @override
  void initState() {
    year = int.parse(widget.time.split("-")[0]);
    month = int.parse(widget.time.split("-")[1]);
    day = int.parse(widget.time.split("-")[2]);
    scrollCtrl = new FixedExtentScrollController(initialItem: year - 1800);
    MonthCtrl = new FixedExtentScrollController(initialItem: month - 1);
    DayCtrl = new FixedExtentScrollController(initialItem: day - 1);
    // TODO: implement initState
    super.initState();
    getDate();
  }

  @override
  Widget build(BuildContext context) {
    FixedExtentScrollController leftScrollCtrl,
        middleScrollCtrl,
        rightScrollCtrl;
    String _time;

    leftScrollCtrl = new FixedExtentScrollController(initialItem: 1);
    // TODO: implement build
    final size = MediaQuery.of(context).size;
    final width = size.width;
    return new Center(
      //保证控件居中效果
      child: new SizedBox(
        width: width * 0.8,
        height: 160.0,
        child: new Container(
          decoration: ShapeDecoration(
            color: Color(0xffffffff),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(2.0),
              ),
            ),
          ),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 40,
                    height: 120,
                    child: CupertinoPicker.builder(
                      backgroundColor: null,
                      itemExtent: 40,
                      scrollController: scrollCtrl,
                      childCount: YearList.length,
                      itemBuilder: (context, index) => Center(
                        child: Container(
                          child: Text(
                            YearList[index].toString(),
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    width: 40,
                    height: 120,
                    child: CupertinoPicker.builder(
                      backgroundColor: null,
                      itemExtent: 40,
                      scrollController: MonthCtrl,
                      childCount: MonthList.length,
                      itemBuilder: (context, index) => Center(
                        child: Container(
                          child: Text(
                            MonthList[index].toString() + "月",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 120,
                    child: CupertinoPicker.builder(
                      backgroundColor: null,
                      itemExtent: 40,
                      scrollController: DayCtrl,
                      childCount: DayList.length,
                      itemBuilder: (context, index) => Center(
                        child: Container(
                          child: Text(
                            DayList[index].toString(),
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(color: Colors.black12),
                              right: BorderSide(color: Colors.black12))),
                      alignment: Alignment.center,
                      width: width * 0.8 / 2,
                      height: 40,
                      child: Text("取消"),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  InkWell(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          border:
                              Border(top: BorderSide(color: Colors.black12))),
                      width: width * 0.8 / 2,
                      alignment: Alignment.center,
                      child: Text("确认"),
                    ),
                    onTap: () {
//                      String msg = MonthList[scrollCtrl.initialItem];
//                      String msg1 = DayList[scrollCtrl.initialItem];
//                      String dat = "213";
                      setState(() {
                        _time = YearList[scrollCtrl.selectedItem] +
                            "-" +
                            MonthList[MonthCtrl.selectedItem] +
                            "-" +
                            DayList[DayCtrl.selectedItem];
                      });
//                      Tinker.toast(_time);
                      Navigator.pop(context, _time);
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
