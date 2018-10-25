//
//  skRootViewController.m
//  SkyerChat
//
//  Created by admin on 2018/10/11.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "skRootViewController.h"


@implementation skRootViewController

+(void)skRootLoginViewController{
    skLoginViewController *skLoginView=[[skLoginViewController alloc] init];
    skBaseNavViewController *skLoginViewNav=[[skBaseNavViewController alloc] initWithRootViewController:skLoginView];
    skUser.isLogin=NO;
    skKeyWindow.rootViewController=skLoginViewNav;
}

+(void)skRootTabarViewController{
    skTabarViewController *skLoginView=[[skTabarViewController alloc] init];
    skUser.isLogin=YES;
    skKeyWindow.rootViewController=skLoginView;
    
}

@end
