//
//  skLoginViewController.m
//  SkyerChat
//
//  Created by admin on 2018/9/21.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "skLoginViewController.h"
#import "LoginView.h"
#import "UserLogin.h"
#import "skRegisterViewController.h"
#import "skRootViewController.h"
#import "skChangePasswordViewController.h"

@interface skLoginViewController ()
@property (nonatomic,strong) LoginView *viewLogin;
@property (nonatomic,strong) UserLogin *userLogin;
@end

@implementation skLoginViewController

- (LoginView *)viewLogin{
    if (nil==_viewLogin) {
        _viewLogin=skXibView(@"LoginView");
    }
    return _viewLogin;
}
-(UserLogin *)userLogin{
    if (nil==_userLogin) {
        _userLogin=[[UserLogin alloc] init];
    }
    return _userLogin;
}

-(void)racAction{
    RAC(self.userLogin,loginPhone)=self.viewLogin.txtPhone.rac_textSignal;
    RAC(self.userLogin,loginPwd)=self.viewLogin.txtPassword.rac_textSignal;
    
    @weakify(self)
    [[_viewLogin.btnLogin rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)//登录
        [self userLoginAction];
    }];
    [[_viewLogin.btnForgetPassword rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)//忘记密码
        skChangePasswordViewController *view=[[skChangePasswordViewController alloc] init];
        [self.navigationController pushViewController:view animated:YES];
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
    
    [self.userLogin.btnEnableSignal subscribeNext:^(NSString*  _Nullable x) {
        @strongify(self)//登录按钮验证
        NSLog(@"x==%@",x);
        UIButton *btn=self.viewLogin.btnLogin;
        btn.enabled=[x boolValue];

        if ([x boolValue]) {
            [btn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        }else{
            [btn setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
        }
    }];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.viewLogin];
    [self racAction];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self rememberUser];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar setBarTintColor:KcolorMain];
}
#pragma mark - 获取原始密码
-(void)rememberUser{
    NSString *userName=[SFHFKeychainUtils getPasswordForUsername:skLoginUserName andServiceName:skLoginUserName error:nil];
    NSString *userPWD=[SFHFKeychainUtils getPasswordForUsername:skLoginUserPWD andServiceName:skLoginUserPWD error:nil];
    self.viewLogin.txtPhone.text=userName;
    self.viewLogin.txtPassword.text=userPWD;
    self.userLogin.loginPhone=userName;
    self.userLogin.loginPwd=userPWD;
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
-(void)userLoginAction{
    ///intf/bizUser/sendRegister
    NSString *passwd=[NSString stringWithFormat:@"%@%@",_userLogin.loginPwd,skSaltMd5String];
    
    NSDictionary *dic=@{@"phoneNo":_userLogin.loginPhone,
                        @"passwd":[passwd MD5]
                        };
    
    skModelNet.phoneNo=_userLogin.loginPhone;
    skModelNet.passwd=[passwd MD5];
    
    [skAfTool SKPOST:skUrl(@"/intf/bizUser/login") pubParame:skPubParType(portNameLogin) busParame:[dic skDicToJson:dic] showHUD:YES showErrMsg:YES success:^(skResponeModel *  _Nullable responseObject) {
        
        if (responseObject.returnCode==0) {
            [UserModel mj_objectWithKeyValues:responseObject.data];
            
            [SFHFKeychainUtils storeUsername:skLoginUserName andPassword:self.userLogin.loginPhone forServiceName:skLoginUserName updateExisting:YES error:nil];
            
            [SFHFKeychainUtils storeUsername:skLoginUserPWD andPassword:self.userLogin.loginPwd forServiceName:skLoginUserPWD updateExisting:YES error:nil];
            
            skUser.isLogin=YES;
            
            [[RongSDKUsed shareInstance] skRongConnectWithToken:skUser.token success:^(NSString *userId) {
                
            } error:^(RCConnectErrorCode status) {
                
            } tokenIncorrect:^{
                
            }];
            
            [skRootViewController skRootTabarViewController];
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}
@end
