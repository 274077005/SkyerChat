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
#import "skMyPayCodeViewController.h"
#import "skOrderPayDesViewController.h"
#import "skOrderState.h"
#import "skSingleChatViewController.h"

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
    skOrderBuyModel *model=[self.arrList objectAtIndex:indexPath.section];
    if (cell == nil) {
        cell = skXibView(@"skOrderBuyTableViewCell");
        
        @weakify(self)
        [[cell.btnPay rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            //提醒支付
            skSingleChatViewController *view=[[skSingleChatViewController alloc] initWithConversationType:(ConversationType_PRIVATE) targetId:model.buyerUserNo];
            view.title=model.buyerUserNo;
            [self.navigationController pushViewController:view animated:YES];
        }];
    }
    
    
    //图片
    [cell.imageShop sd_setImageWithURL:[NSURL URLWithString:model.goodsPic]];
    //商品时间
    cell.labTime.text=model.orderTime;
    //支付状态
    cell.labState.text=[skOrderState getState:model.orderStatus];
    //商品名称
    cell.labShopName.text=model.goodsName;
    //商品数量
    cell.labCount.text=[NSString stringWithFormat:@"共%ld件商品",model.goodsAmount];
    
    //价格
    cell.labMeney.text=[NSString stringWithFormat:@"￥%ld",model.toPayMoney];
    
    //提醒支付
    [cell.btnPay setTitle:@"提醒支付" forState:(UIControlStateNormal)];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    skOrderPayDesViewController *view=[[skOrderPayDesViewController alloc] init];
    
    skOrderBuyModel *model=[self.arrList objectAtIndex:indexPath.section];
    
    view.modelOrder=model;
    
    [self.navigationController pushViewController:view animated:YES];
}

-(void)bizGoodsOrder{
    ///intf/bizUser/sendRegister
    /*
     取值：0=未支付,1=待确认支付,2=已支付,3=确认未支付, 5=已发货,6=已收货,7=申请退货中,8=待寄回,9=寄回中,10=检查货物中,11=退货完成,12=不予退货,13=取消订单。如果不传则查询所有状态的订单
     */
    NSDictionary *dic=@{@"isBuyer":[NSNumber numberWithBool:NO],
                        @"page":[NSNumber numberWithInteger:self.page],
                        @"rows":@"10",
                        @"orderBy":@"order_time",
                        @"orderStatus":@"0"
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
