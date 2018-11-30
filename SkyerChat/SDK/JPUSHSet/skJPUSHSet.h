//
//  skJPUSHSet.h
//  GpsDuplicate
//
//  Created by SoKing on 2017/11/28.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import <Foundation/Foundation.h>
// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif


#define kjpushChannel @"569965"
#define kjpushIsProduction YES


@interface skJPUSHSet : NSObject <JPUSHRegisterDelegate>

@property (nonatomic,strong) NSString * _Nullable skRegistrationID;

SkyerSingletonH(skJPUSHSet)
/**
 极光推送的配置(AppDelegate的didFinishLaunchingWithOptions中调用)

 @param launchOptions 需要的参数
 */
- (void)skJpushSet:(NSDictionary * _Nullable)launchOptions;

/**
 接收到极光推送的通知

 @param info 详情信息
 */
-(void)skReceiveJPUSHNotification:(NSDictionary *_Nullable)info;

/**
 接收自定义消息的

 @param info 这个是消息内容
 */
-(void)skReceiveJPUSHMessage:(NSDictionary *_Nullable)info;

/**
 接收到消息和通知都在这里接收

 @param info 信息详情
 */
-(void)skReceiveJush:(NSDictionary *_Nullable)info;

/**
 设置别名

 @param name 名字
 */
-(void)skSetAlias:(NSString *_Nullable)name;



@end

