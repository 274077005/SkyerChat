//
//  SingleModel.h
//  SkyerChat
//
//  Created by admin on 2018/10/24.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SingleModel : NSObject
@property (nonatomic , copy) NSString              * birthday;
@property (nonatomic , copy) NSString              * registTime;
@property (nonatomic , copy) NSString              * workUnit;
@property (nonatomic , assign) NSInteger              gender;
@property (nonatomic , assign) NSInteger              coins;
@property (nonatomic , copy) NSString              * nickName;
@property (nonatomic , assign) BOOL              isNotify;
@property (nonatomic , copy) NSString              * userNo;
@property (nonatomic , copy) NSString              * sign;
@property (nonatomic , assign) NSInteger              orderNum;
@property (nonatomic , copy) NSString              * idcardNo;
@property (nonatomic , assign) BOOL              isOnline;
@property (nonatomic , copy) NSString              * portrait;
@property (nonatomic , assign) NSInteger              userId;
@property (nonatomic , copy) NSString              * phoneNo;
@property (nonatomic , copy) NSString              * lastLoginTime;
@property (nonatomic , copy) NSString              * realName;
@property (nonatomic , assign) BOOL              canSpeek;
@property (nonatomic , copy) NSString              * hobbies;
@property (nonatomic , copy) NSString              * monthIncome;
@property (nonatomic , assign) NSInteger              isManage;
@property (nonatomic , assign) BOOL              status;
@end

NS_ASSUME_NONNULL_END
