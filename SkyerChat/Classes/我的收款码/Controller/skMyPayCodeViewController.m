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
#import <SDWebImage/SDImageCache.h>

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
        _viewCode.btnSaveVX.hidden=!self.isShow;
        _viewCode.btnSaveZFB.hidden=!self.isShow;
        
        @weakify(self)
        [[_viewCode.btnSaveVX rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [self loadImageFinished:self.viewCode.imageVX.image];
            NSURL *url;
        
            url = [NSURL URLWithString:@"weixin://scanqrcode"];
            
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url];
            }
            

        }];
        
        [[_viewCode.btnSaveZFB rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [self loadImageFinished:self.viewCode.imageVX.image];
            NSURL * myURL_APP_A = [NSURL URLWithString:@"alipay://"];
            
            if ([[UIApplication sharedApplication] canOpenURL:myURL_APP_A]) {
                // 跳转扫一扫
                NSURL * url2 = [NSURL URLWithString:@"alipay://platformapi/startapp?saId=10000007"];
                [[UIApplication sharedApplication] openURL:url2];
            }
            
        }];
        
    }
    return _viewCode;
}
- (void)loadImageFinished:(UIImage *)image
{
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    
    NSLog(@"image = %@, error = %@, contextInfo = %@", image, error, contextInfo);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"我的收款码";
}
-(void)viewWillAppear:(BOOL)animated{
    [self.viewCode.imageVX sd_setImageWithURL:[NSURL URLWithString:skUser.wechatQrCodeUrl]];
    [self.viewCode.imageZFB sd_setImageWithURL:[NSURL URLWithString:skUser.alipayQrCodeUrl]];

    
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
