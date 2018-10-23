//
//  skChangePasswordModel.m
//  SkyerChat
//
//  Created by admin on 2018/10/22.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import "skChangePasswordModel.h"

@implementation skChangePasswordModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}
-(void)setUp{
    
    _btnEnableSignal=[RACSignal combineLatest:@[RACObserve(self, phone)] reduce:^id _Nonnull(NSString * phone){
        NSLog(@"手机号码=%@",phone);
        //验证手机号码
        if (![skClassMethod skValiMobile:phone]) {
            return 0;
        }
        
        return @(phone.length);
        
    }];
}
@end
