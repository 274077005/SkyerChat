//
//  skRegisterViewController.m
//  SkyerChat
//
//  Created by admin on 2018/10/9.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "skRegisterViewController.h"
#import "RegisterView.h"
#import "modelRegister.h"
#import "SFHFKeychainUtils.h"
#import "skRootViewController.h"
#import "UserModel.h"
#import "skUserPrivacyViewController.h"

@interface skRegisterViewController ()
@property (nonatomic,strong) RegisterView *viewRegister;
@property (nonatomic,strong) modelRegister *model;
@end

@implementation skRegisterViewController

-(RegisterView *)viewRegister{
    if (nil==_viewRegister) {
        _viewRegister=skXibView(@"RegisterView");
        [self.view addSubview:_viewRegister];
        [_viewRegister mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_topLayoutGuide);
            make.bottom.mas_equalTo(self.mas_bottomLayoutGuide);
            make.right.left.mas_equalTo(0);
        }];
    }
    return _viewRegister;
}

-(modelRegister *)model{
    if (nil==_model) {
        _model=[[modelRegister alloc] init];
    }
    return _model;
}

-(void)racAction{
    RAC(self.model,phone) = self.viewRegister.txtPhone.rac_textSignal;
    RAC(self.model,code) = self.viewRegister.txtCode.rac_textSignal;
    RAC(self.model,password) = self.viewRegister.txtPassword.rac_textSignal;
    RAC(self.model,passwordAgain) = self.viewRegister.txtPasswordSure.rac_textSignal;
    
    
    
    @weakify(self)
    [RACObserve(self.model, isGetCode) subscribeNext:^(id  _Nullable x) {
        
        NSInteger xx=[x integerValue];
        
        if (xx==1) {
            [self.viewRegister.labGetCode setTextColor:KcolorButton];
            [self.viewRegister.btnGetCode setEnabled:YES];
        }else{
            [self.viewRegister.labGetCode setTextColor:KcolorTextLight];
            [self.viewRegister.btnGetCode setEnabled:NO];
        }
        
    }];
    
    [RACObserve(self.model, phone) subscribeNext:^(id  _Nullable x) {
        NSLog(@"phone=%@",x);
        self.model.isGetCode=[skClassMethod skValiMobile:x];
    }];
    
    [RACObserve(self.model, isAgree) subscribeNext:^(id  _Nullable x) {
        NSLog(@"isAgree=%@",x);
        if ([x isEqualToString:@"1"]) {
            [self.viewRegister.btnSelect setImage:[UIImage imageNamed:@"勾-已选"] forState:(UIControlStateNormal)];
        }else{
            [self.viewRegister.btnSelect setImage:[UIImage imageNamed:@"勾-未选"] forState:(UIControlStateNormal)];
        }
    }];
    
    
    
    [self.model.btnEnableSignal subscribeNext:^(NSString*  _Nullable x) {
        @strongify(self)//验证点击按钮有效
        UIButton *btn=self.viewRegister.btnReigster;
        NSLog(@"xxx=%@",x);
        btn.enabled=[x boolValue];
        
        if ([x boolValue]) {
            [btn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        }else{
            [btn setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
        }
        
    }];
    
    [[_viewRegister.btnReigster rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)//注册
        [self userRegister];
    }];
    [[_viewRegister.btnXieyi rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)//协议
        skUserPrivacyViewController *view=[[skUserPrivacyViewController alloc] init];
        
        [self.navigationController pushViewController:view animated:YES];
    }];
    [[_viewRegister.btnSelect rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)//同意协议
        self.model.isAgree=[self.model.isAgree isEqualToString:@"1"]?@"0":@"1";
    }];
    [[_viewRegister.btnGetCode rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)//获取验证码
        
        [self sendRegister];
        
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"用户注册";
    [self viewRegister];
    [self racAction];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)sendRegister{
    ///intf/bizUser/sendRegister
    NSDictionary *dic=@{@"phoneNo":_model.phone,
                        @"type":@1
                        };
    
    skModelNet.phoneNo=_model.phone;
    
    [skAfTool SKPOST:skUrl(@"/intf/bizUser/sendRegister") pubParame:skPubParType(portNameSendRegister) busParame:[dic skDicToJson:dic] showHUD:YES showErrMsg:YES success:^(skResponeModel *  _Nullable responseObject) {
        
        if (responseObject.returnCode==0) {
            [self sendSuccess];
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}

-(void)sendSuccess{
    __block int index=60;
    self.model.isGetCode=NO;
    @weakify(self)
    [[[RACSignal interval:1 onScheduler:[RACScheduler mainThreadScheduler]] take:index] subscribeNext:^(id x) {
        @strongify(self)
        index --;
        if (index>0) {
            [self.viewRegister.labGetCode setText:[NSString stringWithFormat:@"%d秒后尝试",index]];
        }else{
            [self.viewRegister.labGetCode setText:@"获取验证码"];
            self.model.isGetCode=YES;
        }
    }];
}

/**
 用户注册
 */
-(void)userRegister{
    NSString *pwd=[NSString stringWithFormat:@"%@%@",_model.password,skSaltMd5String];
    
    NSDictionary *dic=@{@"phoneNo":_model.phone,
                        @"passwd":[pwd MD5],
                        @"smsCode":_model.code
                        };
    
    skModelNet.phoneNo=_model.phone;
    skModelNet.passwd=[pwd MD5];
    skModelNet.smsCode=_model.code;
    
    
    [skAfTool SKPOST:skUrl(@"/intf/bizUser/register") pubParame:skPubParType(portNameResetPasswd) busParame:[dic skDicToJson:dic] showHUD:YES showErrMsg:YES success:^(skResponeModel *  _Nullable responseObject) {
        
        if (responseObject.returnCode==0) {
            [UserModel mj_objectWithKeyValues:responseObject.data];
            
            [SFHFKeychainUtils storeUsername:skLoginUserName andPassword:self.model.phone forServiceName:skLoginUserName updateExisting:YES error:nil];
            
            [SFHFKeychainUtils storeUsername:skLoginUserPWD andPassword:self.model.password forServiceName:skLoginUserPWD updateExisting:YES error:nil];
            skUser.isLogin=YES;
            
            [skRootViewController skRootTabarViewController];
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}
@end
