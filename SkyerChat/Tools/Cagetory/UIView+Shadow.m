//
//  UIView+Shadow.m
//  SkyerParking
//
//  Created by admin on 2018/7/10.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "UIView+Shadow.h"

@implementation UIView (Shadow)
-(void)skSetShadowWithColor:(UIColor *)color{
    //加阴影--任海丽编辑
    self.layer.shadowColor = color.CGColor;//阴影颜色
    
    self.layer.shadowOffset = CGSizeMake(0, 0);//偏移距离
    
    self.layer.shadowOpacity = 0.5;//不透明度
    
    self.layer.shadowRadius = 5.0;//半径
}

-(void)skSetShadowWithColor:(UIColor *)color
                andSizeMake:(CGSize)offSet
                     Radius:(CGFloat)Radius{
    //加阴影--任海丽编辑
    self.layer.shadowColor = color.CGColor;//阴影颜色
    
    self.layer.shadowOffset = offSet;//偏移距离
    
    self.layer.shadowOpacity = 0.5;//不透明度
    
    self.layer.shadowRadius = 5.0;//半径
    
    self.layer.cornerRadius=Radius;
    
    
}
@end
