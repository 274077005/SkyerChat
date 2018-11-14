//
//  ActivityTitleTableViewCell.h
//  SkyerChat
//
//  Created by admin on 2018/11/14.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ActivityTitleTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labMoney;
@property (weak, nonatomic) IBOutlet UILabel *labName;
@property (weak, nonatomic) IBOutlet UILabel *labDes;

@end

NS_ASSUME_NONNULL_END
