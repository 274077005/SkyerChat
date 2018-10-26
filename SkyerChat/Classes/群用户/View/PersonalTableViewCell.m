//
//  PersonalTableViewCell.m
//  SkyerChat
//
//  Created by admin on 2018/10/24.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import "PersonalTableViewCell.h"
#import "UIView+skBoard.h"

@implementation PersonalTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.imageTitle skSetBoardRadius:4 Width:0 andBorderColor:[UIColor clearColor]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
