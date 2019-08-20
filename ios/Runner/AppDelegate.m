#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#include <fluwx/FluwxResponseHandler.h>
#include <fluwx/WXApi.h>
#import <UMCommon/UMCommon.h>
//#import <UMPush/UMessage.h>
#include <jpush_flutter/JPushPlugin.h>
//#import <UserNotifications/UserNotifications.h>
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
    
//    [NSThread sleepForTimeInterval:1]; // 设置启动页面停留时间
//    FlutterViewController* controller = (FlutterViewController*)self.window.rootViewController;
//
//    FlutterMethodChannel* batteryChannel = [FlutterMethodChannel
//                                            methodChannelWithName:@"com.fuman.flutter/u_push"
//                                            binaryMessenger:controller];
//
//    [batteryChannel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
//        if ([@"init" isEqualToString:call.method]) {
//            [UMConfigure initWithAppkey:@"5d4fc0d90cafb2c546000048" channel:@"App Store"];
//            // Push功能配置
//            UMessageRegisterEntity * entity = [[UMessageRegisterEntity alloc] init];
//            entity.types = UMessageAuthorizationOptionBadge|UMessageAuthorizationOptionAlert|UMessageAuthorizationOptionSound;
//            //如果你期望使用交互式(只有iOS 8.0及以上有)的通知，请参考下面注释部分的初始化代码
//            if (([[[UIDevice currentDevice] systemVersion]intValue]>=8)&&([[[UIDevice currentDevice] systemVersion]intValue]<10)) {
//                UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
//                action1.identifier = @"action1_identifier";
//                action1.title=@"打开应用";
//                action1.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
//
//                UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];  //第二按钮
//                action2.identifier = @"action2_identifier";
//                action2.title=@"忽略";
//                action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
//                action2.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
//                action2.destructive = YES;
//                UIMutableUserNotificationCategory *actionCategory1 = [[UIMutableUserNotificationCategory alloc] init];
//                actionCategory1.identifier = @"category1";//这组动作的唯一标示
//                [actionCategory1 setActions:@[action1,action2] forContext:(UIUserNotificationActionContextDefault)];
//                NSSet *categories = [NSSet setWithObjects:actionCategory1, nil];
//                entity.categories=categories;
//            }
//            //如果要在iOS10显示交互式的通知，必须注意实现以下代码
//            if ([[[UIDevice currentDevice] systemVersion]intValue]>=10) {
//                UNNotificationAction *action1_ios10 = [UNNotificationAction actionWithIdentifier:@"action1_identifier" title:@"打开应用" options:UNNotificationActionOptionForeground];
//                UNNotificationAction *action2_ios10 = [UNNotificationAction actionWithIdentifier:@"action2_identifier" title:@"忽略" options:UNNotificationActionOptionForeground];
//
//                //UNNotificationCategoryOptionNone
//                //UNNotificationCategoryOptionCustomDismissAction  清除通知被触发会走通知的代理方法
//                //UNNotificationCategoryOptionAllowInCarPlay       适用于行车模式
//                UNNotificationCategory *category1_ios10 = [UNNotificationCategory categoryWithIdentifier:@"category1" actions:@[action1_ios10,action2_ios10]   intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
//                NSSet *categories = [NSSet setWithObjects:category1_ios10, nil];
//                entity.categories=categories;
//            }
//            [UNUserNotificationCenter currentNotificationCenter].delegate=self;
//            [UMessage registerForRemoteNotificationsWithLaunchOptions:launchOptions Entity:entity completionHandler:^(BOOL granted, NSError * _Nullable error) {
//                if (granted) {
//                }else{
//                }
//            }];
//        } else {
//            result(FlutterMethodNotImplemented);
//        }
//        // TODO
//    }];
    

  return [super application:application didFinishLaunchingWithOptions:launchOptions];
//    return YES;
}

//- (void)application:(UIApplication *)application
//didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
//{
//    if (![deviceToken isKindOfClass:[NSData class]]) return;
//    const unsigned *tokenBytes = (const unsigned *)[deviceToken bytes];
//    NSString *hexToken = [NSString stringWithFormat:@"%08x%08x%08x%08x%08x%08x%08x%08x",
//                          ntohl(tokenBytes[0]), ntohl(tokenBytes[1]), ntohl(tokenBytes[2]),
//                          ntohl(tokenBytes[3]), ntohl(tokenBytes[4]), ntohl(tokenBytes[5]),
//                          ntohl(tokenBytes[6]), ntohl(tokenBytes[7])];
//    NSLog(@"deviceToken:%@",hexToken);
//}
@end
