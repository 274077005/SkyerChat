//
//  CombineCheckTableViewCell.m
//  SkyerChat
//
//  Created by admin on 2018/11/19.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import "CombineCheckTableViewCell.h"

@implementation CombineCheckTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.btnSure skSetBoardRadius:5 Width:0 andBorderColor:nil];
    [self.btnEnSure skSetBoardRadius:5 Width:1 andBorderColor:KcolorMain];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
