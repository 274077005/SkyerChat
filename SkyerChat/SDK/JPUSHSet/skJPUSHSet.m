//
//  skJPUSHSet.m
//  GpsDuplicate
//
//  Created by SoKing on 2017/11/28.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import "skJPUSHSet.h"
#import <AdSupport/AdSupport.h>




@implementation skJPUSHSet
SkyerSingletonM(skJPUSHSet)
#pragma mark 极光推送的初始化设置
- (void)skJpushSet:(NSDictionary * _Nullable)launchOptions {
    //接收自定义消息的时候需要写
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    [JPUSHService setupWithOption:launchOptions
                           appKey:kjpushKey
                          channel:kjpushChannel
                 apsForProduction:kjpushIsProduction
            advertisingIdentifier:advertisingId];
    //设置别名
    NSSet *setIOS0 = [NSSet setWithObjects:@"iOS", nil];
    [JPUSHService setTags:setIOS0 completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
        
    } seq:1];
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        if(resCode == 0){
            NSLog(@"registrationID获取成功：%@",registrationID);
            self.skRegistrationID=registrationID;
            [[NSUserDefaults standardUserDefaults] objectForKey:@"skRegistrationID"];
        }else{
            NSLog(@"registrationID获取失败，code：%d",resCode);
            self.skRegistrationID=@"极光注册失败";
        }
        
    }];
}

#pragma mark- JPUSHRegisterDelegate
- (void)networkDidReceiveMessage:(NSNotification *)notification {
    NSDictionary * userInfo = [notification userInfo];
    
    NSLog(@"消息%@",userInfo);
    
}
// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    
    NSLog(@"willPresentNotification");
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if (@available(iOS 10.0, *)) {
        if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            [JPUSHService handleRemoteNotification:userInfo];
            [self skReceiveJPUSHNotification:userInfo];
        }
        completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户
    } else {
        // Fallback on earlier versions
    }
    
    
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    NSLog(@"didReceiveNotificationResponse");
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    
    if (@available(iOS 10.0, *)) {
        if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            [JPUSHService handleRemoteNotification:userInfo];
            [self skReceiveJPUSHNotification:userInfo];
        }
        completionHandler();  // 系统要求执行这个方法
    } else {
        // Fallback on earlier versions
    }
}

#pragma mark - 设置别名
-(void)skSetAlias:(NSString *_Nullable)name{
    [JPUSHService setAlias:name completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        if (iResCode==0) {
            NSLog(@"设置别名成功");
        }else{
            NSLog(@"设置别名失败");
        }
    } seq:0];
}
#pragma mark - 对收到的消息进行处理
-(void)skReceiveJPUSHNotification:(NSDictionary *_Nullable)info{
//    NSLog(@"接收到通知=%@",info);
    [self skReceiveJush:info];
}
-(void)skReceiveJPUSHMessage:(NSDictionary *_Nullable)info{
//    NSLog(@"接收到消息=%@",info);
    [self skReceiveJush:info];
}
-(void)skReceiveJush:(NSDictionary *_Nullable)info{
    NSLog(@"接收到消息都在这里=%@",info);
     
}

@end
