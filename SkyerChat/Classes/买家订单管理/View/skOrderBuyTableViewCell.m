//
//  skOrderBuyTableViewCell.m
//  SkyerChat
//
//  Created by skyer on 2019/1/13.
//  Copyright © 2019 www.skyer.com. All rights reserved.
//

#import "skOrderBuyTableViewCell.h"

@implementation skOrderBuyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.btnPay skSetBoardRadius:5 Width:1 andBorderColor:[UIColor redColor]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
