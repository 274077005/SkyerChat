//
//  skGroupTitleTableViewCell.m
//  SkyerChat
//
//  Created by admin on 2018/11/2.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import "skGroupTitleTableViewCell.h"

@implementation skGroupTitleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.imageHeader skSetBoardRadius:20 Width:0 andBorderColor:[UIColor redColor]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
