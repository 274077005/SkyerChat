//
//  skSubmitOrderViewController.m
//  SkyerChat
//
//  Created by skyer on 2019/1/7.
//  Copyright © 2019 www.skyer.com. All rights reserved.
//

#import "skSubmitOrderViewController.h"
#import "skSubmitOrderViews.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "skAddressModel.h"
#import "skAddressViewController.h"

@interface skSubmitOrderViewController ()
@property (nonatomic,strong) skSubmitOrderViews *viewSubmit;
@property (nonatomic,assign) int bayCount;
@property (nonatomic,strong) NSArray *arrList;
@end

@implementation skSubmitOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.7];
    self.bayCount=1;
    [self viewSubmit];
    
    [self initData];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self receiverAddress];
}
-(void)receiverAddress{
    ///intf/bizUser/sendRegister
    NSDictionary *dic=@{@"page":@"",
                        @"rows":@"1"
                        };
    
    
    [skAfTool SKPOST:skUrl(@"/intf/bizReceiverAddress/list") pubParame:skPubParType(0) busParame:[dic skDicToJson:dic] showHUD:YES showErrMsg:YES success:^(skResponeModel *  _Nullable responseObject) {
        
        if (responseObject.returnCode==0) {
            
            skResponeList *modelList=[skResponeList mj_objectWithKeyValues:responseObject.data];
            
            self.arrList=[skAddressModel mj_objectArrayWithKeyValuesArray:modelList.list];
            if (self.arrList.count==0) {
                //先设置收货地址
                skAddressViewController *view=[[skAddressViewController alloc] init];
                [self.navigationController pushViewController:view animated:YES];
            }else{
                skAddressModel *modelAddress=[self.arrList firstObject];
                self.viewSubmit.labBayName.text=modelAddress.receiver;
                self.viewSubmit.labBayAddress.text=modelAddress.address;
                self.viewSubmit.labPhone.text=modelAddress.phone;
            }
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}
-(void)initData{
    NSLog(@"%@",self.modelGoods);
    
    [self.viewSubmit.imageHeader sd_setImageWithURL:[NSURL URLWithString:self.modelGoods.goodsPic]];
    //标题
    self.viewSubmit.labTitle.text=self.modelGoods.goodsName;
    //价格
    self.viewSubmit.labMeney.text=[NSString stringWithFormat:@"￥%ld",self.modelGoods.activityPrice];
    //购买个数
    self.viewSubmit.labTotalMeney.text=[NSString stringWithFormat:@"￥%ld",self.bayCount*self.modelGoods.activityPrice];
    
}

- (skSubmitOrderViews *)viewSubmit{
    if (nil==_viewSubmit) {
        _viewSubmit=skXibView(@"skSubmitOrderViews");
        [self.view addSubview:_viewSubmit];
        [_viewSubmit.viewContain skSetBoardRadius:5 Width:0 andBorderColor:nil];
        [_viewSubmit mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.right.mas_equalTo(0);
        }];
        //点击消失按钮
        @weakify(self)
        [[_viewSubmit.btnDissmiss rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        [[_viewSubmit.btnDiss rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        //提交
        [_viewSubmit.btnSubmit skSetBoardRadius:5 Width:0 andBorderColor:nil];
        [[_viewSubmit.btnSubmit rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [self bizUserUpdate];
        }];
        //添加
        [[_viewSubmit.btnAdd rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            self.bayCount+=1;
            self.viewSubmit.labCount.text=[NSString stringWithFormat:@"%d",self.bayCount];
            
            self.viewSubmit.labTotalMeney.text=[NSString stringWithFormat:@"%ld￥",self.bayCount*self.modelGoods.activityPrice];
        }];
        //减
        [[_viewSubmit.btnSub rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            if (self.bayCount>0) {
                self.bayCount-=1;
                self.viewSubmit.labCount.text=[NSString stringWithFormat:@"%d",self.bayCount];
                self.viewSubmit.labTotalMeney.text=[NSString stringWithFormat:@"%ld￥",self.bayCount*self.modelGoods.activityPrice];
            }
        }];
    }
    return _viewSubmit;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - 提交订单
-(void)bizUserUpdate{
    ///intf/bizUser/sendRegister
    skAddressModel *modelAddress=[self.arrList firstObject];
    NSString *remark=self.viewSubmit.txtMessage.text;
    
    NSString *goodsNo=self.modelGoods.goodsNo;
    NSNumber *goodsAmount=[NSNumber numberWithInt:self.bayCount];
    NSNumber *revAddrId=[NSNumber numberWithInteger:modelAddress.raId];
    NSString *groupNo=self.modelGoods.goodsNo;
    
    
    NSDictionary *dic=@{@"goodsNo":goodsNo,
                        @"goodsAmount":goodsAmount,
                        @"revAddrId":revAddrId,
                        @"groupNo":groupNo,
                        @"remark":remark
                        };
    
    
    [skAfTool SKPOST:skUrl(@"/intf/bizGoodsOrder/create") pubParame:skPubParType(0) busParame:[dic skDicToJson:dic] showHUD:YES showErrMsg:YES success:^(skResponeModel *  _Nullable responseObject) {
        
        if (responseObject.returnCode==0) {
            [SkToast SkToastShow:@"提交订单成功" withHight:300];
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}
@end
