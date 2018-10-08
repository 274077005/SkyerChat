//
//  skParamsForRequest.h
//  SkyerChat
//
//  Created by admin on 2018/9/30.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, portName)
{
    portNameResetDefault = 0,
    portNameResetPasswd,
    portNameLogin,
    portNameSendRegister,
    portNameSmsLogin,
};
@interface skParamsForRequest : NSObject
+(NSDictionary *)skPubParams;
+(NSDictionary *)skPubParams:(portName)type;
@end

NS_ASSUME_NONNULL_END
