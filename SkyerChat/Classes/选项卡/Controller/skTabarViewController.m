//
//  skTabarViewController.m
//  SkyerParking
//
//  Created by admin on 2018/7/3.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "skTabarViewController.h"
#import "skUserChatViewController.h"
#import "skAddressBookViewController.h"
#import "skActivityViewController.h"
#import "skUserCenterViewController.h"

@interface skTabarViewController ()

@end

@implementation skTabarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTabarView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initTabarView{
    //首页
    skUserChatViewController *skHome=[[skUserChatViewController alloc] init];
    skBaseNavViewController *skHomeNav = [[skBaseNavViewController alloc] initWithRootViewController:skHome];
    //附近
    skAddressBookViewController *skNear = [[skAddressBookViewController alloc] init];
    skBaseNavViewController *skNearNav = [[skBaseNavViewController alloc] initWithRootViewController:skNear];
    //个人中心
    skActivityViewController *skUserInfo = [[skActivityViewController alloc] init];
    skBaseNavViewController *skUserInfoNav = [[skBaseNavViewController alloc] initWithRootViewController:skUserInfo];
    //个人中心
    skUserCenterViewController *skUserCenterView = [[skUserCenterViewController alloc] init];
    skBaseNavViewController *skUserCenterVieNav = [[skBaseNavViewController alloc] initWithRootViewController:skUserCenterView];
    
    //设置底部tabbar
    self.viewControllers = @[skHomeNav,skNearNav,skUserInfoNav,skUserCenterVieNav];
    
    UITabBar *tabBar = self.tabBar;
    
    UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
    UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
    UITabBarItem *tabBarItem3 = [tabBar.items objectAtIndex:2];
    UITabBarItem *tabBarItem4 = [tabBar.items objectAtIndex:3];
    
    tabBarItem1.title=@"聊天";
    tabBarItem1.image=[UIImage imageNamed:@"功能-聊天-未选"];
    tabBarItem1.selectedImage=[UIImage imageNamed:@"功能-聊天-已选"];
    
    tabBarItem2.title=@"通讯录";
    tabBarItem2.image=[UIImage imageNamed:@"功能-联系人-未选"];
    tabBarItem2.selectedImage=[UIImage imageNamed:@"功能-联系人-已选"];
    
    tabBarItem3.title=@"活动";
    tabBarItem3.image=[UIImage imageNamed:@"功能-活动-未选"];
    tabBarItem3.selectedImage=[UIImage imageNamed:@"功能-活动-已选"];
    
    tabBarItem4.title=@"我的";
    tabBarItem4.image=[UIImage imageNamed:@"功能-我的-未选"];
    tabBarItem4.selectedImage=[UIImage imageNamed:@"功能-我的-已选"];
}

@end
