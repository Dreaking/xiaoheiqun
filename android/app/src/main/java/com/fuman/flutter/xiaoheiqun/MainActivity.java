package com.fuman.flutter.xiaoheiqun;

import android.app.ActivityManager;
import android.content.Context;
import android.os.Bundle;
import android.os.Handler;
import android.util.Log;
//import android.support.multidex.MultiDex;
import com.umeng.commonsdk.UMConfigure;
import com.umeng.message.IUmengRegisterCallback;
import com.umeng.message.PushAgent;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
public class MainActivity extends FlutterActivity {
  private static final String CHANNEL = "com.fuman.flutter/u_push";
  private Context mContext;
  private Registrar registrar;
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    PushAgent.getInstance(this).onAppStart();

    mContext=this;
//    MultiDex.install(this);
    GeneratedPluginRegistrant.registerWith(this);
    new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
            new MethodCallHandler() {
              @Override
              public void onMethodCall(MethodCall call, Result result) {
                // TODO
                if (call.method.equals("init")) {
//                  initUmengSDK();
//                  initUmengSDKDelay();
                }else {
                  result.notImplemented();
                }
              }
            });
  }

  void initUmengSDK(){
    UMConfigure.setLogEnabled(true);
    UMConfigure.init(mContext, "5d3ea8890cafb275c5000052", "umeng", UMConfigure.DEVICE_TYPE_PHONE,
            "2949f1f482542e6ec49c8dd823eb2ad2");

    PushAgent.getInstance(this).register(new IUmengRegisterCallback(){

      @Override
      public void onSuccess(String s) {
        android.util.Log.i("walle", "--->>> onSuccess, s is " + s);
      }

      @Override
      public void onFailure(String s, String s1) {
        Log.i("walle", "--->>> onFailure, s is " + s + ", s1 is " + s1);
      }
    });

  }
  private void initUmengSDKDelay(){
    if(getApplicationContext().getPackageName().equals(getCurrentProcessName())){
      new Handler().postDelayed(new Runnable() {
        @Override
        public void run() {
          initUmengSDK();
        }
      }, 5000);
    } else {
      initUmengSDK();
    }
  }
  /**
   * 获取当前进程名
   */
  private String getCurrentProcessName(){
    int pid = android.os.Process.myPid();
    String processName = "";
    ActivityManager manager = (ActivityManager) getApplicationContext().getSystemService
            (Context.ACTIVITY_SERVICE);
    for (ActivityManager.RunningAppProcessInfo process : manager.getRunningAppProcesses()) {
      if (process.pid == pid) {
        processName = process.processName;
      }
    }
    return processName;
  }
}
