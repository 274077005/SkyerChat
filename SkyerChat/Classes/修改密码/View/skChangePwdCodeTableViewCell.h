//
//  skChangePwdCodeTableViewCell.h
//  SkyerChat
//
//  Created by admin on 2018/10/22.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface skChangePwdCodeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labCode;
@property (weak, nonatomic) IBOutlet UIButton *btnCode;
@property (weak, nonatomic) IBOutlet UITextField *textCode;

@end

NS_ASSUME_NONNULL_END
