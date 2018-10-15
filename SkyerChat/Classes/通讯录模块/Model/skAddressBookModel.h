//
//  skAddressBookModel.h
//  SkyerChat
//
//  Created by admin on 2018/10/15.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface skAddressBookModel : NSObject
@property (nonatomic , assign) NSInteger              ownerId;
@property (nonatomic , assign) NSInteger              userId;
@property (nonatomic , copy) NSString              * userNo;
@property (nonatomic , copy) NSString              * portrait;
@property (nonatomic , copy) NSString              * joinTime;
@end

NS_ASSUME_NONNULL_END
