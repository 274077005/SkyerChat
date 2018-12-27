//
//  skFriendInfoTableViewCell.h
//  SkyerChat
//
//  Created by skyer on 2018/12/26.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface skFriendInfoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labName;
@property (weak, nonatomic) IBOutlet UISwitch *btnSwith;

@end

NS_ASSUME_NONNULL_END
