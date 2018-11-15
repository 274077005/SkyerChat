//
//  groupImageView.h
//  SkyerChat
//
//  Created by admin on 2018/11/15.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface groupImageView : UIView
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UIButton *btnMore;
@property (weak, nonatomic) IBOutlet UIView *viewImages;
@property (weak, nonatomic) IBOutlet UIView *iamgeTitle;
@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnBuy;

@end

NS_ASSUME_NONNULL_END
