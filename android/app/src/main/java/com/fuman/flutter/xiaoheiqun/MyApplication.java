package com.fuman.flutter.xiaoheiqun;

import android.app.ActivityManager;
import android.content.Context;
import android.os.Handler;
import android.util.Log;

import com.umeng.commonsdk.UMConfigure;
import com.umeng.message.IUmengRegisterCallback;
import com.umeng.message.PushAgent;

import io.flutter.app.FlutterApplication;

public class MyApplication extends FlutterApplication {

    private Context mContext;

    @Override
    public void onCreate() {
        super.onCreate();
        mContext = this;

        initUmengSDK();
        initUmengSDKDelay();
    }

    private void initUmengSDK(){
        UMConfigure.setLogEnabled(true);
        UMConfigure.init(mContext, "5d3ea8890cafb275c5000052", "umeng", UMConfigure.DEVICE_TYPE_PHONE,
                "2949f1f482542e6ec49c8dd823eb2ad2");

        PushAgent.getInstance(this).register(new IUmengRegisterCallback(){

            @Override
            public void onSuccess(String s) {
                Log.i("walle", "--->>> onSuccess, s is " + s);
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
