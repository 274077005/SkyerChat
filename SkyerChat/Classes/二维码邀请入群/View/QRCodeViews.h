//
//  QRCodeViews.h
//  SkyerChat
//
//  Created by admin on 2018/11/13.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QRCodeViews : UIView
@property (weak, nonatomic) IBOutlet UIImageView *imageGroupHeader;
@property (weak, nonatomic) IBOutlet UILabel *labGroupName;
@property (weak, nonatomic) IBOutlet UIImageView *imageGroupQR;

@end

NS_ASSUME_NONNULL_END
