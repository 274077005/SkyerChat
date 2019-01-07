//
//  skCombineSubViewController.h
//  SkyerChat
//
//  Created by skyer on 2018/12/28.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import "skBaseViewController.h"
#import "GroupDesModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface skCombineSubViewController : skBaseViewController
@property (nonatomic,strong) GroupDesModel *modelOther;
@property (nonatomic,strong) NSArray *arrGroupList;
@property (nonatomic,strong) NSMutableArray *arrSelect;
@end

NS_ASSUME_NONNULL_END
