//
//  NSDictionary+skDictionary.h
//  SkyerChat
//
//  Created by admin on 2018/9/30.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (skDictionary)

/**
 词典转json

 @param dict 词典
 @return json字符串
 */
-(NSString *)skDicToJson:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
