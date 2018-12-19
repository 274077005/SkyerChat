//
//  GroupMenberListModel.h
//  SkyerChat
//
//  Created by skyer on 2018/12/19.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "groupUserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GroupMenberListModel : NSObject
@property (nonatomic , strong) NSArray * members;
@property (nonatomic , assign) NSInteger              toGroupId;
@property (nonatomic , copy) NSString              * toGroupName;
@property (nonatomic , copy) NSString              * toGroupNo;
@property (nonatomic , copy) NSString              * validTime;
@end

NS_ASSUME_NONNULL_END
