//
//  skNetConfig.m
//  SkyerChat
//
//  Created by admin on 2018/9/29.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "skNetConfig.h"

@implementation skNetConfig
/*
 {
 "clientName":"iOS客户端<->基础管理接口子系统",
 "appId":"b400e56b2392574ced9a65ddd9024322",
 "readTimeout":60000,
 "enName":"basic",
 "apiServer":"http://www.iziyou.org/basic",
 "appSecret":"21e2332e3eedc675ac0163abc7d0a4f5",
 "gzip":"off",
 "connTimeout":30000
 }
 */

+(void)initNetConfig{
    
    NSDictionary *dic=@{@"clientName":@"iOS客户端<->基础管理接口子系统",
                        @"appId":@"b400e56b2392574ced9a65ddd9024322",
                        @"readTimeout":@"60000",
                        @"enName":@"basic",
                        @"apiServer":@"http://www.iziyou.org/basic",
                        @"appSecret":@"21e2332e3eedc675ac0163abc7d0a4f5",
                        @"gzip":@"off",
                        @"connTimeout":@"30000"
                        };
    [skNetConfigModel mj_objectWithKeyValues:dic];
}


@end
