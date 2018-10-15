//
//  skUserCenterViewController.m
//  SkyerChat
//
//  Created by admin on 2018/10/10.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "skUserCenterViewController.h"
#import "UserCenterHeaderTableViewCell.h"
#import "UserCenterOrderTableViewCell.h"
#import "UserCenterTitleTableViewCell.h"
#import <SDWebImage/UIButton+WebCache.h>
#import "skChangeUserinfoViewController.h"

@interface skUserCenterViewController ()
@property (nonatomic,strong) UserCenterHeaderTableViewCell *cellHeader;
@end

@implementation skUserCenterViewController

-(UserCenterHeaderTableViewCell *)cellHeader{
    if (nil==_cellHeader) {
        _cellHeader=skXibView(@"UserCenterHeaderTableViewCell");
        @weakify(self)
        [[_cellHeader.btnHeadImage rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            skChangeUserinfoViewController *view=[[skChangeUserinfoViewController alloc] init];
            [self.navigationController pushViewController:view animated:YES];
        }];
    }
    return _cellHeader;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addTableView];
}
-(void)addTableView{
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor=KcolorBackground;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_equalTo(0);
    }];
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, -500, skScreenWidth, 500)];
    [view setBackgroundColor:KcolorMain];
    [self.tableView addSubview:view];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getUser];
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
    return 4;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
        {
            return 2;
        }
            break;
        case 1:
        {
            return 3;
        }
            break;
        case 2:
        {
            return 1;
        }
            break;
        case 3:
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
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    return 160;
                }
                    break;
                case 1:
                {
                    return 100;
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case 1:
        {
            return 50;
        }
            break;
        case 2:
        {
            return 50;
        }
            break;
        case 3:
        {
            return 50;
        }
            break;
            
            
        default:
            break;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0;
    }
    return 10;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, skScreenWidth, 10)];
    lab.backgroundColor=KcolorBackground;
    return lab;
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    NSLog(@"用户头像=%@",skUser.portrait);
                    [self.cellHeader.btnHeadImage sd_setImageWithURL:[NSURL URLWithString:skUser.portrait] forState:(UIControlStateNormal) placeholderImage:[UIImage imageNamed:@"touxian"]];
                    return self.cellHeader;
                }
                    break;
                case 1:
                {
                    static NSString *cellIdentifier = @"UserCenterOrderTableViewCell";
                    
                    UserCenterOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                    
                    if (cell == nil) {
                        cell = skXibView(@"UserCenterOrderTableViewCell");
                    }
                    cell.labOrderCount.text=[NSString stringWithFormat:@"%ld",skUser.orderNum];
                    cell.labOrderCount.text=[NSString stringWithFormat:@"%ld",skUser.coins];
                    return cell;
                }
                    break;
                    
                default:
                    break;
            }
            
        }
            break;
        case 1:
        {
            static NSString *cellIdentifier = @"UserCenterTitleTableViewCell";
            
            UserCenterTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
            if (cell == nil) {
                cell = skXibView(@"UserCenterTitleTableViewCell");
            }
            
            switch (indexPath.row) {
                case 0:
                {
                    cell.labTitle.text=@"信息设置";
                }
                    break;
                case 1:
                {
                    cell.labTitle.text=@"信息安全";
                }
                    break;
                case 2:
                {
                    cell.labTitle.text=@"我的地址";
                }
                    break;
                    
                default:
                    break;
            }
            return cell;
        }
            break;
        case 2:
        {
            static NSString *cellIdentifier = @"UserCenterTitleTableViewCell";
            
            UserCenterTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
            if (cell == nil) {
                cell = skXibView(@"UserCenterTitleTableViewCell");
            }
            cell.labTitle.text=@"邀请用户";
            return cell;
        }
            break;
        case 3:
        {
            static NSString *cellIdentifier = @"UserCenterTitleTableViewCell";
            
            UserCenterTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
            if (cell == nil) {
                cell = skXibView(@"UserCenterTitleTableViewCell");
            }
            cell.labTitle.text=@"邀请用户";
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



-(void)getUser{
    ///intf/bizUser/sendRegister
    NSDictionary *dic=@{@"userNo":skUser.userNo
                        };
    
    [skAfTool SKPOST:skUrl(@"/intf/bizUser/getUser") pubParame:skPubParType(0) busParame:[dic skDicToJson:dic] showHUD:NO showErrMsg:NO success:^(skResponeModel *  _Nullable responseObject) {
        
        if (responseObject.returnCode==0) {
            [UserModel mj_objectWithKeyValues:responseObject.data];
            [self.tableView reloadData];
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}
@end
