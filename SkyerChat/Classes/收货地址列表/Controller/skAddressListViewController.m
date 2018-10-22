//
//  skAddressListViewController.m
//  SkyerChat
//
//  Created by admin on 2018/10/19.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import "skAddressListViewController.h"
#import "AddressListTableViewCell.h"
#import "skAddressModel.h"
#import "skAddAddressTableViewCell.h"
#import "skAddressViewController.h"

@interface skAddressListViewController ()
@property (nonatomic,strong) NSArray *arrList;
@end

@implementation skAddressListViewController


-(void)addTableView{
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor=KcolorBackground;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop);
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"收货地址";
    [self addTableView];
}
-(void)viewWillAppear:(BOOL)animated{
    [self receiverAddress];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)receiverAddress{
    ///intf/bizUser/sendRegister
    NSDictionary *dic=@{@"page":@"",
                        @"rows":@"100"
                        };
    
    
    [skAfTool SKPOST:skUrl(@"/intf/bizReceiverAddress/list") pubParame:skPubParType(0) busParame:[dic skDicToJson:dic] showHUD:YES showErrMsg:YES success:^(skResponeModel *  _Nullable responseObject) {
        
        if (responseObject.returnCode==0) {
            
            skResponeList *modelList=[skResponeList mj_objectWithKeyValues:responseObject.data];
            
            self.arrList=[skAddressModel mj_objectArrayWithKeyValuesArray:modelList.list];
            
            [self.tableView reloadData];
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}

#pragma mark - 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
        {
            return self.arrList.count;
        }
            break;
        case 1:
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
            static NSString *cellIdentifier = @"AddressListTableViewCell";
            AddressListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = skXibView(@"AddressListTableViewCell");
            }
            skAddressModel *model=self.arrList[indexPath.row];
            cell.labAddressName.text=model.addressName;
            cell.labAddress.text=model.address;
            cell.labSelect.hidden=!model.isDefault;
            return cell;
        }
            break;
        case 1:
        {
            static NSString *cellIdentifier = @"skAddAddressTableViewCell";
            skAddAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = skXibView(@"skAddAddressTableViewCell");
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
            skAddressViewController *view=[[skAddressViewController alloc] init];
            view.model=self.arrList[indexPath.row];
            [self.navigationController pushViewController:view animated:YES];
        }
            break;
        case 1:
        {
            skAddressViewController *view=[[skAddressViewController alloc] init];
            [self.navigationController pushViewController:view animated:YES];
        }
            break;
            
            
        default:
            break;
    }
}

@end
