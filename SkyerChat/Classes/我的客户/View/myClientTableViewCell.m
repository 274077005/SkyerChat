//
//  myClientTableViewCell.m
//  SkyerChat
//
//  Created by admin on 2018/10/25.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import "myClientTableViewCell.h"
#import "UIView+skBoard.h"

@implementation myClientTableViewCell

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
