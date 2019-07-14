import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:xiaoheiqun/pages/main/user_detail.dart';

class DongtaiItem extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DongtaiItemState();
  }
}

class DongtaiItemState extends State<DongtaiItem> {
  var showImages = "image/shoucang1.png";

  int _imgIndex = 0;

  @override
  // TODO: implement wantKeepAlive
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(bottom: 5),
        child: new Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    verticalDirection: VerticalDirection.down,
                    textDirection: TextDirection.ltr,
                    children: <Widget>[
                      ClipOval(
                        child: Image.asset(
                          "image/banner1.png",
                          width: 30,
                          height: 30,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                      ),
                      Flexible(
                        child: Text(
                          "用户名-192",
                          style: TextStyle(fontSize: 16),
                          overflow: TextOverflow.clip,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  Text(
                    '新来的',
                    style: TextStyle(
//                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.left,
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  new Container(
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: new Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                            child: new Image.asset(
                              "image/img1.png",
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: new Container(
                            margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: new Image.asset(
                              "image/img1.png",
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: new Container(
                            margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                            child: new Image.asset(
                              "image/img1.png",
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    verticalDirection: VerticalDirection.down,
                    children: <Widget>[
                      Flex(
                        mainAxisSize: MainAxisSize.min,
                        direction: Axis.horizontal,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          ClipOval(
                            child: Image.asset(
                              "image/liulan@2x.png",
                              width: 20,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(padding: EdgeInsets.symmetric(horizontal: 2)),
                          Text(
                            "123",
                            style: TextStyle(
                              fontSize: 10,
                              color: Color.fromARGB(0xff, 0xcc, 0xcc, 0xcc),
                            ),
                            overflow: TextOverflow.fade,
                            textDirection: TextDirection.rtl,
                          ),
                          Padding(padding: EdgeInsets.symmetric(horizontal: 2)),
                          ClipOval(
                            child: Image.asset(
                              "image/shijian@2x.png",
                              width: 20,
                              height: 20,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(padding: EdgeInsets.symmetric(horizontal: 2)),
                          Text(
                            "2019-05-15 01:25:46",
                            style: TextStyle(
                              fontSize: 10,
                              color: Color.fromARGB(0xff, 0xcc, 0xcc, 0xcc),
                            ),
                            overflow: TextOverflow.fade,
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.symmetric(vertical: 2)),
                      Flex(
                        mainAxisSize: MainAxisSize.min,
                        direction: Axis.horizontal,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          InkWell(
                            child: Image.asset(
                              "$showImages",
                              width: 20,
                              height: 20,
                              fit: BoxFit.cover,
                            ),
                            onTap: () {
                              setState(() {
                                if (_imgIndex == 0) {
                                  showImages = "image/shoucang2.png";
                                  _imgIndex = 1;
                                } else {
                                  showImages = "image/shoucang1.png";
                                  _imgIndex = 0;
                                }
                              });
                            },
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10)),
                          Image.asset(
                            "image/liaotian.png",
                            width: 20,
                            height: 20,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
//          ClipRRect(
//            child: FadeInImage.memoryNetwork(
//              fit: BoxFit.cover,
//              placeholder: kTransparentImage,
//              image:
//              'https://picsum.photos/${random.nextInt(100) + 200}/${random.nextInt(300) + 300}/',
//            ),
//            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
//          ),
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.white,
//        borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => udetail()));
      },
    );
  }
}
