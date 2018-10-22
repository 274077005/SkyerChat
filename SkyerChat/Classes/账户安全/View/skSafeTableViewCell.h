//
//  skSafeTableViewCell.h
//  SkyerChat
//
//  Created by admin on 2018/10/22.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface skSafeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UILabel *labContain;

@end

NS_ASSUME_NONNULL_END
