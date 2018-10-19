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
        
    }
    return _addModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"收货地址";
    [self addTableView];
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
                    cell.txtTitle.text=self.model.receiver;
                    
                    RAC(self.addModel,receiver)=cell.txtTitle.rac_textSignal;
                    
                }
                    break;
                case 1:
                {
                    cell.txtTitle.placeholder=@"手机号码";
                    cell.txtTitle.text=self.model.phone;
                    
                    RAC(self.addModel,phone)=cell.txtTitle.rac_textSignal;
                }
                    break;
                case 2:
                {
                    cell.txtTitle.placeholder=@"邮编地址";
                    cell.txtTitle.text=self.model.address;
                    
                    RAC(self.addModel,district)=cell.txtTitle.rac_textSignal;
                }
                    break;
                case 3:
                {
                    cell.txtTitle.placeholder=@"我的地址";
                    cell.txtTitle.text=self.model.addressName;
                    RAC(self.addModel,addressName)=cell.txtTitle.rac_textSignal;
                }
                    break;
                case 4:
                {
                    cell.txtTitle.placeholder=@"我的省份";
                    cell.txtTitle.text=self.model.district;
                    RAC(self.addModel,district)=cell.txtTitle.rac_textSignal;
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
    
}

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
            
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}

@end
