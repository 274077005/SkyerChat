//
//  skConfig.h
//  SkyerChat
//
//  Created by admin on 2018/9/21.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "skAFNetworkingTool.h"
#import "skNetConfigModel.h"
#import "UserModel.h"
#import "skParamsForRequest.h"

@interface skConfig : NSObject
//融云的appkey
#define skRongAppKey @"n19jmcy5n8zf9"
#define skSaltMd5String @"n19jmcy5n8zf9fq8e0r884nadhf"
//账号密码保存
#define skLoginUserName @"LoginUserName"
#define skLoginUserPWD @"LoginUserPWD"
//封装的af单例
#define skAfTool [skAFNetworkingTool shareInstance]
//xib获取
#define skXibView(xibName) [[[NSBundle mainBundle]loadNibNamed:xibName owner:nil options:nil] firstObject];
//网络配置
#define skModelNet [skNetConfigModel sharedskNetConfigModel]
//用户信息
#define skUser [UserModel sharedUserModel]
//请求的url接口
#define skUrl(port) [NSString stringWithFormat:@"%@%@",skModelNet.apiServer,port]
//公共参数
#define skPubPar [skParamsForRequest skPubParams]
//需要加验证的
#define skPubParType(type) [skParamsForRequest skPubParams:type]

@end
