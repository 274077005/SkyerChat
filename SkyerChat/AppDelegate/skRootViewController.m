//
//  skRootViewController.m
//  SkyerChat
//
//  Created by admin on 2018/10/11.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "skRootViewController.h"
#import "skJPUSHSet.h"


@implementation skRootViewController

+(void)skBeforeLoginViewController{
    skBeforeLoginViewController *skLoginView=[[skBeforeLoginViewController alloc] init];
    skBaseNavViewController *skLoginViewNav=[[skBaseNavViewController alloc] initWithRootViewController:skLoginView];
    skUser.isLogin=NO;
    skKeyWindow.rootViewController=skLoginViewNav;
    NSString *isLogin=[[NSUserDefaults standardUserDefaults] objectForKey:skLoginUserAuto];
    
    if ([isLogin isEqualToString:@"登录"]) {
        [skRootViewController skAutoLogin];
    }else{
        [skRootViewController skRootLoginViewController];
    }
}


+(void)skRootLoginViewController{
    skLoginViewController *skLoginView=[[skLoginViewController alloc] init];
    skBaseNavViewController *skLoginViewNav=[[skBaseNavViewController alloc] initWithRootViewController:skLoginView];
    skUser.isLogin=NO;
    skKeyWindow.rootViewController=skLoginViewNav;
}
+(void)skAutoLogin{
    ///intf/bizUser/sendRegister
    
    NSString *userName=[SFHFKeychainUtils getPasswordForUsername:skLoginUserName andServiceName:skLoginUserName error:nil];
    NSString *userPWD=[SFHFKeychainUtils getPasswordForUsername:skLoginUserPWD andServiceName:skLoginUserPWD error:nil];
    
    NSString *passwd=[NSString stringWithFormat:@"%@%@",userPWD,skSaltMd5String];
    
    [skJPUSHSet sharedskJPUSHSet].skRegistrationID=[[NSUserDefaults standardUserDefaults] objectForKey:@"skRegistrationID"];
    
    NSDictionary *dic=@{@"phoneNo":userName,
                        @"passwd":[passwd MD5],
                        @"registrationId":[skJPUSHSet sharedskJPUSHSet].skRegistrationID.length>0?[skJPUSHSet sharedskJPUSHSet].skRegistrationID:@"没注册成功"                        };
    
    skModelNet.phoneNo=userName;
    skModelNet.passwd=[passwd MD5];
    
    [skAfTool SKPOST:skUrl(@"/intf/bizUser/login") pubParame:skPubParType(portNameLogin) busParame:[dic skDicToJson:dic] showHUD:NO showErrMsg:NO success:^(skResponeModel *  _Nullable responseObject) {
        
        if (responseObject.returnCode==0) {
            [UserModel mj_objectWithKeyValues:responseObject.data];
            
            skUser.isLogin=YES;
            [skRootViewController skRootTabarViewController];
        }else{
            [skRootViewController skRootLoginViewController];
        }
        
    } failure:^(NSError * _Nullable error) {
        [skRootViewController skRootLoginViewController];
    }];
}
+(void)skRootTabarViewController{
    [[NSUserDefaults standardUserDefaults] setObject:@"登录" forKey:skLoginUserAuto];
    [[NSUserDefaults standardUserDefaults] synchronize];
    skTabarViewController *skLoginView=[[skTabarViewController alloc] init];
    skUser.isLogin=YES;
    skKeyWindow.rootViewController=skLoginView;
    
}

@end
