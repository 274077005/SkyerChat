//
//  UserCenterHeaderTableViewCell.m
//  SkyerChat
//
//  Created by admin on 2018/10/11.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "UserCenterHeaderTableViewCell.h"
#import "UIView+skBoard.h"

@implementation UserCenterHeaderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.btnHeadImage skSetBoardRadius:45 Width:2 andBorderColor:[UIColor whiteColor]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
