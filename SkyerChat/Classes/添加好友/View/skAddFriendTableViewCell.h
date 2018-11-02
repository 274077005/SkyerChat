//
//  skAddFriendTableViewCell.h
//  SkyerChat
//
//  Created by admin on 2018/10/16.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface skAddFriendTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *btnAddFriend;
@property (weak, nonatomic) IBOutlet UILabel *labName;
@property (weak, nonatomic) IBOutlet UIImageView *imageHeader;
@property (weak, nonatomic) IBOutlet UILabel *labPhone;

@end

NS_ASSUME_NONNULL_END
