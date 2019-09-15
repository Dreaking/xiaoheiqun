import 'package:flutter/material.dart';

class SearchBefore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GestureDetector(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
              child: AppBar(
                elevation: 0,
                leading: InkWell(
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                    size: 18,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                backgroundColor: Colors.white,
                title: Text(
                  "搜索",
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                      fontSize: 16),
                ),
              ),
              preferredSize: Size(size.width, 50)),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: size.width * 0.8,
                    height: 30,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(237, 237, 237, 1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(left: 10)),
                        Icon(Icons.search),
                        Container(
                          margin: EdgeInsets.only(top: 12),
                          width: size.width * 0.7,
                          height: 30,
                          child: TextField(
                            cursorColor: Colors.black45,
                            controller: TextEditingController(),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "搜索",
                              contentPadding: EdgeInsets.only(top: -8),
                              hintStyle: TextStyle(fontSize: 12),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 10)),
                  Text("搜索")
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                width: size.width,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12, width: 0.5)),
              ),

              Container(
                child: Text(
                  "历史记录",
                  style: TextStyle(fontSize: 16),
                ),
                margin: EdgeInsets.only(left: 10, top: 10),
              ), //历史记录
              Container(
                margin: EdgeInsets.only(left: 20, top: 5),
                child: Wrap(
                  spacing: 10,
                  children: <Widget>[
                    Container(
                      child: Text("豆浆机"),
                    ),
                    Container(
                      child: Text("豆浆机"),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
      ),
    );
  }
}
