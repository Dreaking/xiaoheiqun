package com.fuman.flutter.xiaoheiqun;

import android.content.Context;
import android.os.Bundle;
import android.support.multidex.MultiDex;

import com.umeng.analytics.MobclickAgent;
import com.umeng.commonsdk.UMConfigure;
import com.umeng.message.IUmengRegisterCallback;
import com.umeng.message.PushAgent;

import io.flutter.Log;
import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
public class MainActivity extends FlutterActivity {
  private static final String CHANNEL = "com.fuman.flutter/u_push";

  private Registrar registrar;
  public void onResume() {
    super.onResume();
    MobclickAgent.onResume(this);
  }
  @Override
  public void onPause() {
    super.onPause();
    MobclickAgent.onPause(this);
  }
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    PushAgent.getInstance(this).onAppStart();
    super.onCreate(savedInstanceState);
    MultiDex.install(this);
    GeneratedPluginRegistrant.registerWith(this);
    new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
            new MethodCallHandler() {
              @Override
              public void onMethodCall(MethodCall call, Result result) {
                // TODO
                if (call.method.equals("init")) {
                  regist1();
                  result.success("true");
                }else {
                  result.notImplemented();

                }
              }
            });
  }

  void regist1(){
    UMConfigure.init(this, "5d3ea8890cafb275c5000052", "Umeng", UMConfigure.DEVICE_TYPE_PHONE, "2949f1f482542e6ec49c8dd823eb2ad2");
    MobclickAgent.setPageCollectionMode(MobclickAgent.PageMode.AUTO);
    MobclickAgent.setSessionContinueMillis(1000*40);

    //获取消息推送代理示例
    PushAgent mPushAgent = PushAgent.getInstance(this);
    mPushAgent.setResourcePackageName("com.fuman.flutter.xiaoheiqun");

//注册推送服务，每次调用register方法都会回调该接口
    mPushAgent.register(new IUmengRegisterCallback() {

      @Override
      public void onSuccess(String deviceToken) {
        //注册成功会返回deviceToken deviceToken是推送消息的唯一标志
        Log.i("tabl1","注册成功：deviceToken：-------->  " + deviceToken);
      }

      @Override
      public void onFailure(String s, String s1) {
        Log.e("tabl1","注册失败：-------->  " + "s:" + s + ",s1:" + s1);
      }
    });
    mPushAgent.setNotificaitonOnForeground(true);



  }
}
