//
//  skAddressViewController.m
//  SkyerChat
//
//  Created by admin on 2018/10/19.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import "skAddressViewController.h"
#import "AddressTableViewCell.h"
#import "AddressCenterTableViewCell.h"
#import "skAddressModel.h"
#import "AddAddressModel.h"

@interface skAddressViewController ()
@property (nonatomic,strong) AddAddressModel *addModel;
@end

@implementation skAddressViewController

- (AddAddressModel *)addModel{
    if (nil==_addModel) {
        
        _addModel=[[AddAddressModel alloc] init];
        _addModel.receiver=self.model.receiver;
        _addModel.phone=self.model.phone;
        _addModel.district=self.model.district;
        _addModel.address=self.model.address;
        _addModel.isDefault=self.model.isDefault;
        _addModel.addressName=self.model.addressName;
        
        
    }
    return _addModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"收货地址";
    [self addTableView];
    
    @weakify(self)
    
    
    NSString *title=self.model.raId?@"修改":@"添加";
    
    [[[self skCreatBtn:title btnTitleOrImage:(btntypeTitle) btnLeftOrRight:(btnStateRight)] rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        if (self.model.raId) {
            [self ReceiverAddressUpdata];
        }else{
            [self ReceiverAddressCreate];
        }
        
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.model.raId) {
        return 3;
    }else{
        return 2;
    }
    return 3;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
        {
            return  5;
        }
            break;
        case 1:
        {
            return 1;
        }
            break;
        case 2:
        {
            return 1;
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
            static NSString *cellIdentifier = @"AddressTableViewCell";
            
            AddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
            if (cell == nil) {
                cell = skXibView(@"AddressTableViewCell");
            }
            switch (indexPath.row) {
                case 0:
                {
                    cell.txtTitle.placeholder=@"真实姓名";
                    cell.txtTitle.text=self.addModel.receiver;
                    [[cell.txtTitle rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
                        self.addModel.receiver=x;
                    }];
                    
                }
                    break;
                case 1:
                {
                    cell.txtTitle.placeholder=@"手机号码";
                    cell.txtTitle.text=self.addModel.phone;
                    [[cell.txtTitle rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
                        self.addModel.phone=x;
                    }];
                }
                    break;
                case 2:
                {
                    cell.txtTitle.placeholder=@"详细地址";
                    cell.txtTitle.text=self.addModel.address;
                    [[cell.txtTitle rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
                        self.addModel.address=x;
                    }];
                }
                    break;
                case 3:
                {
                    cell.txtTitle.placeholder=@"地址名称";
                    cell.txtTitle.text=self.addModel.addressName;
                    [[cell.txtTitle rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
                        self.addModel.addressName=x;
                    }];
                }
                    break;
                case 4:
                {
                    cell.txtTitle.placeholder=@"我的省份";
                    cell.txtTitle.text=self.addModel.district;
                    [[cell.txtTitle rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
                        self.addModel.district=x;
                    }];
                }
                    break;
                    
                default:
                    break;
            }
            return cell;
        }
            break;
        case 1:
        {
            static NSString *cellIdentifier = @"AddressCenterTableViewCell";
            
            AddressCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
            if (cell == nil) {
                cell = skXibView(@"AddressCenterTableViewCell");
            }
            cell.labTitle.text=@"设为默认收货地址";
            if (self.addModel.isDefault) {
                [cell setAccessoryType:(UITableViewCellAccessoryCheckmark)];
            }else{
                [cell setAccessoryType:(UITableViewCellAccessoryNone)];
            }
            
            return cell;
        }
            break;
        case 2:
        {
            static NSString *cellIdentifier = @"AddressCenterTableViewCell";
            
            AddressCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
            if (cell == nil) {
                cell = skXibView(@"AddressCenterTableViewCell");
            }
            cell.labTitle.text=@"删除";
            [cell.labTitle setTextColor:[UIColor redColor]];
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
            self.addModel.isDefault=!self.addModel.isDefault;
            [self.tableView reloadData];
        }
            break;
        case 2://删除
        {
            if (self.model.raId) {
                UIAlertController *alertView=[UIAlertController alertControllerWithTitle:@"删除地址" message:@"是否确定删除该地址" preferredStyle:(UIAlertControllerStyleAlert)];
                UIAlertAction *action=[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
                UIAlertAction *action1=[UIAlertAction actionWithTitle:@"删除" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                    [self ReceiverAddressDelect];
                }];
                [alertView addAction:action];
                [alertView addAction:action1];
                [self presentViewController:alertView animated:YES completion:^{
                    
                }];
            }else{
                [self.navigationController popViewControllerAnimated:YES];
            }
            
        }
            break;
            
        default:
            break;
    }
}

#pragma - 删除
-(void)ReceiverAddressDelect{
    ///intf/bizUser/sendRegister
    NSDictionary *dic=@{@"raId":[NSNumber numberWithInteger:self.model.raId]
                        };
    
    [skAfTool SKPOST:skUrl(@"/intf/bizReceiverAddress/delete") pubParame:skPubParType(0) busParame:[dic skDicToJson:dic] showHUD:YES showErrMsg:YES success:^(skResponeModel *  _Nullable responseObject) {
        
        if (responseObject.returnCode==0) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}

#pragma - 添加地址
-(void)ReceiverAddressCreate{
    ///intf/bizUser/sendRegister
    NSDictionary *dic=@{@"receiver":self.addModel.receiver,
                        @"phone":self.addModel.phone,
                        @"district":self.addModel.district,
                        @"address":self.addModel.address,
                        @"isDefault":[NSNumber numberWithBool:self.addModel.isDefault],
                        @"addressName":self.addModel.addressName
                        };
    
    
    [skAfTool SKPOST:skUrl(@"/intf/bizReceiverAddress/create") pubParame:skPubParType(0) busParame:[dic skDicToJson:dic] showHUD:YES showErrMsg:YES success:^(skResponeModel *  _Nullable responseObject) {
        
        if (responseObject.returnCode==0) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}
#pragma - 修改地址
-(void)ReceiverAddressUpdata{
    ///intf/bizUser/sendRegister
    
    NSDictionary *dic=@{@"raId":[NSNumber numberWithInteger:self.model.raId],
                        @"receiver":self.addModel.receiver,
                        @"phone":self.addModel.phone,
                        @"district":self.addModel.district,
                        @"address":self.addModel.address,
                        @"isDefault":[NSNumber numberWithBool:self.addModel.isDefault],
                        @"addressName":self.addModel.addressName
                        };
    
    
    [skAfTool SKPOST:skUrl(@"/intf/bizReceiverAddress/update") pubParame:skPubParType(0) busParame:[dic skDicToJson:dic] showHUD:YES showErrMsg:YES success:^(skResponeModel *  _Nullable responseObject) {
        
        if (responseObject.returnCode==0) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}
@end
