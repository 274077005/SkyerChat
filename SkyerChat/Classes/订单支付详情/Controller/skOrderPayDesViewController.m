//
//  skOrderPayDesViewController.m
//  SkyerChat
//
//  Created by skyer on 2019/1/13.
//  Copyright © 2019 www.skyer.com. All rights reserved.
//

#import "skOrderPayDesViewController.h"
#import "skOrderPayDesViews.h"
#import "skOrderState.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface skOrderPayDesViewController ()
@property (nonatomic,strong) skOrderPayDesViews *viewOrderPay;
@end

@implementation skOrderPayDesViewController
-(skOrderPayDesViews *)viewOrderPay{
    if (nil==_viewOrderPay) {
        _viewOrderPay=skXibView(@"skOrderPayDesViews");
        [self.view addSubview:_viewOrderPay];
        [_viewOrderPay mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.right.mas_equalTo(0);
        }];
        [_viewOrderPay.viewYuan skSetBoardRadius:5 Width:0 andBorderColor:nil];
        
        [_viewOrderPay.btnPay skSetBoardRadius:4 Width:1 andBorderColor:[UIColor redColor]];
        [_viewOrderPay.btnCanle skSetBoardRadius:4 Width:1 andBorderColor:[UIColor grayColor]];
        [_viewOrderPay.btnUplong skSetBoardRadius:4 Width:1 andBorderColor:[UIColor grayColor]];
        @weakify(self)
        [[_viewOrderPay.btnCanle rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [self bizGoodsOrder];
        }];
        
        //显示状态
        _viewOrderPay.labState.text=[skOrderState getState:self.modelOrder.orderStatus];
        //收货人
        _viewOrderPay.labNameBay.text=self.modelOrder.receiver;
        //收货地址
        _viewOrderPay.labAddress.text=self.modelOrder.receiverAddress;
        //手机号码
        _viewOrderPay.labPhone.text=self.modelOrder.receiverPhone;
        //所在群
        _viewOrderPay.labGroupName.text=[NSString stringWithFormat:@"所在群:%@",self.modelOrder.groupName];
        //商品名称
        _viewOrderPay.labShopName.text=self.modelOrder.goodsName;
        //商品数量
        _viewOrderPay.labTotalCount.text=[NSString stringWithFormat:@"共:%ld",self.modelOrder.goodsAmount];
        //商品总额
        _viewOrderPay.labTotalMeneyCount.text=[NSString stringWithFormat:@"￥%ld",self.modelOrder.toPayMoney];
        //实付金额
        _viewOrderPay.labReadPay.text=[NSString stringWithFormat:@"￥%ld",self.modelOrder.toPayMoney];
        //订单编号
        _viewOrderPay.labOrderNo.text=[NSString stringWithFormat:@"%@",self.modelOrder.orderNo];
        //下单时间
        _viewOrderPay.labTimeBay.text=[NSString stringWithFormat:@"%@",self.modelOrder.orderTime];
        //支付时间
        _viewOrderPay.labTimePay.text=[NSString stringWithFormat:@"%@",[self.modelOrder.paidTime length]>0?self.modelOrder.paidTime:@"未支付"];
        
        //图片
        [_viewOrderPay.imageShop sd_setImageWithURL:[NSURL URLWithString:self.modelOrder.goodsPic]];
        
        
        if (self.modelOrder.orderStatus!=0) {
            [_viewOrderPay.viewPayImageShow setHidden:NO];
            [_viewOrderPay.imagePay sd_setImageWithURL:[NSURL URLWithString:self.modelOrder.paidCapture]];
        }
    }
    return _viewOrderPay;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self viewOrderPay];
    self.title=@"订单详情";
    
}
///intf/bizGoodsOrder/deletes
-(void)bizGoodsOrder{
    ///intf/bizUser/sendRegister
    /*
     取值：0=未支付,1=待确认支付,2=已支付,3=确认未支付, 5=已发货,6=已收货,7=申请退货中,8=待寄回,9=寄回中,10=检查货物中,11=退货完成,12=不予退货,13=取消订单。如果不传则查询所有状态的订单
     */
    NSNumber *ids=[NSNumber numberWithInteger:self.modelOrder.orderId];
    
    NSDictionary *dic=@{@"ids":@[ids]
                        };
    
    
    [skAfTool SKPOST:skUrl(@"/intf/bizGoodsOrder/deletes") pubParame:skPubParType(0) busParame:[dic skDicToJson:dic] showHUD:NO showErrMsg:NO success:^(skResponeModel *  _Nullable responseObject) {
        if (responseObject.returnCode==0) {
            
        }
        
    } failure:^(NSError * _Nullable error) {
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

@end
