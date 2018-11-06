//
//  skLookoverTableViewCell.m
//  SkyerChat
//
//  Created by admin on 2018/11/6.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import "skLookoverTableViewCell.h"

@implementation skLookoverTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.imageHeader skSetBoardRadius:20 Width:0 andBorderColor:nil];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
