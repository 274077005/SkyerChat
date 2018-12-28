//
//  CombineGroupInfoView.h
//  SkyerChat
//
//  Created by skyer on 2018/12/28.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CombineGroupInfoView : UIView
@property (weak, nonatomic) IBOutlet UIButton *btnHeader;
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtDate;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;

@end

NS_ASSUME_NONNULL_END
