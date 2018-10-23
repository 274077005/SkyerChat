//
//  skAddressBookModel.m
//  SkyerChat
//
//  Created by admin on 2018/10/15.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "skAddressBookModel.h"


@implementation skAddressBookModel
//设置导航栏
- (void)setBarButtonItem:(UINavigationItem*)navigationItem
{
    self.viewTitle= skXibView(@"AddressBookNavTitleView");
    
    navigationItem.titleView =self.viewTitle;
    
}
@end
