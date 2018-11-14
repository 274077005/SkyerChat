//
//  goodsDecModel.h
//  SkyerChat
//
//  Created by admin on 2018/11/14.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface goodsDecModel : NSObject
@property (nonatomic , assign) NSInteger              activityPrice;
@property (nonatomic , copy) NSString              * createTime;
@property (nonatomic , assign) NSInteger              discountMoney;
@property (nonatomic , copy) NSString              * goodsDesc;
@property (nonatomic , assign) NSInteger              goodsId;
@property (nonatomic , copy) NSString              * goodsName;
@property (nonatomic , copy) NSString              * goodsNo;
@property (nonatomic , copy) NSString              * goodsPic;
@property (nonatomic , strong) NSArray <NSString *>              * goodsPics;
@property (nonatomic , assign) NSInteger              goodsPrice;
@property (nonatomic , copy) NSString              * groupName;
@property (nonatomic , copy) NSString              * groupNo;
@property (nonatomic , copy) NSString              * nickName;
@property (nonatomic , assign) NSInteger              status;
@property (nonatomic , assign) NSInteger              stock;
@property (nonatomic , copy) NSString              * upTime;
@property (nonatomic , assign) NSInteger              userId;
@property (nonatomic , copy) NSString              * userNo;
@end

NS_ASSUME_NONNULL_END
