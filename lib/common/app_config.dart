import 'package:flutter/material.dart';

class AppConfig {
  ///APP名称
  static const APP_NAME = "小黑裙";

  ///主题色
  static const APP_COLOR_THEME = Color.fromARGB(0xff, 0xd0, 0x02, 0x1b);

  ///背景色
  static const APP_COLOR_BACKGROUND = Color.fromARGB(0xff, 0xf8, 0xf8, 0xf8);

  ///启动页图片地址
  static const APP_LAUNCH_IMAGE = "image/welcome.png";

  ///友盟配置
  static const UMENG_ANDROID_APP_KEY = "5b4ef081f29d9868b9000189";
  static const UMENG_IOS_APP_KEY = "5b4ef081f29d9868b9000189";
  static const UMENG_CHANNEL = "Umeng";

  ///ajax配置
  ///请求超时
  static const AJAX_TIMEOUT = 30 * 1000;

  ///是否开启ajax日志
  static const AJAX_LOG = true;

  ///ajax返回的状态字段key
  static const AJAX_STATUS_NAME = "statusCode";

  ///服务器地址
  static const AJAX_SERVER_API = "http://api.jiashilan.com/";

  //图片服务器地址
  static const AJAX_IMG_SERVER = "http://imgs.jiashilan.com/";

  ///ajax get请求
  static const AJAX_METHOD_GET = "GET";

  ///ajax post请求
  static const AJAX_METHOD_POST = "POST";

  ///
  ///
  ///
  ///底部导航栏相关
  ///
  ///
  ///

  /// 按钮名称
  static const BOTTOM_TAB_BAR_TITLE = <String>["消息", "动态", "", "收藏", "我的"];

  ///按钮图标，未选择
  static const BOTTOM_TAB_BAR_IMAGE = <String>[
    "image/index_share.png",
    "image/index_home.png",
    "",
    "image/index_card.png",
    "image/index_book.png"
  ];

  ///按钮图标，高亮
  static const BOTTOM_TAB_BAR_IMAGE_SELECT = <String>[
    "image/index_share_select.png",
    "image/index_home_select.png",
    "",
    "image/index_card_select.png",
    "image/index_book_select.png"
  ];

  ///图标宽
  static const BOTTOM_TAB_BAR_IMAGE_WIDTH = 24.0;

  ///图标高
  static const BOTTOM_TAB_BAR_IMAGE_HEIGHT = 24.0;

  ///字体大小
  static const BOTTOM_TAB_BAR_TITLE_SIZE = 12.0;

  ///字体大小，高亮
  static const BOTTOM_TAB_BAR_TITLE_SIZE_SELECT = 12.0;

  ///未选择的颜色
  static const BOTTOM_TAB_BAR_COLOR = Color.fromARGB(0xff, 0x99, 0x99, 0x99);

  ///高亮颜色
  static const BOTTOM_TAB_BAR_COLOR_SELECT =
      Color.fromARGB(0xff, 0xd0, 0x02, 0x1b);

  ///是否显示浮动按钮
  static const IS_BOTTOM_FLOAT_ICON = false;

  ///浮动按钮
  static const BOTTOM_TAB_BAR_FLOAT_ICON = Icon(
    Icons.add,
    color: Colors.white,
  );

  ///
  ///
  ///
  ///底部导航栏配置结束
  ///
  ///
  ///
  ///图片选择器配置
  //点击的选项一
  static const String Image_picker_name1 = "相机";

  //点击的选项一图片
  static const Image_picker_icon1 = Icon(
    Icons.photo_camera,
  );

  //点击的选项二
  static const String Image_picker_name2 = "相册";
  //点击的选项二图片
  static const Image_picker_icon2 = Icon(
    Icons.photo_library,
  );

  //微信服务
  static const String WX_PAY_ID = "wx4b5e0d93567cde79";
  static const String WX_PAY_SHOP_ID = "1521937761";
  static const WX_PAY_SECRET = "ff6d85a9ff00bfab3f2bdcf18432459f";
}
