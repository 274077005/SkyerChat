//
//  skRootViewController.m
//  SkyerChat
//
//  Created by admin on 2018/10/11.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "skRootViewController.h"


@implementation skRootViewController

+(void)skRootLoginViewController{
    skLoginViewController *skLoginView=[[skLoginViewController alloc] init];
    skBaseNavViewController *skLoginViewNav=[[skBaseNavViewController alloc] initWithRootViewController:skLoginView];
    skUser.isLogin=NO;
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:skLoginUserAuto];
    skKeyWindow.rootViewController=skLoginViewNav;
}
+(void)skAutoLogin{
    ///intf/bizUser/sendRegister
    
    NSString *userName=[SFHFKeychainUtils getPasswordForUsername:skLoginUserName andServiceName:skLoginUserName error:nil];
    NSString *userPWD=[SFHFKeychainUtils getPasswordForUsername:skLoginUserPWD andServiceName:skLoginUserPWD error:nil];
    
    NSString *passwd=[NSString stringWithFormat:@"%@%@",userPWD,skSaltMd5String];
    
    NSDictionary *dic=@{@"phoneNo":userName,
                        @"passwd":[passwd MD5]
                        };
    
    skModelNet.phoneNo=userName;
    skModelNet.passwd=[passwd MD5];
    
    [skAfTool SKPOST:skUrl(@"/intf/bizUser/login") pubParame:skPubParType(portNameLogin) busParame:[dic skDicToJson:dic] showHUD:YES showErrMsg:YES success:^(skResponeModel *  _Nullable responseObject) {
        
        if (responseObject.returnCode==0) {
            [UserModel mj_objectWithKeyValues:responseObject.data];
            
            skUser.isLogin=YES;
            
            [[RongSDKUsed shareInstance] skRongConnectWithToken:skUser.token success:^(NSString *userId) {
                
            } error:^(RCConnectErrorCode status) {
                
            } tokenIncorrect:^{
                
            }];
            
            [skRootViewController skRootTabarViewController];
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}
+(void)skRootTabarViewController{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:skLoginUserAuto];
    skTabarViewController *skLoginView=[[skTabarViewController alloc] init];
    skUser.isLogin=YES;
    skKeyWindow.rootViewController=skLoginView;
    
}

@end
