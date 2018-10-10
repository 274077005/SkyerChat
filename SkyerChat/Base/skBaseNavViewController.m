//
//  skBaseNavViewController.m
//  SkyerParking
//
//  Created by admin on 2018/6/28.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "skBaseNavViewController.h"

@interface skBaseNavViewController ()

@end

@implementation skBaseNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//重写nav的push方法
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{

    ///如果在堆栈控制器数量大于1 加返回按钮
    if (self.viewControllers.count > 0) {

        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        [btn setImage:[UIImage imageNamed:@"bar-返回-黑"] forState:UIControlStateNormal];
        
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];

        [btn addTarget:self action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:btn];

        viewController.navigationItem.leftBarButtonItem = leftItem;

        viewController.hidesBottomBarWhenPushed = YES;
    }

    [super pushViewController:viewController animated:animated];

}

@end
