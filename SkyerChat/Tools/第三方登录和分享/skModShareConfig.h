//
//  skModShareConfig.h
//  SkyerParking
//
//  Created by admin on 2018/8/16.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
//微信SDK头文件
#import <WXApi.h>
#import "ShareUserModel.h"

@interface skModShareConfig : NSObject
typedef void (^ _Nullable getShareUser)(SSDKUser*   _Nullable ShareUser);
/**
 初始化分享模块
 */
+(void)skShareRegist;


/**
 用户分享

 @param type 分享的类型
 */
+(void)skShare:(SSDKPlatformType)type;

/**
 获取用户信息

 @param type 类型
 */
+(void)skGetShare:(SSDKPlatformType)type userInfo:(getShareUser)ShareUser;
@end
