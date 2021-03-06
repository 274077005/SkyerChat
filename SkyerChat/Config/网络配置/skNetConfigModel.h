//
//  skNetConfigModel.h
//  SkyerChat
//
//  Created by admin on 2018/9/29.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface skNetConfigModel : NSObject
SkyerSingletonH(skNetConfigModel)
@property (nonatomic , copy)   NSString              * clientName;
@property (nonatomic , copy)   NSString              * appId;
@property (nonatomic , assign) NSInteger             readTimeout;
@property (nonatomic , copy)   NSString              * enName;
@property (nonatomic , copy)   NSString              * apiServer;
@property (nonatomic , copy)   NSString              * appSecret;
@property (nonatomic , copy)   NSString              * gzip;
@property (nonatomic , assign) NSInteger             connTimeout;
//自添加参数
@property (nonatomic , copy)   NSString              * phoneNo;
@property (nonatomic , copy)   NSString              * passwd;
@property (nonatomic , copy)   NSString              * smsCode;
@property (nonatomic , copy)   NSString              * nonce;
@end

NS_ASSUME_NONNULL_END
