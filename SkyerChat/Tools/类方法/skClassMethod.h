//
//  skClassMethod.h
//  SkyerChat
//
//  Created by admin on 2018/10/10.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface skClassMethod : NSObject

/**
 验证手机号码

 @param mobile 手机号码
 @return 是否符合
 */

+ (BOOL)skValiMobile:(NSString *)mobile;

/**
 添加一个UIAlertView

 @param alertViewTitle 标题
 @param alertViewMessage message
 @param cancleTitle 取消的title
 @param defaultTitle 确定的title
 @param cancleHandler 取消的回调
 @param sureHandler 确定的回调
 */
+(void)skAlertView:(NSString *)alertViewTitle
  alertViewMessage:(NSString *)alertViewMessage
       cancleTitle:(NSString *)cancleTitle
      defaultTitle:(NSString *)defaultTitle
     cancleHandler:(void (^ __nullable)(UIAlertAction *action))cancleHandler
       sureHandler:(void (^ __nullable)(UIAlertAction *action))sureHandler;
@end

NS_ASSUME_NONNULL_END
