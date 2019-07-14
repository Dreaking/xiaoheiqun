import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'authentation_item.dart';

class authentation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return authentationState();
  }
}

class authentationState extends State<authentation> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Material(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            title: Text(
              "认证用户",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
            ),
            leading: InkWell(
              child: Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            elevation: 0,
          ),
          body: StaggeredGridView.countBuilder(
            addAutomaticKeepAlives: true,
            primary: true,
            crossAxisCount: 1,
            mainAxisSpacing: 5.0,
            crossAxisSpacing: 10.0,
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            itemCount: 10,
            itemBuilder: (context, index) => authentationItem(),
            staggeredTileBuilder: (index) => StaggeredTile.fit(1),
          )),
    );
  }
}
