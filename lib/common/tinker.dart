import 'dart:io';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:dio/dio.dart';
import 'package:oktoast/oktoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:xiaoheiqun/pages/edit/index.dart';
import '../pages/main/index.dart';
import '../pages/message//index.dart';
import '../pages/user//index.dart';
import 'EnterExitRoute.dart';
import 'app_config.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xiaoheiqun/login.dart';
import 'package:xiaoheiqun/pages/shoucang/index.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';

class Tinker {
  /// 递归方式 计算文件的大小
  Future<double> _getTotalSizeOfFilesInDir(final FileSystemEntity file) async {
    try {
      if (file is File) {
        int length = await file.length();
        return double.parse(length.toString());
      }
      if (file is Directory) {
        final List<FileSystemEntity> children = file.listSync();
        double total = 0;
        if (children != null)
          for (final FileSystemEntity child in children)
            total += await _getTotalSizeOfFilesInDir(child);
        return total;
      }
      return 0;
    } catch (e) {
      print(e);
      return 0;
    }
  }

  //清除缓存
  static clearCache() async {
    //此处展示加载loading
    try {
      Directory tempDir = await getTemporaryDirectory();
      //删除缓存目录
      await delDir(tempDir);
      Tinker.toast('清除缓存成功');
    } catch (e) {
      print(e);
      Tinker.toast('清除缓存失败');
    } finally {
      //此处隐藏加载loading
    }
  }

  ///递归方式删除目录
  static Future<Null> delDir(FileSystemEntity file) async {
    try {
      if (file is Directory) {
        final List<FileSystemEntity> children = file.listSync();
        for (final FileSystemEntity child in children) {
          await delDir(child);
        }
      }
      await file.delete();
    } catch (e) {
      print(e);
    }
  }

  //获取用户Id
  static Future<String> getuserID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString("user1");
    return userId;
  }

  ///AjAx请求
  //get方法
  static void get(String url, Function callback,
      {params, Function errorCallback}) async {
    if (params != null && params.isNotEmpty) {
      StringBuffer sb = new StringBuffer("?");
      params.forEach((key, value) {
        sb.write("$key" + "=" + "$value" + "&");
      });
      String paramStr = sb.toString();
      paramStr = paramStr.substring(0, paramStr.length - 1);
      url += paramStr;
    }
    try {
      http.Response res = await http.get(AppConfig.AJAX_SERVER_API + url);

      if (callback != null) {
        var data = json.decode(res.body);
        if (data["statusCode"] == 200) {
          callback(data);
        } else {
          Tinker.toast(data["message"]);
        }
      }
    } catch (exception) {
      if (errorCallback != null) {
        errorCallback(exception);
      }
    }
  }

  //post方法
  static void post(String url, Function callback,
      {params, Function errorCallback}) async {
//    try {
    final res = await http.post(AppConfig.AJAX_SERVER_API + url, body: params);
//    Tinker.toast("执行");
    print("aaaaaaaaaaaaa");
    print(res.body.toString());
    var data = json.decode(res.body);
    print(data);
    print("11112222222222222");
    if (data["statusCode"] == "200") {
//      Tinker.toast("执行");
      callback(data);
    } else {
      print("-----------------");
      print(data);
      Tinker.toast(data["message"]);
    }
//    } catch (e) {
//      Tinker.toast("失败");
//      if (errorCallback != null) {
//        errorCallback(e);
//      }
//    }
  }

  //查询用户信息
  static void queryUserInfo(userId, callback) {
    FormData p = FormData.from({
      'userId': userId,
      'type': 0,
      'fromUserId':
          Tinker.getStrong() == null ? "" : Tinker.getStrong()["userId"]
    });
    post(AppConfig.AJAX_SERVER_API + "/api/user/doUserMessage", (data) {
      print("============================");
      print(data["rows"].toString());
      callback(data["rows"].toString());
    }, params: p);
  }

  //保存本地用户信息
  static Future setStrong(object) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("user1", object);
  }

  //获取本地用户信息
  static getStrong() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("============================");
    print(prefs.get("user1"));
    return prefs.get("user1");
  }

  ///
  ///
  ///
  ///

  ///
  ///获取app主题
  ///
  static ThemeData getThemeData() {
    return ThemeData(
        fontFamily: "Arial",
        primaryColor: Colors.yellow,
        accentColor: Colors.blue,
        textTheme: TextTheme(caption: TextStyle(fontSize: 18)));
  }

//  static final Dio _dio = Dio(BaseOptions(
//      connectTimeout: AppConfig.AJAX_TIMEOUT,
//      receiveTimeout: AppConfig.AJAX_TIMEOUT,
//      baseUrl: AppConfig.AJAX_SERVER_API,
//      headers: {"1": 1}));

//  static BuildContext _buildContext;
//
//  static void initContext(BuildContext buildContext) {
//    _buildContext = buildContext;
//  }

//  static void toast(
//    BuildContext context,
//    String msg,
//  ) {
//    OverlayState overlayState = Overlay.of(context);
//    OverlayEntry overlayEntry = OverlayEntry(builder: (context) {
//      _buildToastLayout(msg);
//    });
//    overlayState.insert(overlayEntry);
//  }

  static LayoutBuilder _buildToastLayout(String msg) {
    return LayoutBuilder(builder: (context, constraints) {
      return IgnorePointer(
        ignoring: true,
        child: Container(
          child: Material(
            color: Colors.white.withOpacity(0),
            child: Container(
              child: Container(
                child: Text(
                  "${msg}",
                  style: TextStyle(color: Colors.white),
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              ),
              margin: EdgeInsets.only(
                bottom: constraints.biggest.height * 0.15,
                left: constraints.biggest.width * 0.2,
                right: constraints.biggest.width * 0.2,
              ),
            ),
          ),
          alignment: Alignment.bottomCenter,
        ),
      );
    });
  }

//  ///网络请求
//  static Future<Map> ajax(
//    String url, {
//    method: AppConfig.AJAX_METHOD_GET,
//    Map values,
//    Map header,
//  }) async {
//    print({
//      "url": url,
//      "method": method,
//      "values": values,
//    });
//
//    Dio _dio = Dio(BaseOptions(
//        connectTimeout: AppConfig.AJAX_TIMEOUT,
//        receiveTimeout: AppConfig.AJAX_TIMEOUT,
//        baseUrl: AppConfig.AJAX_SERVER_API,
//        headers: header));
//
//    ///设置ajax拦截器
//    _dio.interceptors
//
//      ///Cookie控制
//      ..add(CookieManager(CookieJar()))
//
//      ///请求拦截器
//      ..add(InterceptorsWrapper(
//        onRequest: (RequestOptions options) {
//          // 在请求被发送之前做一些事情
//          if (AppConfig.AJAX_LOG) {
//            print(
//                "发起请求：URL:${options.baseUrl}${options.uri},Method:${options.method},values:${options.queryParameters}");
//          }
//
//          return options; //continue
//          // 如果你想完成请求并返回一些自定义数据，可以返回一个`Response`对象或返回`dio.resolve(data)`。
//          // 这样请求将会被终止，上层then会被调用，then中返回的数据将是你的自定义数据data.
//          //
//          // 如果你想终止请求并触发一个错误,你可以返回一个`DioError`对象，或返回`dio.reject(errMsg)`，
//          // 这样请求将被中止并触发异常，上层catchError会被调用。
//        },
//        onResponse: (Response response) {
//          // 在返回响应数据之前做一些预处理
//          if (AppConfig.AJAX_LOG) {
//            print(response.data);
//          }
//          if (response.statusCode != 200 ||
//              json.decode(response.data)[AppConfig.AJAX_STATUS_NAME] != 200) {
//            return null;
//          }
//          return response; // continue
//        },
//        onError: (DioError e) {
//          // 当请求失败时做一些预处理
//          print(e.message);
//          return e; //continue
//        },
//      ));
//
//    Response response;
//    if (method == AppConfig.AJAX_METHOD_GET) {
//      response = await _dio.get(
//        url,
//        queryParameters: values ??= {},
//      );
//    } else {
//      response = await _dio.post(
//        url,
//        queryParameters: values ??= {},
//      );
//    }
//    if (response != null) {
//      return response.data;
//    } else {}
////    Tinker.toast();
//    final _json = json.decode(response.data);
//    if (response.statusCode == 200 && _json["statusCode"] == "200") {
//      return _json;
//    } else {
////      Tinker.toast();
//    }
//  }

  ///
  /// 创建轮播图
  ///
  static Swiper createSwiper({
    @required List<Widget> widgetList,
  }) {
    return Swiper(
      itemCount: widgetList.length,
      itemBuilder: (ctx, index) {
        if (index < widgetList.length) {
          return widgetList[index];
        } else {
          return null;
        }
      },
      pagination: SwiperPagination(
        builder: DotSwiperPaginationBuilder(
          color: AppConfig.APP_COLOR_BACKGROUND,
          activeColor: AppConfig.APP_COLOR_THEME,
          activeSize: 7.0,
          size: 7.0,
        ),
      ),
      autoplay: true,
      viewportFraction: 1,
      scale: 0.8,
    );
  }

  //图片选择器，callback参数为data是返回的图片地址集合，类型为List<File>
  static Widget Select_Image_picker({
    Key key,
    @required double Image_height, //添加的图片的高度,
    @required double Image_width, //添加的图片的宽度,
    @required double count, //可添加的图片的数量,
    @required Widget Click_Image_file, //添加图片的点击按钮图,
    @required double spacing, //图片的左右间距,
    @required double line_count, //每行图片的数量
    @required double runSpacing, //图片的上下间距,
    @required Function callback, //回调函数,
  }) {
    return Container(
      child: Image_picker(
        count: count,
        Img_width: Image_width,
        Img_height: Image_height,
        Image_file: Click_Image_file,
        spacing: spacing,
        runSpacing: runSpacing,
        callback: callback,
        line_count: line_count,
      ),
    );
  }

//toast提示
  static void toast(String msg) {
    showToast(
      msg,
      radius: 20,
      textPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      textStyle: TextStyle(color: Colors.black),
      position: ToastPosition.bottom,
      duration: Duration(milliseconds: 800),
      backgroundColor: Color.fromRGBO(250, 250, 250, 1),
    );
  }

//md5加密
  static String generateMd5(String data) {
    var content = new Utf8Encoder().convert(data);
    var digest = md5.convert(content);
    // 这里其实就是 digest.toString()
    return hex.encode(digest.bytes);
  }
}

class TinkerScaffold extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TinkerScaffoldState();
  }
}

class TinkerScaffoldState extends State<TinkerScaffold>
    with TickerProviderStateMixin {
  List<Widget> _screenList = List<Widget>();
  List<BottomNavigationBarItem> _itemList = List<BottomNavigationBarItem>();
  var _bottomAppBarItemList;
  int _currentIndex = 1;
  PageView _pageView;
  PageController _pageController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initBottomTabBarList();
    _initScreenList();
    _initBottomAppVarItemList();
    _initPageController();
    _initPageView();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: Tinker.getThemeData(),
      routes: {
        "/edit": (BuildContext context) => new EditIndex(),
      },
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: _pageView,
        bottomNavigationBar: AppConfig.IS_BOTTOM_FLOAT_ICON
            ? _createBottonAppBar()
            : _createBottonNavigationBar(),
        floatingActionButton: AppConfig.IS_BOTTOM_FLOAT_ICON
            ? FloatingActionButton(
                onPressed: () {
                  _switchTab(2);
                },
                child: AppConfig.BOTTOM_TAB_BAR_FLOAT_ICON,
                backgroundColor: AppConfig.BOTTOM_TAB_BAR_COLOR_SELECT,
              )
            : null,
        floatingActionButtonLocation: AppConfig.IS_BOTTOM_FLOAT_ICON
            ? FloatingActionButtonLocation.centerDocked
            : null,
      ),
    );
  }

  _switchTab(index) async {
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();

    if (index == 2) {
      if (prefs.get("user1") == null) {
        Navigator.push(
            context, CupertinoPageRoute(builder: (context) => Login()));
      } else {
        Navigator.push(
            context, CupertinoPageRoute(builder: (context) => EditIndex()));
      }
    } else {
      if (index == 1) {
        setState(() {
          _currentIndex = index;
          _initBottomAppVarItemList();
        });
      } else {
        if (prefs.get("user1") == null) {
          Navigator.push(
              context, CupertinoPageRoute(builder: (context) => Login()));
        } else {
          setState(() {
            _currentIndex = index;
            _initBottomAppVarItemList();
          });
        }
      }
    }
    _pageController.animateToPage(
      _currentIndex,
      duration: Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }

  BottomAppBar _createBottonAppBar() {
    return BottomAppBar(
      child: Container(
        padding: EdgeInsets.symmetric(
//          horizontal: 10,
          vertical: 0,
        ),
        height: 60,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _bottomAppBarItemList,
        ),
      ),
//      elevation: 20.0,
      shape: CircularNotchedRectangle(),
    );
  }

  Widget _createBottonNavigationBar() {
    double bottom, height;
    final double bottomPadding = MediaQuery.of(context).padding.bottom;
    if (bottomPadding == 34) {
      height = 87;
      bottom = 34;
    } else {
      height = 55;
      bottom = 0;
    }
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Colors.black12, width: 1))),
        height: height,
        child: Stack(
          children: <Widget>[
            Align(
              child: BottomNavigationBar(
//                elevation: 20,
                currentIndex: _currentIndex,
                onTap: (index) => _switchTab(index),
                items: _itemList,
                type: BottomNavigationBarType.fixed,
//      fixedColor: AppConfig.BOTTOM_TAR_BAR_COLOR[1],
                selectedItemColor: AppConfig.BOTTOM_TAB_BAR_COLOR_SELECT,
                unselectedItemColor: AppConfig.BOTTOM_TAB_BAR_COLOR,
                selectedFontSize: AppConfig.BOTTOM_TAB_BAR_TITLE_SIZE_SELECT,
                unselectedFontSize: AppConfig.BOTTOM_TAB_BAR_TITLE_SIZE,
                backgroundColor: Colors.white,
              ),
              alignment: Alignment.bottomCenter,
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(bottom: bottom),
              child: GestureDetector(
                  child: new Image.asset(
                    "image/fabu_btn.png",
                    width: 40.0,
                    height: 40.0,
                  ),
                  onTap: () async {
//                  Navigator.push(context,
//                      CupertinoPageRoute(builder: (context) => EditIndex()));
                    SharedPreferences prefs;
                    prefs = await SharedPreferences.getInstance();
                    if (prefs.get("user1") == null) {
                      Navigator.push(context,
                          CupertinoPageRoute(builder: (context) => Login()));
                    } else {
                      if (_currentIndex == 0) {
                        Navigator.push(
                            context,
                            EnterExitRoute(
                                exitPage: MessageIndex(),
                                enterPage: EditIndex()));
                      } else if (_currentIndex == 1) {
                        Navigator.push(
                            context,
                            EnterExitRoute(
                                exitPage: MainIndex(), enterPage: EditIndex()));
                      } else if (_currentIndex == 3) {
                        Navigator.push(
                            context,
                            EnterExitRoute(
                                exitPage: ShoucangIndex(),
                                enterPage: EditIndex()));
                      } else if (_currentIndex == 4) {
                        Navigator.push(
                            context,
                            EnterExitRoute(
                                exitPage: UserIndex(), enterPage: EditIndex()));
                      }
                    }
                  }),
            )
          ],
        ));
  }

  ///初始化pagecontroller
  void _initPageController() {
    _pageController = PageController(
      initialPage: _currentIndex,
      keepPage: true,
    );
  }

  ///初始化pageviwe
  void _initPageView() {
    _pageView = PageView(
      controller: _pageController,
      children: _screenList,
      scrollDirection: Axis.horizontal,
      pageSnapping: true,
      physics: NeverScrollableScrollPhysics(),
    );
  }

  ///初始化底部导航栏，突起按钮样式
  void _initBottomAppVarItemList() {
    _bottomAppBarItemList = List<Widget>();
    for (var i = 0; i < AppConfig.BOTTOM_TAB_BAR_TITLE.length; i++) {
      SharedPreferences prefs;
      _bottomAppBarItemList.add(
        InkWell(
          onTap: () async => {
            if (i == 1)
              {
                _switchTab(i),
              }
            else
              {
                print("aaaaaaaaaaaaaaaaaa"),
                prefs = await SharedPreferences.getInstance(),
                print(prefs.get("user1")),
                if (prefs.get("user1") == null)
                  {
//                        Tinker.toast("为空"),
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (context) => Login())),
                  }
                else
                  _switchTab(i),
              }
          },
          borderRadius: BorderRadius.all(Radius.circular(100)),
          child: AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(0x00, 0xff, 0xff, 0xff),
                shape: BoxShape.circle,
              ),
              padding: EdgeInsets.all(5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  i == _currentIndex
                      ? Image.asset(
                          AppConfig.BOTTOM_TAB_BAR_IMAGE_SELECT[i],
                          width: AppConfig.BOTTOM_TAB_BAR_IMAGE_WIDTH,
                          height: AppConfig.BOTTOM_TAB_BAR_IMAGE_HEIGHT,
                        )
                      : Image.asset(
                          AppConfig.BOTTOM_TAB_BAR_IMAGE[i],
                          width: AppConfig.BOTTOM_TAB_BAR_IMAGE_WIDTH,
                          height: AppConfig.BOTTOM_TAB_BAR_IMAGE_HEIGHT,
                        ),
                  Text(
                    AppConfig.BOTTOM_TAB_BAR_TITLE[i],
                    style: TextStyle(
                      fontSize: AppConfig.BOTTOM_TAB_BAR_TITLE_SIZE,
                      color: i == _currentIndex
                          ? AppConfig.BOTTOM_TAB_BAR_COLOR_SELECT
                          : AppConfig.BOTTOM_TAB_BAR_COLOR,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      //为突起按钮留下位置
      if (i == 1) {
        _bottomAppBarItemList.add(
          GestureDetector(
            onTap: () => {
              _switchTab(i),
            },
            child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(0x00, 0xff, 0xff, 0xff),
                  shape: BoxShape.circle,
                ),
                padding: EdgeInsets.all(5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[],
                ),
              ),
            ),
          ),
        );
      }
    }
  }

  //初始化底部导航栏，无突起按钮
  void _initBottomTabBarList() {
    for (var i = 0; i < AppConfig.BOTTOM_TAB_BAR_TITLE.length; i++) {
      _itemList.add(BottomNavigationBarItem(
        icon: Image.asset(
          AppConfig.BOTTOM_TAB_BAR_IMAGE[i],
          width: AppConfig.BOTTOM_TAB_BAR_IMAGE_WIDTH,
          height: AppConfig.BOTTOM_TAB_BAR_IMAGE_HEIGHT,
        ),
        activeIcon: Image.asset(
          AppConfig.BOTTOM_TAB_BAR_IMAGE_SELECT[i],
          width: AppConfig.BOTTOM_TAB_BAR_IMAGE_WIDTH,
          height: AppConfig.BOTTOM_TAB_BAR_IMAGE_HEIGHT,
        ),
        title: Text(
          AppConfig.BOTTOM_TAB_BAR_TITLE[i],
        ),
      ));
    }
  }

  ///初始化页面路由
  void _initScreenList() {
    _screenList
      ..add(MessageIndex())
      ..add(MainIndex())
      ..add(null)
      ..add(ShoucangIndex())
      ..add(UserIndex());
  }
}

class Image_picker extends StatefulWidget {
  @override
//  Drag({Key key, this.imgList}) : super(key: key);
//  final List<File> imgList;   // 用来储存传递过来的值
  final double Img_width; //图片宽度
  final double count; //可添加图片的数量
  final Widget Image_file; //添加图片的按钮图
  final double Img_height; //图片的高度
  final double spacing; //图片的左右间隔
  final double runSpacing; //图片的上下间隔
  final double line_count; //一行图片的数量
  final Function callback; //回调函数
  State<StatefulWidget> createState() {
    return Select_Image_pickerState();
  }

  Image_picker(
      {Key key,
      this.Img_width,
      this.Img_height,
      this.count,
      this.spacing,
      this.runSpacing,
      this.Image_file,
      this.callback,
      this.line_count})
      : super(key: key);
}

class Select_Image_pickerState extends State<Image_picker> {
  @override
  List imgList = new List<File>();
  List _dataListBackup = new List<File>();
  bool _showItemWhenCovered = false; //手指覆盖的地方，即item被拖动时 底部的那个widget是否可见；
  int _willAcceptIndex = -1; //当拖动覆盖到某个item上的时候，记录这个item的坐标

  @override
  void initState() {
    super.initState();
    _dataListBackup = imgList.sublist(0);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
//    _scrollController?.dispose();
  }

  Widget build(BuildContext context) {
//    imgList=widget.imgList;
    // TODO: implement build
    return new Container(
      child: img(),
    );
  }

//显示图片
  Widget img() {
    List<Widget> tiles = []; //先建一个数组用于存放循环生成的widget
    Widget content; //单独一个widget组件，用于返回需要生成的内容widget
    var img;
    for (var i = 0; i < imgList.length; i++) {
      img = imgList[i];
      var d = imgList[i].path;
      double spac = widget.spacing;
      setState(() {
        if ((i + 1) % widget.line_count == 0) {
          spac = 0;
        }
      });
      tiles.add(
        new Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: LongPressDraggable(
                data: imgList[i],
                child: new DragTarget(
                  onAccept: (data) {
//            var bj;
//            print("data = $data img=$img onAccept");
//            setState(() {
//              for (var i = 0; i < imgList.length; i++) {
//                if (data == imgList[i]) {
//                  bj = i;
//                }
//              }
//              img = imgList[i];
//              imgList[i] = data;
//              imgList..removeAt(i);
//              imgList.insert(bj, img);
////              img = imgList[i];
////              imgList[i] = data;
////              imgList[bj] = img;
//
//              print("data = $data img=$img onAccept");
//            });
                  },
                  builder: (context, data, rejectedData) {
                    if (_willAcceptIndex >= 0 && _willAcceptIndex == i) {
                      return new Container(
                        width: widget.Img_width,
                        height: widget.Img_height,
                        margin: EdgeInsets.fromLTRB(
                            0, 0, widget.spacing, widget.runSpacing),
                      );
                    } else {
                      if ((i + 1) % widget.line_count == 0) {
                        return Container(
                          child: Image.file(
                            imgList[i],
                            height: widget.Img_height,
                            width: widget.Img_width,
                            fit: BoxFit.fill,
                          ),
                          margin: EdgeInsets.fromLTRB(
                              0, 0, widget.spacing, widget.runSpacing),
//                          margin:
//                              EdgeInsets.fromLTRB(0, 0, 0, widget.runSpacing),
                        );
                      } else {
                        return Container(
                          child: Image.file(
                            imgList[i],
                            height: widget.Img_height,
                            width: widget.Img_width,
                            fit: BoxFit.fill,
                          ),
                          margin: EdgeInsets.fromLTRB(
                              0, 0, spac, widget.runSpacing),
                        );
                      }
                    }
                  },
                  onLeave: (data) {
                    print("data = $data onLeave");
                    _willAcceptIndex = -1;
                    setState(() {
                      _showItemWhenCovered = false;
                      print(_dataListBackup);
                      imgList = _dataListBackup.sublist(0);
                    });
                  },
                  onWillAccept: (data) {
                    print("data = $data onWillAccept");
                    var bj;
                    for (var i = 0; i < imgList.length; i++) {
                      if (data == imgList[i]) {
                        bj = i;
                      }
                    }
//            img = imgList[i];
//            imgList[i] = data;
                    final accept = bj != i;
                    if (accept) {
                      print(
                          "data = $data img=$img onAccept---------------------------------------$i");
                      imgList = _dataListBackup.sublist(0);
                      setState(() {
                        var bj;
                        for (var i = 0; i < imgList.length; i++) {
                          if (data == imgList[i]) {
                            bj = i;
                          }
                        }
                        print(
                            "----------------------------------------------------");
                        print(i);
//                  img = imgList[i];
//                  imgList[i] = data;
//                  imgList[bj] = img;
                        _showItemWhenCovered = true;
//
                        _willAcceptIndex = i;
                        print(data);
                        imgList.removeAt(bj);
                        imgList.insert(i, data);
                      });
                    }

                    return accept;
                  },
                ),
                onDragStarted: () {
                  //开始拖动，备份数据源
//            _draggingItemIndex = index;
                  _dataListBackup = imgList.sublist(0);
                  print(_dataListBackup);
                  print('item $i ---------------------------onDragStarted');
                },
                onDraggableCanceled: (Velocity velocity, Offset offset) {
                  print(
                      'item $i ---------------------------onDraggableCanceled,velocity = $velocity,offset = $offset');
                  //拖动取消，还原数据源
                  setState(() {
                    _willAcceptIndex = -1;
                    _showItemWhenCovered = false;
                    imgList = _dataListBackup.sublist(0);
                    print(imgList);
                  });
                },
                onDragCompleted: () {
                  //拖动完成，刷新状态，重置willAcceptIndex
                  print("item $i ---------------------------onDragCompleted");
                  setState(() {
                    _showItemWhenCovered = false;
                    _willAcceptIndex = -1;
                  });
                },
                feedback: Image.file(
                  img,
                  height: widget.Img_height,
                  width: widget.Img_width,
                  fit: BoxFit.fill,
                ),
                childWhenDragging: new Container(
                  child: _showItemWhenCovered
                      ? Image.file(
                          imgList[i],
                          height: widget.Img_height,
                          width: widget.Img_width,
                          fit: BoxFit.fill,
                        )
                      : null,
                  width: widget.Img_width,
                  height: widget.Img_height,
                  margin: EdgeInsets.fromLTRB(
                      0, 0, widget.spacing, widget.runSpacing),
                ),
              ),
              height: widget.Img_height + 20,
            ),
            Positioned(
              child: InkWell(
                child: Image.asset(
                  "image/del@2x.png",
                  height: 15,
                  width: 15,
                  fit: BoxFit.fill,
                ),
                onTap: () {
                  setState(() {
                    imgList.removeAt(i);
                  });
                },
              ),
              right: 5,
              top: 0,
            )
          ],
        ),
      );
    }
    //添加按钮图片
    if (imgList.length < widget.count) {
      tiles.add(
        new Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, widget.runSpacing),
          child: new InkWell(
              child: widget.Image_file,
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return new SafeArea(
                          child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          new ListTile(
                            leading: AppConfig.Image_picker_icon1,
                            title: new Text(AppConfig.Image_picker_name1),
                            onTap: () async {
                              _takePhoto();
                              Navigator.of(context).pop();
                            },
                          ),
                          new ListTile(
                            leading: AppConfig.Image_picker_icon2,
                            title: new Text(AppConfig.Image_picker_name2),
                            onTap: () async {
                              _openGallery();
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ));
                    });
              }),
        ),
      );
    }

    Widget row;
    List<Widget> rows = [];
    for (var i = 0; i < tiles.length; i++) {
      List<Widget> items = [];
      if (i % widget.line_count == 0) {
        for (var j = 0; j < widget.line_count && i < tiles.length; j++) {
          items.add(tiles[i]);
          i++;
        }
        row = new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: items,
        );
      }
      i--;
      rows.add(row);
    }
    content = new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: rows,
    );
//    content = new Container(
//      child: new Wrap(
//        children: tiles,
//        spacing: widget.spacing,
//        runSpacing: widget.runSpacing,
//      ),
//      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
//    );
    if (imgList.length != 0) {
      widget.callback(imgList);
    }
//    return GridView.count(
//        childAspectRatio: 1.0, //item宽高比
//        scrollDirection: Axis.vertical, //默认vertical
//        crossAxisCount: 3, //列数
//        mainAxisSpacing: 10,
//        crossAxisSpacing: 10,
//        children: tiles,
//    );
    return content;
  }

  /*拍照*/
  Future _takePhoto() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        imgList.add(image);
      });
    }
  }

  /*相册*/
  Future _openGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        imgList.add(image);
      });
    }
  }
}
