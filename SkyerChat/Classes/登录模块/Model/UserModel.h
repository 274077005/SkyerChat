//
//  UserModel.h
//  SkyerChat
//
//  Created by admin on 2018/9/30.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserModel : NSObject
SkyerSingletonH(UserModel)
@property (nonatomic , copy) NSString              * birthday;
@property (nonatomic , copy) NSString              * registTime;
@property (nonatomic , assign) NSInteger              coins;
@property (nonatomic , copy) NSString              * nickName;
@property (nonatomic , copy) NSString              * userNo;
@property (nonatomic , assign) NSInteger              orderNum;
@property (nonatomic , assign) BOOL              isOnline;
@property (nonatomic , copy) NSString              * portrait;
@property (nonatomic , assign) NSInteger              userId;
@property (nonatomic , copy) NSString              * phoneNo;
@property (nonatomic , copy) NSString              * token;
@property (nonatomic , copy) NSString              * lastLoginTime;
@property (nonatomic , assign) BOOL              canSpeek;
@property (nonatomic , assign) NSInteger              isManage;
@property (nonatomic , assign) BOOL              status;
@property (nonatomic , assign) BOOL              isLogin;
@end

NS_ASSUME_NONNULL_END
