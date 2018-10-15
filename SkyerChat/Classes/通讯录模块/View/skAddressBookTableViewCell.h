//
//  skAddressBookTableViewCell.h
//  SkyerChat
//
//  Created by admin on 2018/10/15.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface skAddressBookTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageTitle;
@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UILabel *labMessage;
@property (weak, nonatomic) IBOutlet UILabel *labTime;

@end

NS_ASSUME_NONNULL_END
