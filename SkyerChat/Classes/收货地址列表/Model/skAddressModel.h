//
//  skAddressModel.h
//  SkyerChat
//
//  Created by admin on 2018/10/19.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface skAddressModel : NSObject
@property (nonatomic , assign) BOOL              isDefault;
@property (nonatomic , copy) NSString              * address;
@property (nonatomic , copy) NSString              * receiver;
@property (nonatomic , copy) NSString              * addressName;
@property (nonatomic , copy) NSString              * district;
@property (nonatomic , copy) NSString              * createTime;
@property (nonatomic , copy) NSString              * phone;
@property (nonatomic , assign) NSInteger              userId;
@property (nonatomic , assign) NSInteger              raId;
@end

NS_ASSUME_NONNULL_END
