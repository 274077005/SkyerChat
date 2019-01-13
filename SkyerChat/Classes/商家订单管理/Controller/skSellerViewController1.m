//
//  skSellerViewController1.m
//  SkyerChat
//
//  Created by skyer on 2019/1/13.
//  Copyright © 2019 www.skyer.com. All rights reserved.
//

#import "skSellerViewController1.h"
#import "skOrderBuyTableViewCell.h"
#import "skOrderBuyModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface skSellerViewController1 ()
@property(nonatomic,assign) NSInteger page;
@property(nonatomic,strong) NSArray * arrList;
@end

@implementation skSellerViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addTableView];
    [self bizGoodsOrder];
    [self createRefreshHeaderViewWithBlock:^{
        self.page=0;
        [self bizGoodsOrder];
    }];
    [self createRefreshFooterViewWithBlock:^{
        self.page++;
        [self bizGoodsOrder];
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
    
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.arrList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, skScreenWidth, 5)];
    view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    return view;
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"skOrderListTableViewCell";
    skOrderBuyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = skXibView(@"skOrderBuyTableViewCell");
    }
    
    skOrderBuyModel *model=[self.arrList objectAtIndex:indexPath.section];
    //图片
    [cell.imageShop sd_setImageWithURL:[NSURL URLWithString:model.goodsPic]];
    //商品时间
    cell.labTime.text=model.orderTime;
    //支付状态
    NSString *state;
    switch (model.orderStatus) {
        case 0:
        {
            state=@"未支付";
        }
            break;
        case 1:
        {
            state=@"待确认";
        }
            break;
        case 2:
        {
            state=@"已支付";
        }
            break;
            
        default:
            break;
    }
    cell.labState.text=state;
    //商品名称
    cell.labShopName.text=model.goodsName;
    //商品数量
    cell.labCount.text=[NSString stringWithFormat:@"共%ld件商品",model.goodsAmount];
    
    //价格
    cell.labMeney.text=[NSString stringWithFormat:@"￥%ld",model.toPayMoney];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}

-(void)bizGoodsOrder{
    ///intf/bizUser/sendRegister
    NSDictionary *dic=@{@"isBuyer":[NSNumber numberWithBool:NO],
                        @"page":[NSNumber numberWithInteger:self.page],
                        @"rows":@"10",
                        @"orderBy":@"order_time"
                        };
    
    
    [skAfTool SKPOST:skUrl(@"/intf/bizGoodsOrder/list") pubParame:skPubParType(0) busParame:[dic skDicToJson:dic] showHUD:NO showErrMsg:NO success:^(skResponeModel *  _Nullable responseObject) {
        [self footerEndRefreshing];
        [self headerEndRefreshing];
        if (responseObject.returnCode==0) {
            
            
            skResponeList *modelList=[skResponeList mj_objectWithKeyValues:responseObject.data];
            
            self.arrList=[skOrderBuyModel mj_objectArrayWithKeyValuesArray:modelList.list];
            [self.tableView reloadData];
        }
        
    } failure:^(NSError * _Nullable error) {
        [self footerEndRefreshing];
        [self headerEndRefreshing];
    }];
}

@end
