//
//  modelRegister.h
//  SkyerChat
//
//  Created by admin on 2018/10/9.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface modelRegister : NSObject
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *password;
@property (nonatomic,strong) NSString *passwordAgain;
@property (nonatomic,strong) NSString *code;
@property (nonatomic,strong) NSString *isAgree;

@property (nonatomic,assign) Boolean isGetCode;//如果是1就要等待60秒再能获取验证码
@property (nonatomic,strong) RACSignal *btnEnableSignal;
@end

NS_ASSUME_NONNULL_END
