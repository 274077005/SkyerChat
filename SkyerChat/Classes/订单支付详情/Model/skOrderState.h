//
//  skOrderState.h
//  SkyerChat
//
//  Created by skyer on 2019/1/14.
//  Copyright © 2019 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface skOrderState : NSObject

/**
 订单状态

 @param state 后台的状态码
 @return 显示的状态
 */
+(NSString *)getState:(NSInteger)state;
@end

NS_ASSUME_NONNULL_END
