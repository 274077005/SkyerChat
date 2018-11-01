//
//  GroupDesModel.h
//  SkyerChat
//
//  Created by admin on 2018/11/1.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GroupDesModel : NSObject
@property (nonatomic , assign) NSInteger              vipLevel;
@property (nonatomic , assign) NSInteger              createUserId;
@property (nonatomic , copy) NSString              * groupName;
@property (nonatomic , assign) NSInteger              groupType;
@property (nonatomic , copy) NSString              * createTime;
@property (nonatomic , assign) NSInteger              groupId;
@property (nonatomic , copy) NSString              * createUserNo;
@property (nonatomic , copy) NSString              * createNickname;
@property (nonatomic , copy) NSString              * groupNo;
@property (nonatomic , assign) BOOL              status;
@end

NS_ASSUME_NONNULL_END
