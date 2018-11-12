//
//  skClassMethod.m
//  SkyerChat
//
//  Created by admin on 2018/10/10.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "skClassMethod.h"

@implementation skClassMethod
+ (BOOL)skValiMobile:(NSString *)mobile
{
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11)
    {
        return NO;
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
    }
}

+(void)skAlertView:(NSString *)alertViewTitle
  alertViewMessage:(NSString *)alertViewMessage
       cancleTitle:(NSString *)cancleTitle
      defaultTitle:(NSString *)defaultTitle
     cancleHandler:(void (^ __nullable)(UIAlertAction *action))cancleHandler
       sureHandler:(void (^ __nullable)(UIAlertAction *action))sureHandler{
    
    UIAlertController *alertView=[UIAlertController alertControllerWithTitle:alertViewTitle message:alertViewMessage preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *action0=[UIAlertAction actionWithTitle:cancleTitle style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        cancleHandler(action);
    }];
    
    UIAlertAction *action1=[UIAlertAction actionWithTitle:defaultTitle style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        sureHandler(action);
    }];
    
    [alertView addAction:action0];
    [alertView addAction:action1];
    [skVSView.navigationController presentViewController:alertView animated:YES completion:^{
        
    }];
}
/**
 对图片进行base64两次加密
 
 @param image 要加密的图片
 @return 加密后的字符串
 */
+(NSString *)skImageBase64:(UIImage *)image
{
    //图片转base64
    NSData *data = UIImageJPEGRepresentation(image, 1.0f);
    
    NSString *encodedImageString = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    NSData *dataString = [encodedImageString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *base64String = [dataString base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    return base64String;
}
@end
