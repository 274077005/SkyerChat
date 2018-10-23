//
//  skChangePasswordModel.h
//  SkyerChat
//
//  Created by admin on 2018/10/22.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface skChangePasswordModel : NSObject
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *code;
@property (nonatomic,strong) NSString *pwd1;
@property (nonatomic,strong) NSString *pwd2;
@property (nonatomic,assign) Boolean isGetCode;//如果是1就要等待60秒再能获取验证码
@property (nonatomic,strong) RACSignal *btnEnableSignal;
@end

NS_ASSUME_NONNULL_END
