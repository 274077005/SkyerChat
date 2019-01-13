//
//  skOrderBuyTableViewCell.h
//  SkyerChat
//
//  Created by skyer on 2019/1/13.
//  Copyright © 2019 www.skyer.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface skOrderBuyTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labTime;
@property (weak, nonatomic) IBOutlet UILabel *labState;
@property (weak, nonatomic) IBOutlet UIImageView *imageShop;
@property (weak, nonatomic) IBOutlet UILabel *labShopName;
@property (weak, nonatomic) IBOutlet UILabel *labCount;
@property (weak, nonatomic) IBOutlet UIButton *btnPay;
@property (weak, nonatomic) IBOutlet UILabel *labMeney;

@end

NS_ASSUME_NONNULL_END
