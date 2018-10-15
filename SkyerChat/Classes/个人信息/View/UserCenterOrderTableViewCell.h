//
//  UserCenterOrderTableViewCell.h
//  SkyerChat
//
//  Created by admin on 2018/10/11.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserCenterOrderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labOrderCount;
@property (weak, nonatomic) IBOutlet UILabel *labScoreCount;
@property (weak, nonatomic) IBOutlet UIButton *btnOrder;
@property (weak, nonatomic) IBOutlet UIButton *btnScore;

@end

NS_ASSUME_NONNULL_END
