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
@property (nonatomic , assign) NSInteger              orderTotalMoney;
@property (nonatomic , copy) NSString              * userNo;
@property (nonatomic , copy) NSString              * sign;
@property (nonatomic , assign) NSInteger              orderNum;
@property (nonatomic , copy) NSString              * idcardNo;
@property (nonatomic , assign) BOOL              isOnline;
@property (nonatomic , copy) NSString              * phoneNo;
@property (nonatomic , assign) NSInteger              registSource;
@property (nonatomic , assign) BOOL              canSpeek;
@property (nonatomic , copy) NSString              * wechatQrCodeUrl;
@property (nonatomic , assign) NSInteger              isManage;
@property (nonatomic , copy) NSString              * registrationId;
@property (nonatomic , assign) NSInteger              messagesNum;
@property (nonatomic , copy) NSString              * registTime;
@property (nonatomic , copy) NSString              * workUnit;
@property (nonatomic , assign) NSInteger              coins;
@property (nonatomic , copy) NSString              * alipayQrCodeUrl;
@property (nonatomic , copy) NSString              * nickName;
@property (nonatomic , assign) BOOL              isNotify;
@property (nonatomic , assign) NSInteger              loginTimes;
@property (nonatomic , copy) NSString              * portrait;
@property (nonatomic , assign) NSInteger              userId;
//@property (nonatomic , copy) NSString              * token;
@property (nonatomic , copy) NSString              * lastLoginTime;
@property (nonatomic , copy) NSString              * realName;
@property (nonatomic , copy) NSString              * hobbies;
@property (nonatomic , copy) NSString              * monthIncome;
@property (nonatomic , assign) BOOL              status;
//个人添加d字段
@property (nonatomic , assign) BOOL              isLogin;
@property (nonatomic , copy) NSString              * token;
@end

NS_ASSUME_NONNULL_END
