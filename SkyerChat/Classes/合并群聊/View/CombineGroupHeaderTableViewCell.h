//
//  CombineGroupHeaderTableViewCell.h
//  SkyerChat
//
//  Created by skyer on 2018/11/14.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CombineGroupHeaderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *btnHeader;
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtDay;

@end

NS_ASSUME_NONNULL_END
