//
//  skGroupChatViewController.m
//  SkyerChat
//
//  Created by admin on 2018/10/24.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import "skGroupChatViewController.h"
#import "skGroupChatDetailsViewController.h"

@interface skGroupChatViewController ()

@end

@implementation skGroupChatViewController
-(UIButton *)skCreatBtn:(NSString *)title btnTitleOrImage:(btntype)TitleOrImage btnLeftOrRight:(btnState)LeftOrRight{
    
    UIButton *but = [[UIButton alloc] init];
    //    [but setBackgroundColor:[UIColor redColor]];
    but.titleLabel.font=[UIFont systemFontOfSize:14];
    but.frame =CGRectMake(0,0, 40, 40);
    
    if (TitleOrImage==btntypeTitle) {
        [but setTitle:title forState:UIControlStateNormal];
    }else{
        [but setImage:[UIImage imageNamed:title] forState:(UIControlStateNormal)];
        
    }
    
    UIBarButtonItem  *barBut = [[UIBarButtonItem alloc]initWithCustomView:but];
    
    if (LeftOrRight==btnStateLeft) {
        //        [but setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
        self.navigationItem.leftBarButtonItem = barBut;
    }else{
        //        [but setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        self.navigationItem.rightBarButtonItem = barBut;
    }
    return but;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    @weakify(self)
    [[[self skCreatBtn:@"bar-更多-白" btnTitleOrImage:(btntypeImage) btnLeftOrRight:(btnStateRight)] rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        skGroupChatDetailsViewController *view=[[skGroupChatDetailsViewController alloc] init];
        [self.navigationController pushViewController:view animated:YES];
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
