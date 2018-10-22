//
//  AddressListTableViewCell.h
//  SkyerChat
//
//  Created by admin on 2018/10/19.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddressListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labAddressName;
@property (weak, nonatomic) IBOutlet UILabel *labAddress;
@property (weak, nonatomic) IBOutlet UILabel *labSelect;

@end

NS_ASSUME_NONNULL_END
