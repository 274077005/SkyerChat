//
//  skSubmitOrderViewController.h
//  SkyerChat
//
//  Created by skyer on 2019/1/7.
//  Copyright © 2019 www.skyer.com. All rights reserved.
//

#import "skBaseViewController.h"
#import "goodsDecModel.h"
#import "activityModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface skSubmitOrderViewController : skBaseViewController
@property (nonatomic,strong) goodsDecModel *modelGoods;
@property (nonatomic,strong) activityModel *modelActivity;
@end

NS_ASSUME_NONNULL_END
