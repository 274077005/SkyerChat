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
@end

NS_ASSUME_NONNULL_END
