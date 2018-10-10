//
//  UserLogin.m
//  SkyerChat
//
//  Created by admin on 2018/10/10.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "UserLogin.h"

@implementation UserLogin
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}
-(void)setUp{
    
    _btnEnableSignal=[RACSignal combineLatest:@[RACObserve(self, loginPhone),RACObserve(self, loginPwd)] reduce:^id _Nonnull(NSString * loginPhone,NSString * loginPwd){
        NSLog(@"loginPhone=%@loginPwd=%@",loginPhone,loginPwd);
        if (![skClassMethod skValiMobile:loginPhone]) {
            return 0;
        }
        if (loginPwd.length<6) {
            return 0;
        }
        if (loginPwd.length>16) {
            return 0;
        }
        return @(loginPhone.length && loginPwd.length);
        
    }];
}
@end
