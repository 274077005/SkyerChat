//
//  combineCheckModel.h
//  SkyerChat
//
//  Created by admin on 2018/11/19.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface combineCheckModel : NSObject
@property (nonatomic , copy) NSString              * fromUserNo;
@property (nonatomic , copy) NSString              * fromGroupNo;
@property (nonatomic , assign) NSInteger              fromGroupType;
@property (nonatomic , assign) NSInteger              fromGroupId;
@property (nonatomic , assign) NSInteger              toGroupId;
@property (nonatomic , assign) NSInteger              fromUserId;
@property (nonatomic , copy) NSString              * fromGroupName;
@property (nonatomic , copy) NSString              * toUserNo;
@property (nonatomic , copy) NSString              * toGroupName;
@property (nonatomic , assign) NSInteger              toUserId;
@property (nonatomic , copy) NSString              * mergeNo;
@property (nonatomic , copy) NSString              * xGroupName;
@property (nonatomic , assign) NSInteger              toGroupType;
@property (nonatomic , copy) NSString              * applyTime;
@property (nonatomic , assign) NSInteger              mergeDays;
@property (nonatomic , assign) NSInteger              status;
@property (nonatomic , copy) NSString              * toGroupNo;
@property (nonatomic , copy) NSString              * groupIcon;
@end

NS_ASSUME_NONNULL_END
