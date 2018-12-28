//
//  skActivityDesViewController.m
//  SkyerChat
//
//  Created by admin on 2018/11/14.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import "skActivityDesViewController.h"
#import "ActivityDesViews.h"
#import "ActivityHeaderTableViewCell.h"
#import "goodsDecModel.h"
#import "SDCycleScrollView.h"
#import "ActivityTitleTableViewCell.h"
#import "activityOtherTableViewCell.h"
#import "skSingleChatViewController.h"
#import "MyActivictViewsTableViewCell.h"

@interface skActivityDesViewController ()<SDCycleScrollViewDelegate>
@property (nonatomic,strong) ActivityDesViews *viewActivity;
@property (nonatomic,strong) goodsDecModel *model;
@property (nonatomic,strong) SDCycleScrollView *viewCycle;
@end

@implementation skActivityDesViewController

- (SDCycleScrollView *)viewCycle{
    if (nil==_viewCycle) {
        _viewCycle = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, skScreenWidth, 150) delegate:self placeholderImage:[UIImage imageNamed:@""]];
        
    }
    return _viewCycle;
}
- (ActivityDesViews *)viewActivity{
    if (nil==_viewActivity) {
        
        _viewActivity=skXibView(@"ActivityDesViews");
        _viewActivity.frame=self.view.bounds;
        [self.view addSubview:_viewActivity];
        @weakify(self)
        [[_viewActivity.btnChat rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            skSingleChatViewController *view=[[skSingleChatViewController alloc] initWithConversationType:(ConversationType_PRIVATE) targetId:self.model.userNo];
            view.title=self.model.nickName?self.model.nickName:self.model.userNo;
            [self.navigationController pushViewController:view animated:YES];
        }];
    }
    return _viewActivity;
}

-(void)addTableView{
    [self.viewActivity.viewTableViewContain addSubview:self.tableView];
    self.tableView.backgroundColor=KcolorBackground;
//    //cell预估高度,设一个接近cell高度的值
//    self.tableView.estimatedRowHeight = 100;//也可以省略不设置,
//
//    //设置rowHeight为UITableViewAutomaticDimension,
//    self.tableView.rowHeight = UITableViewAutomaticDimension;//可以省略不设置
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_equalTo(0);
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addTableView];
    [self  bizGoodsGet];
    self.title=@"活动详情";
}
//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = YES;
//}
//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    self.navigationController.navigationBarHidden = NO;
//}
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
    if ([self.modelOther.userNo isEqualToString:skUser.userNo]) {
        return 4;
    }else{
        return 3;
    }
    return 0;
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
            return 1;
        }
            break;
        case 2:
        {
            return 2;
        }
            break;
        case 3://自家的
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
            return 150;
        }
            break;
        case 1:
        {
            return 150;
        }
            break;
        case 2:
        {
            return 50;
        }
            break;
        case 3:
        {
            return 120;
        }
            break;

        default:
            break;
    }
    return 10;

}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:
        {
            static NSString *cellIdentifier = @"ActivityHeaderTableViewCell";
            ActivityHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = skXibView(@"ActivityHeaderTableViewCell");
            }
            [cell.contentView addSubview:self.viewCycle];
            
            self.viewCycle.imageURLStringsGroup = self.model.goodsPics;
            
            return cell;
        }
            break;
        case 1:
        {
            static NSString *cellIdentifier = @"ActivityTitleTableViewCell";
            ActivityTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = skXibView(@"ActivityTitleTableViewCell");
            }
            cell.labMoney.text=[NSString stringWithFormat:@"%ld",self.model.goodsPrice];
            cell.labDes.text=self.model.goodsDesc;
            return cell;
        }
            break;
        case 2:
        {
            static NSString *cellIdentifier = @"activityOtherTableViewCell";
            activityOtherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = skXibView(@"activityOtherTableViewCell");
            }
            
            switch (indexPath.row) {
                case 0:
                {
                    cell.labTitle.text=@"商家";
                    cell.labName.text=self.model.groupName;
                }
                    break;
                case 1:
                {
                    cell.labTitle.text=@"送至";
                    cell.labName.text=@"我特么的知道这是啥?";
                }
                    break;
                    
                default:
                    break;
            }
            return cell;
        }
        case 3:
        {
            static NSString *cellIdentifier = @"MyActivictViewsTableViewCell";
            MyActivictViewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = skXibView(@"MyActivictViewsTableViewCell");
                @weakify(self)
                [[cell rac_signalForSelector:@selector(skClick:)] subscribeNext:^(RACTuple * _Nullable x) {
                    @strongify(self)
                    NSIndexPath *indexPath=x[0];
                    switch (indexPath.row) {
                        case 0:
                        {
                            
                        }
                            break;
                        case 1:
                        {
                            [self bizGoodsDelete];
                        }
                            break;
                        case 2:
                        {
                            [self bizGoodsUp];
                        }
                            break;
                        case 3:
                        {
                            [self bizGoodsDown];
                        }
                            break;
                            
                        default:
                            break;
                    }
                }];
            }
            [cell.collectionView reloadData];
            return cell;
        }
            break;
            
        default:
            break;
    }
    static NSString *cellIdentifier = @"ActivityHeaderTableViewCell";
    ActivityHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = skXibView(@"ActivityHeaderTableViewCell");
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 10;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark - 获取商品详情
-(void)bizGoodsGet{
    ///intf/bizUser/sendRegister
    NSDictionary *dic=@{@"goodsNo":self.modelOther.goodsNo
                        };
    
    
    [skAfTool SKPOST:skUrl(@"/intf/bizGoods/get") pubParame:skPubParType(0) busParame:[dic skDicToJson:dic] showHUD:YES showErrMsg:YES success:^(skResponeModel *  _Nullable responseObject) {
        
        if (responseObject.returnCode==0) {
            self.model=[goodsDecModel mj_objectWithKeyValues:responseObject.data];
            [self.tableView reloadData];
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}
#pragma mark - 上架商品
-(void)bizGoodsUp{
    ///intf/bizUser/sendRegister
    NSDictionary *dic=@{@"goodsNo":self.model.goodsNo
                        };
    
    
    [skAfTool SKPOST:skUrl(@"/intf/bizGoods/up") pubParame:skPubParType(0) busParame:[dic skDicToJson:dic] showHUD:YES showErrMsg:YES success:^(skResponeModel *  _Nullable responseObject) {
        
        if (responseObject.returnCode==0) {
            [SkToast SkToastShow:@"上架成功" withHight:300];
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}
#pragma mark - 下架
-(void)bizGoodsDown{
    ///intf/bizUser/sendRegister
    NSDictionary *dic=@{@"goodsNo":self.model.goodsNo
                        };
    
    
    [skAfTool SKPOST:skUrl(@"/intf/bizGoods/down") pubParame:skPubParType(0) busParame:[dic skDicToJson:dic] showHUD:YES showErrMsg:YES success:^(skResponeModel *  _Nullable responseObject) {
        
        if (responseObject.returnCode==0) {
            [SkToast SkToastShow:@"下架成功" withHight:300];
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}
#pragma mark - 删除商品
-(void)bizGoodsDelete{
    ///intf/bizUser/sendRegister
    NSDictionary *dic=@{@"goodsNo":self.modelOther.goodsNo
                        };
    
    
    [skAfTool SKPOST:skUrl(@"/intf/bizGoods/delete") pubParame:skPubParType(0) busParame:[dic skDicToJson:dic] showHUD:YES showErrMsg:YES success:^(skResponeModel *  _Nullable responseObject) {
        
        if (responseObject.returnCode==0) {
            [SkToast SkToastShow:@"删除成功" withHight:300];
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}
@end
