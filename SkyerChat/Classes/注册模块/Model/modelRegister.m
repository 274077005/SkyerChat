//
//  modelRegister.m
//  SkyerChat
//
//  Created by admin on 2018/10/9.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "modelRegister.h"

@implementation modelRegister
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}
-(void)setUp{
    
    _btnEnableSignal=[RACSignal combineLatest:@[RACObserve(self, phone),RACObserve(self, code),RACObserve(self, password),RACObserve(self, passwordAgain),RACObserve(self, isAgree)] reduce:^id _Nonnull(NSString * phone,NSString * code,NSString * password,NSString * passwordAgain,NSString * isAgree){
        
        //验证手机号码
        if (![skClassMethod skValiMobile:phone]) {
            return 0;
        }
        //验证密码长度
        if (password.length<6&&password.length>16) {
            return 0;
        }
        //验证密码是否相等
        if (![password isEqualToString:passwordAgain]) {
            return 0;
        }
        if ([isAgree integerValue]==0) {
            return 0;
        }
        
        return @(phone.length && code.length && password.length && passwordAgain.length);
        
    }];
}
@end
