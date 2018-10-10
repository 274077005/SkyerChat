//
//  skParamsForRequest.m
//  SkyerChat
//
//  Created by admin on 2018/9/30.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "skParamsForRequest.h"

@implementation skParamsForRequest
+(NSDictionary *)skPubParams{
    return [self skPubParams:portNameResetDefault];
}
+(NSDictionary *)skPubParams:(portName)type{
    
    /*
     1）    appid 客户端ID，必填；
     2）    clienttype 客户端类型，必填；
     3）    version 客户端版本号，必填；
     4）    intfName 接口名，非必填，Android端使用RMIClient的情况下必填；
     5）    usertype 用户类型，非必填，APP端调用必须登录之后才能操作的接口时必填，传固定值：5；
     6）    userno 用户编号，非必填，APP端调用必须登录之后才能操作的接口时必填，传注册成功后返回的userNo；
     7）    token 登录令牌，非必填，APP端端调用必须登录之后才能操作的接口时必填，APP在登录成功后，请保存接口返回的token。
     8）    nonce 随机数，非必填，需要进行数据签名的接口必填；
     9）    sign 数据签名，非必填，需要进行数据签名的接口必填；
     */
    NSString *nonce=[NSString stringWithFormat:@"%d",arc4random() % 10000000];
    skModelNet.nonce=nonce;
    NSDictionary *dic;
    
    if (skUser.isLogin) {
        dic=@{
              @"appid":skModelNet.appId,
              @"clienttype":@"1",
              @"version":skAppVersion,
              @"intfName":@"",
              @"usertype":@"5",
              @"userno":skUser.userNo,
              @"token":skUser.token,
              @"nonce":nonce,
              @"sign":@""
              };
    }else{
        dic=@{
              @"appid":skModelNet.appId,
              @"clienttype":@"1",
              @"version":skAppVersion,
              @"intfName":@"",
              @"usertype":@"",
              @"userno":@"",
              @"token":@"",
              @"nonce":nonce,
              @"sign":type==0?@"":[self makeSige:type],
              };
    }
    
    return dic;
}


+(NSString *)makeSige:(portName)type{
    
    NSString *sige;
    switch (type) {
        case portNameResetPasswd://重置密码
            sige=[NSString stringWithFormat:@"%@%@%@%@%@",skModelNet.phoneNo,skModelNet.passwd,skModelNet.smsCode,skModelNet.nonce,skModelNet.appSecret];
            break;
        case portNameLogin://登录
            sige=[NSString stringWithFormat:@"%@%@%@%@",skModelNet.phoneNo,skModelNet.passwd,skModelNet.nonce,skModelNet.appSecret];
            break;
        case portNameSendRegister://发生验证码
            sige=[NSString stringWithFormat:@"%@%@%@",skModelNet.phoneNo,skModelNet.nonce,skModelNet.appSecret];
            break;
        case portNameSmsLogin://验证码登录
            sige=[NSString stringWithFormat:@"%@%@%@%@",skModelNet.phoneNo,skModelNet.smsCode,skModelNet.nonce,skModelNet.appSecret];
            break;
            
        default:
            break;
    }
    
    return [sige MD5];
}
@end
