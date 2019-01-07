//
//  skSubmitOrderViews.h
//  SkyerChat
//
//  Created by skyer on 2019/1/7.
//  Copyright © 2019 www.skyer.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface skSubmitOrderViews : UIView
@property (weak, nonatomic) IBOutlet UIImageView *imageHeader;
@property (weak, nonatomic) IBOutlet UIView *viewContain;
@property (weak, nonatomic) IBOutlet UIButton *btnDissmiss;
@property (weak, nonatomic) IBOutlet UILabel *labPhone;

@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UILabel *labMeney;
@property (weak, nonatomic) IBOutlet UIButton *btnAdd;
@property (weak, nonatomic) IBOutlet UIButton *btnSub;
@property (weak, nonatomic) IBOutlet UILabel *labCount;
@property (weak, nonatomic) IBOutlet UILabel *labBayName;
@property (weak, nonatomic) IBOutlet UILabel *labBayAddress;
@property (weak, nonatomic) IBOutlet UITextField *txtMessage;
@property (weak, nonatomic) IBOutlet UILabel *labTotalMeney;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;

@end

NS_ASSUME_NONNULL_END
