//
//  skMyPayCodeViewController.m
//  SkyerChat
//
//  Created by skyer on 2019/1/11.
//  Copyright © 2019 www.skyer.com. All rights reserved.
//

#import "skMyPayCodeViewController.h"
#import "skMyPayCodeViews.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "skUserInfoSetViewController.h"
#import "UIView+skBoard.h"

@interface skMyPayCodeViewController ()
@property(nonatomic ,strong) skMyPayCodeViews *viewCode;
@end

@implementation skMyPayCodeViewController
- (skMyPayCodeViews *)viewCode{
    if (nil==_viewCode) {
        _viewCode=skXibView(@"skMyPayCodeViews");
        [self.view addSubview:_viewCode];
        [_viewCode mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.top.left.right.mas_equalTo(0);
        }];
        [_viewCode.viewVX skSetShadowWithColor:[UIColor grayColor] andSizeMake:CGSizeMake(0, 0) Radius:5];
        [_viewCode.viewZFB skSetShadowWithColor:[UIColor grayColor] andSizeMake:CGSizeMake(0, 0) Radius:5];
    }
    return _viewCode;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"我的收款码";
}
-(void)viewWillAppear:(BOOL)animated{
    
    if (skUser.alipayQrCodeUrl||skUser.wechatQrCodeUrl) {
        [self.viewCode.imageVX sd_setImageWithURL:[NSURL URLWithString:skUser.wechatQrCodeUrl]];
        [self.viewCode.imageZFB sd_setImageWithURL:[NSURL URLWithString:skUser.alipayQrCodeUrl]];
    }else{
        skUserInfoSetViewController *view=[[skUserInfoSetViewController alloc] init];
        [self.navigationController pushViewController:view animated:YES];
    }
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
