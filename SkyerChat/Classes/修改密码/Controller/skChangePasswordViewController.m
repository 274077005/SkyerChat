//
//  skChangePasswordViewController.m
//  SkyerChat
//
//  Created by admin on 2018/10/22.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import "skChangePasswordViewController.h"
#import "skChangePasswordTableViewCell.h"
#import "skChangePwdCodeTableViewCell.h"
#import "skChangePasswordModel.h"

@interface skChangePasswordViewController ()
@property (nonatomic,strong) skChangePasswordModel *model;
@property (nonatomic,strong) skChangePwdCodeTableViewCell *cellCode;
@end

@implementation skChangePasswordViewController


- (skChangePwdCodeTableViewCell *)cellCode{
    if (nil==_cellCode) {
        _cellCode=skXibView(@"skChangePwdCodeTableViewCell");
        @weakify(self)
        [[_cellCode.btnCode rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [self sendRegister];
        }];
    }
    return _cellCode;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"重置密码";
    [self addTableView];
    [[[self skCreatBtn:@"确定" btnTitleOrImage:(btntypeTitle) btnLeftOrRight:(btnStateRight)] rac_signalForControlEvents:(UIControlEventTouchUpOutside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self resetPasswd];
    }];
}
-(void)addTableView{
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor=KcolorBackground;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop);
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
#pragma mark - 代理方法

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    
    if (indexPath.row==1) {
        RAC(self.model,code) = self.cellCode.textCode.rac_textSignal;
        return self.cellCode;
    }else{
        static NSString *cellIdentifier = @"skChangePasswordTableViewCell";
        skChangePasswordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = skXibView(@"skChangePasswordTableViewCell");
            
        }
        switch (indexPath.row) {
            case 0:
            {
                cell.textTitle.placeholder=@"请输入手机号码";
                RAC(self.model,phone) = cell.textTitle.rac_textSignal;
            }
                break;
            case 2:
            {
                cell.textTitle.placeholder=@"请输入6-16位密码";
                RAC(self.model,pwd1) = cell.textTitle.rac_textSignal;
            }
                break;
            case 3:
            {
                cell.textTitle.placeholder=@"确认新密码";
                RAC(self.model,pwd2) = cell.textTitle.rac_textSignal;
            }
                break;
                
            default:
                break;
        }
        
        return cell;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - 重置密码
-(void)resetPasswd{
    if (![skClassMethod skValiMobile:self.model.phone]) {
        return;
    }
    
    
    
    ///intf/bizUser/sendRegister
    NSDictionary *dic=@{@"phoneNo":self.model.phone,
                        @"passwd":[self.model.pwd1 MD5],
                        @"smsCode":self.model.code
                        };
    
    skModelNet.phoneNo=self.model.phone;
    skModelNet.passwd=[self.model.pwd1 MD5];
    skModelNet.smsCode=self.model.code;
    
    [skAfTool SKPOST:skUrl(@"/intf/bizUser/resetPasswd") pubParame:skPubParType(portNameResetPasswd) busParame:[dic skDicToJson:dic] showHUD:YES showErrMsg:YES success:^(skResponeModel *  _Nullable responseObject) {
        
        if (responseObject.returnCode==0) {
            [SkToast SkToastShow:@"重置密码成功" withHight:300];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [skRootViewController skRootLoginViewController];
            });
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}

-(void)sendRegister{
    ///intf/bizUser/sendRegister
    NSDictionary *dic=@{@"phoneNo":self.model.phone,
                        @"type":@2
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
            [self.cellCode.labCode setText:[NSString stringWithFormat:@"%d秒后尝试",index]];
        }else{
            [self.cellCode.labCode setText:@"获取验证码"];
            self.model.isGetCode=YES;
        }
    }];
}

@end
