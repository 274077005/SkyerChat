//
//  skLoginViewController.m
//  SkyerChat
//
//  Created by admin on 2018/9/21.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "skLoginViewController.h"
#import "LoginView.h"
#import "skRegisterViewController.h"

@interface skLoginViewController ()
@property (nonatomic,strong) LoginView *viewLogin;
@end

@implementation skLoginViewController

- (LoginView *)viewLogin{
    if (nil==_viewLogin) {
        _viewLogin=skXibView(@"LoginView");
    }
    return _viewLogin;
}

-(void)racAction{
    @weakify(self)
    [[_viewLogin.btnLogin rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)//登录
    }];
    [[_viewLogin.btnForgetPassword rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)//忘记密码
    }];
    [[_viewLogin.btnRegister rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)//注册
        skRegisterViewController *view=[[skRegisterViewController alloc] init];
        [self.navigationController pushViewController:view animated:YES];
    }];
    [[_viewLogin.btnWechat rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)//微信
    }];
    [[_viewLogin.btnQQ rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)//QQ
    }];
    [[_viewLogin.btnWeibo rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)//微博
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.viewLogin];
    [self racAction];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
