//
//  skOrderPayDesViewController.m
//  SkyerChat
//
//  Created by skyer on 2019/1/13.
//  Copyright © 2019 www.skyer.com. All rights reserved.
//

#import "skOrderPayDesViewController.h"
#import "skOrderPayDesViews.h"

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
    }
    return _viewOrderPay;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self viewOrderPay];
    self.title=@"订单详情";
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
