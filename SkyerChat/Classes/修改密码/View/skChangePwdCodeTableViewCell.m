//
//  skChangePwdCodeTableViewCell.m
//  SkyerChat
//
//  Created by admin on 2018/10/22.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import "skChangePwdCodeTableViewCell.h"
#import "UIView+skBoard.h"

@implementation skChangePwdCodeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.labCode skSetBoardRadius:5 Width:0 andBorderColor:[UIColor clearColor]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
