//
//  CombineCheckTableViewCell.h
//  SkyerChat
//
//  Created by admin on 2018/11/19.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CombineCheckTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UILabel *labNewGroupName;
@property (weak, nonatomic) IBOutlet UILabel *labTime;
@property (weak, nonatomic) IBOutlet UILabel *labMregeDay;
@property (weak, nonatomic) IBOutlet UILabel *labWhoConbine;
@property (weak, nonatomic) IBOutlet UILabel *labState;
@property (weak, nonatomic) IBOutlet UIButton *btnSure;
@property (weak, nonatomic) IBOutlet UIButton *btnEnSure;

@end

NS_ASSUME_NONNULL_END
