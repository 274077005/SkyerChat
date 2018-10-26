//
//  skMenuViewController.h
//  SkyerChat
//
//  Created by admin on 2018/10/26.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import "skBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface skMenuViewController : skBaseViewController
@property (nonatomic,strong) void(^chargeType)(NSInteger index);
@property (nonatomic,strong) NSArray *arrTitle;
@end

NS_ASSUME_NONNULL_END
