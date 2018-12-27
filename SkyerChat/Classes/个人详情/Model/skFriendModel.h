//
//  skFriendModel.h
//  SkyerChat
//
//  Created by skyer on 2018/12/26.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface skFriendModel : NSObject
@property (nonatomic , assign) NSInteger              groupId;
@property (nonatomic , assign) BOOL              isGag;
@property (nonatomic , copy) NSString              * joinTime;
@property (nonatomic , assign) NSInteger              memberType;
@property (nonatomic , copy) NSString              * nickName;
@property (nonatomic , copy) NSString              * portrait;
@property (nonatomic , assign) NSInteger              userId;
@property (nonatomic , copy) NSString              * userNo;
@end

NS_ASSUME_NONNULL_END
