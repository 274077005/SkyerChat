//
//  skUserPrivacyViewController.m
//  SkyerChat
//
//  Created by skyer on 2019/1/28.
//  Copyright © 2019 www.skyer.com. All rights reserved.
//

#import "skUserPrivacyViewController.h"
#import "skUserPrivacyViews.h"

@interface skUserPrivacyViewController ()
@property (nonatomic,strong) skUserPrivacyViews *viewPrivacy;
@end

@implementation skUserPrivacyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.viewPrivacy=skXibView(@"skUserPrivacyViews");
    [self.view addSubview:self.viewPrivacy];
    [self.viewPrivacy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
