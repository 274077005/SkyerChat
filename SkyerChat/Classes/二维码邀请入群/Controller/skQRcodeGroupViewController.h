//
//  skQRcodeGroupViewController.h
//  SkyerChat
//
//  Created by admin on 2018/11/13.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import "skBaseViewController.h"
#import "GroupDesModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface skQRcodeGroupViewController : skBaseViewController
@property (nonatomic,strong) GroupDesModel *modelOther;
@property (nonatomic,strong) NSString *groupNo;
@end

NS_ASSUME_NONNULL_END
