//
//  AppDelegate.m
//  SkyerChat
//
//  Created by admin on 2018/9/21.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "AppDelegate.h"
#import "skNetConfig.h"
#import "SKKeyboard.h"
#import "skNavigationConfig.h"
#import "skRootViewController.h"
#import "skJPUSHSet.h"
#import "skModShareConfig.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //设置状态栏
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    //第三方分享登录
    [skModShareConfig skShareRegist];
    //极光推送
    [[skJPUSHSet sharedskJPUSHSet] skJpushSet:launchOptions];
    //获取配置文件
    [skNetConfig initNetConfig];
    NSLog(@"url地址=%@",skModelNet.apiServer);
    //初始化键盘管理器
    [SKKeyboard skMangerKeyboard];
    //导航栏设置
    [skNavigationConfig skNavigationInit];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor=[UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [[RongSDKUsed shareInstance] initRongWithAppkey:skRongAppKey];
    
    [skRootViewController skBeforeLoginViewController];
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    application.applicationIconBadgeNumber = [[RongSDKUsed shareInstance] skGetCount];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
