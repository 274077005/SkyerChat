//
//  skLinkFriendModel.h
//  SkyerChat
//
//  Created by admin on 2018/10/16.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface skLinkFriendModel : NSObject
@property (nonatomic , copy) NSString              * nickName;
@property (nonatomic , copy) NSString              * phoneName;
@property (nonatomic , copy) NSString              * userNo;
@property (nonatomic , assign) BOOL              isAdded;
@property (nonatomic , copy) NSString              * portrait;
@property (nonatomic , copy) NSString              * phoneNo;

@end

NS_ASSUME_NONNULL_END
