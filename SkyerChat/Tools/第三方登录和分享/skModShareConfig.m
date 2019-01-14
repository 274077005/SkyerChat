//
//  skModShareConfig.m
//  SkyerParking
//
//  Created by admin on 2018/8/16.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "skModShareConfig.h"
#import "ShareUserModel.h"


@implementation skModShareConfig
+(void)skShareRegist{
    
    [ShareSDK registerActivePlatforms:@[
                                        @(SSDKPlatformTypeWechat),
                                        @(SSDKPlatformTypeQQ),
                                        ]
                             onImport:^(SSDKPlatformType platformType) {
                                 switch (platformType)
                                 {
                                         
                                     case SSDKPlatformTypeWechat:
                                         [ShareSDKConnector connectWeChat:[WXApi class]];
                                         break;
                                     case SSDKPlatformTypeQQ:
                                         [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                                         break;
                                     default:
                                         break;
                                 }
                             } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
                                 switch (platformType)
                                 {
                                     
                                     case SSDKPlatformTypeWechat:
                                         [appInfo SSDKSetupWeChatByAppId:@"wx0a0d1b04a5c0f72d"
                                                               appSecret:@"5f3814a49d2f4bfc3ae118d9be191106"];
                                         break;
                                     case SSDKPlatformTypeQQ:
                                         [appInfo SSDKSetupQQByAppId:@"101536307"
                                                              appKey:@"814fd718b13905b15cd06b15792c4c8d"
                                                            authType:SSDKAuthTypeBoth];
                                         break;
                                     default:
                                           break;
                                }}];
}

+(void)skShare:(SSDKPlatformType)type{
    
    //创建分享参数
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:@"扫描下载APP"
                                     images:[UIImage imageNamed:@"蒲公英下载"] //传入要分享的图片
                                        url:[NSURL URLWithString:@"pgyer.com/ahzr"]
                                      title:@"蒲公英下载米粒淘"
                                       type:SSDKContentTypeAuto];
    
    //进行分享
    [ShareSDK share:type //传入分享的平台类型
         parameters:shareParams
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) { // 回调处理....
         
         switch (state) {
             case 1:
             {
                 [SkToast SkToastShow:@"分享成功" withHight:100];
             }
                 break;
             case 2:
             {
                 [SkToast SkToastShow:@"分享失败" withHight:100];
             }
                 break;
             case 3:
             {
                 [SkToast SkToastShow:@"取消分享" withHight:100];
             }
                 break;
                 
             default:
                 break;
         }
         
     }];
}
+(void)skGetShare:(SSDKPlatformType)type userInfo:(getShareUser)ShareUser{
    [ShareSDK getUserInfo:type onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
        
        
        NSLog(@"error===%@",error);
        switch (state) {
            case SSDKResponseStateSuccess:
            {
//                ShareUserModel *model=[ShareUserModel mj_objectWithKeyValues:user.rawData];
                
                ShareUser(user);
                
            }
                break;
            case SSDKResponseStateFail:
            {
                NSLog(@"失败了");
            }
                break;
            case SSDKResponseStateCancel:
            {
                NSLog(@"取消了");
            }
                break;
                
            default:
                break;
        }
    }];
}

@end
