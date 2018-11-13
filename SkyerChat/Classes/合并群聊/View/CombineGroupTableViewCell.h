//
//  CombineGroupTableViewCell.h
//  SkyerChat
//
//  Created by admin on 2018/11/13.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CombineGroupTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageHeader;
@property (weak, nonatomic) IBOutlet UILabel *labName;
@property (weak, nonatomic) IBOutlet UIImageView *imageSelect;

@end

NS_ASSUME_NONNULL_END
