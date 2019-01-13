//
//  skOrderBuyModel.h
//  SkyerChat
//
//  Created by skyer on 2019/1/13.
//  Copyright © 2019 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface skOrderBuyModel : NSObject
@property (nonatomic , assign) NSInteger              buyerId;
@property (nonatomic , copy) NSString              * buyerUserNo;
@property (nonatomic , assign) NSInteger              discountMoney;
@property (nonatomic , assign) NSInteger              goodsAmount;
@property (nonatomic , assign) NSInteger              goodsId;
@property (nonatomic , copy) NSString              * goodsName;
@property (nonatomic , copy) NSString              * goodsNo;
@property (nonatomic , copy) NSString              * goodsPic;
@property (nonatomic , assign) NSInteger              groupId;
@property (nonatomic , copy) NSString              * groupName;
@property (nonatomic , copy) NSString              * groupNo;
@property (nonatomic , assign) NSInteger              orderId;
@property (nonatomic , assign) NSInteger              orderMoney;
@property (nonatomic , copy) NSString              * orderNo;
@property (nonatomic , assign) NSInteger              orderStatus;
@property (nonatomic , copy) NSString              * orderTime;
@property (nonatomic , copy) NSString              * paidCapture;
@property (nonatomic , copy) NSString              * paidTime;
@property (nonatomic , copy) NSString              * postCode;
@property (nonatomic , copy) NSString              * receiver;
@property (nonatomic , copy) NSString              * receiverAddress;
@property (nonatomic , copy) NSString              * receiverPhone;
@property (nonatomic , copy) NSString              * remark;
@property (nonatomic , assign) NSInteger              revAddrId;
@property (nonatomic , assign) NSInteger              sellerId;
@property (nonatomic , copy) NSString              * sellerName;
@property (nonatomic , copy) NSString              * sellerUserNo;
@property (nonatomic , assign) NSInteger              toPayMoney;
@end

NS_ASSUME_NONNULL_END
