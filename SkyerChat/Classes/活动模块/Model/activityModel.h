//
//  activityModel.h
//  SkyerChat
//
//  Created by admin on 2018/10/30.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface activityModel : NSObject
@property (nonatomic , copy) NSString              * goodsNo;
@property (nonatomic , assign) NSInteger              goodsId;
@property (nonatomic , copy) NSString              * nickName;
@property (nonatomic , copy) NSString              * userNo;
@property (nonatomic , assign) NSInteger              userId;
@property (nonatomic , copy) NSString              * upTime;
@property (nonatomic , copy) NSString              * createTime;
@property (nonatomic , assign) NSInteger              goodsPrice;
@property (nonatomic , assign) NSInteger              activityPrice;
@property (nonatomic , assign) NSInteger              discountMoney;
@property (nonatomic , copy) NSString              * goodsPic;
@property (nonatomic , assign) NSInteger              stock;
@property (nonatomic , copy) NSString              * goodsName;
@property (nonatomic , copy) NSString              * goodsDesc;
@property (nonatomic , assign) NSInteger              status;



@end

NS_ASSUME_NONNULL_END
