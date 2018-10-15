//
//  SKNavigation.m
//  SkyerParking
//
//  Created by admin on 2018/6/28.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "skNavigationConfig.h"

@implementation skNavigationConfig
+(void)skNavigationInit{
    //设置导航栏的颜色
    [[UINavigationBar appearance] setBarTintColor:KcolorMain];
    //设置导航栏标题的属性
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName : [UIFont boldSystemFontOfSize:17]}];
    //设置返回按钮的颜色
    [[UINavigationBar appearance] setTintColor:[UIColor clearColor]];
    //设置导航栏没有透明度,会出现适配问题
    [[UINavigationBar appearance] setTranslucent:NO];
    //去除导航栏小白线
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
}
@end
