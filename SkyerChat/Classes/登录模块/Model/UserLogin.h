//
//  UserLogin.h
//  SkyerChat
//
//  Created by admin on 2018/10/10.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserLogin : NSObject
@property (nonatomic,strong) NSString *loginPhone;
@property (nonatomic,strong) NSString *loginPwd;
@property (nonatomic,strong) RACSignal *btnEnableSignal;
@end

NS_ASSUME_NONNULL_END
