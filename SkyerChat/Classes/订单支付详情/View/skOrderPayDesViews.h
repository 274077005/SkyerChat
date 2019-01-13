//
//  skOrderPayDesViews.h
//  SkyerChat
//
//  Created by skyer on 2019/1/13.
//  Copyright © 2019 www.skyer.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface skOrderPayDesViews : UIView
@property (weak, nonatomic) IBOutlet UILabel *labState;
@property (weak, nonatomic) IBOutlet UIView *viewYuan;
@property (weak, nonatomic) IBOutlet UILabel *labNameBay;
@property (weak, nonatomic) IBOutlet UILabel *labPhone;
@property (weak, nonatomic) IBOutlet UILabel *labAddress;
@property (weak, nonatomic) IBOutlet UILabel *labGroupName;
@property (weak, nonatomic) IBOutlet UIImageView *imageShop;
@property (weak, nonatomic) IBOutlet UILabel *labShopName;

@property (weak, nonatomic) IBOutlet UILabel *labTotalMeneyCount;
@property (weak, nonatomic) IBOutlet UILabel *labReadPay;
@property (weak, nonatomic) IBOutlet UILabel *labTimeBay;
@property (weak, nonatomic) IBOutlet UILabel *labTimePay;
@property (weak, nonatomic) IBOutlet UILabel *labOrderNo;

@property (weak, nonatomic) IBOutlet UIButton *btnPay;
@property (weak, nonatomic) IBOutlet UIButton *btnUplong;

@property (weak, nonatomic) IBOutlet UIButton *btnCanle;


@end

NS_ASSUME_NONNULL_END
