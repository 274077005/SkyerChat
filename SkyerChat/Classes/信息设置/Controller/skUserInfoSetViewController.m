//
//  skUserInfoSetViewController.m
//  SkyerChat
//
//  Created by admin on 2018/10/18.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "skUserInfoSetViewController.h"
#import "UserinfoSetNewMessageTableViewCell.h"
#import "UserinfoSetTableViewCell.h"
#import "skUserinfoSetModel.h"

@interface skUserInfoSetViewController ()
@property (nonatomic,strong) UserinfoSetNewMessageTableViewCell *messageCell;
@property (nonatomic,strong) skUserinfoSetModel *model;
@end

@implementation skUserInfoSetViewController

- (UserinfoSetNewMessageTableViewCell *)messageCell{
    if (nil==_messageCell) {
        _messageCell=skXibView(@"UserinfoSetNewMessageTableViewCell");
        
        @weakify(self)
        [[_messageCell.btnChangMessageState rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [self changeUser:self.messageCell.btnChangMessageState.isOn workUnit:@"" monthIncome:@"" hobbies:@"" sign:@""];
        }];
    }
    return _messageCell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"用户信息设置";
    [self addTableView];
    [self getUser];
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
        {
            return 1;
        }
            break;
        case 1:
        {
            return 4;
        }
            break;
            
        default:
            break;
    }
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:
        {
            [self.messageCell.btnChangMessageState setOn:self.model.isNotify];
            return self.messageCell;
        }
            break;
        case 1:
        {
            static NSString *cellIdentifier = @"UserinfoSetTableViewCell";
            
            UserinfoSetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = skXibView(@"UserinfoSetTableViewCell");
            }
            
            switch (indexPath.row) {
                case 0:
                {
                    cell.labTitle.text=@"工作单位";
                    cell.labName.text=self.model.workUnit;
                }
                    break;
                case 1:
                {
                    cell.labTitle.text=@"月收入";
                    cell.labName.text=self.model.monthIncome;
                }
                    break;
                case 2:
                {
                    cell.labTitle.text=@"爱好";
                    cell.labName.text=self.model.hobbies;
                }
                    break;
                case 3:
                {
                    cell.labTitle.text=@"签名";
                    cell.labName.text=self.model.sign;
                }
                    break;
                    
                default:
                    break;
            }
            
            return cell;
        }
            break;
            
        default:
            break;
    }
    
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
            NSString *title;
            switch (indexPath.row) {
                case 0:
                {
//                    cell.labTitle.text=@"工作单位";
                    title=self.model.workUnit;
                }
                    break;
                case 1:
                {
//                    cell.labTitle.text=@"月收入";
                    title=self.model.monthIncome;
                }
                    break;
                case 2:
                {
//                    cell.labTitle.text=@"爱好";
                    title=self.model.hobbies;
                }
                    break;
                case 3:
                {
//                    cell.labTitle.text=@"签名";
                    title=self.model.sign;
                }
                    break;
                    
                default:
                    break;
            }
            
            [self showAlertView:title index:indexPath.row];
        }
            break;
            
        default:
            break;
    }
}

-(void)showAlertView:(NSString *)title index:(NSInteger)index{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"修改个人基础信息" message:nil preferredStyle:UIAlertControllerStyleAlert];
    //以下方法就可以实现在提示框中输入文本；
    
    //在AlertView中添加一个输入框
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
        textField.placeholder = @"请输入要修改的信息";
        textField.text=title;
        
    }];
    
    //添加一个确定按钮 并获取AlertView中的第一个输入框 将其文本赋值给BUTTON的title
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UITextField *envirnmentNameTextField = alertController.textFields.firstObject;
        
        NSString *title=envirnmentNameTextField.text;
        
        Boolean flag =self.messageCell.btnChangMessageState.isOn;
        
        switch (index) {
            case 0:
            {
                [self changeUser:flag workUnit:title monthIncome:self.model.monthIncome hobbies:self.model.hobbies sign:self.model.sign];
            }
                break;
            case 1:
            {
                [self changeUser:flag workUnit:self.model.workUnit monthIncome:title hobbies:self.model.hobbies sign:self.model.sign];
            }
                break;
            case 2:
            {
                [self changeUser:flag workUnit:self.model.workUnit monthIncome:self.model.monthIncome hobbies:title sign:self.model.sign];
            }
                break;
            case 3:
            {
                [self changeUser:flag workUnit:self.model.workUnit monthIncome:self.model.monthIncome hobbies:self.model.hobbies sign:title];
            }
                break;
                
            default:
                break;
        }
        
    }]];
    
    //添加一个取消按钮
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
    
    //present出AlertView
    [self presentViewController:alertController animated:true completion:nil];
}


-(void)changeUser:(Boolean)isNotify workUnit:(NSString *)workUnit monthIncome:(NSString *)monthIncome hobbies:(NSString *)hobbies sign:(NSString *)sign{
    ///intf/bizUser/sendRegister
    NSDictionary *dic=@{@"isNotify":[NSNumber numberWithBool:isNotify],
                        @"workUnit":workUnit,
                        @"monthIncome":monthIncome,
                        @"hobbies":hobbies,
                        @"sign":sign
                        };
    
    
    [skAfTool SKPOST:skUrl(@"/intf/bizUser/update") pubParame:skPubParType(portNameSendRegister) busParame:[dic skDicToJson:dic] showHUD:YES showErrMsg:YES success:^(skResponeModel *  _Nullable responseObject) {
        
        if (responseObject.returnCode==0) {
            [self getUser];
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}
-(void)getUser{
    ///intf/bizUser/sendRegister
    NSDictionary *dic=@{@"userNo":skUser.userNo};
    
    [skAfTool SKPOST:skUrl(@"/intf/bizUser/getUser") pubParame:skPubParType(portNameSendRegister) busParame:[dic skDicToJson:dic] showHUD:YES showErrMsg:YES success:^(skResponeModel *  _Nullable responseObject) {
        
        if (responseObject.returnCode==0) {
            self.model=[skUserinfoSetModel mj_objectWithKeyValues:responseObject.data];
            [self.tableView reloadData];
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}
@end
