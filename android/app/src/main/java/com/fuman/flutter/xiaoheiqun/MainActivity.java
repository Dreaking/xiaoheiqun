package com.fuman.flutter.xiaoheiqun;

import android.content.Context;
import android.os.Bundle;
//import android.support.multidex.MultiDex;
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
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);



//    MultiDex.install(this);
    GeneratedPluginRegistrant.registerWith(this);
    new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
            new MethodCallHandler() {
              @Override
              public void onMethodCall(MethodCall call, Result result) {
                // TODO
                if (call.method.equals("init")) {
                  UMConfigure.init(getBaseContext(), "5d3f03754ca3574fd00008f8", "UM", UMConfigure.DEVICE_TYPE_PHONE, "b2965ab349bd892f2a75626a7cc5bcb8");
//获取消息推送代理示例
                  PushAgent mPushAgent = PushAgent.getInstance(getBaseContext());
//注册推送服务，每次调用register方法都会回调该接口
                  mPushAgent.register(new IUmengRegisterCallback() {
                    @Override
                    public void onSuccess(String deviceToken) {
                      //注册成功会返回deviceToken deviceToken是推送消息的唯一标志
                      Log.i("tag","注册成功：deviceToken：-------->  " + deviceToken);
                    }
                    @Override
                    public void onFailure(String s, String s1) {
                      Log.e("tag","注册失败：-------->  " + "s:" + s + ",s1:" + s1);
                    }
                  });
                  PushAgent.getInstance(getBaseContext()).onAppStart();
                  result.success("true");
                }else {
                  result.notImplemented();
                }
              }
            });
  }

  void regist1(){


  }
}
