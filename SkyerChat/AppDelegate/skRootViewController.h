//
//  skRootViewController.h
//  SkyerChat
//
//  Created by admin on 2018/10/11.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "skTabarViewController.h"
#import "skLoginViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface skRootViewController : NSObject

/**
 进入登录界面
 */
+(void)skRootLoginViewController;

/**
 进入选下卡首页
 */
+(void)skRootTabarViewController;

+(void)skAutoLogin;
@end

NS_ASSUME_NONNULL_END
