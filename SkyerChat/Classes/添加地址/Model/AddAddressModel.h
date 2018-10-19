//
//  AddAddressModel.h
//  SkyerChat
//
//  Created by admin on 2018/10/19.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/*
 NSDictionary *dic=@
 {@"receiver":@"",
 @"phone":@"",
 @"district":@"",
 @"address":@"",
 @"isDefault":@"",
 @"addressName":@""
 };
 */
@interface AddAddressModel : NSObject

@property (nonatomic,strong) NSString *receiver;
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *district;
@property (nonatomic,strong) NSString *address;
@property (nonatomic,assign) Boolean isDefault;
@property (nonatomic,strong) NSString *addressName;

@end

NS_ASSUME_NONNULL_END
