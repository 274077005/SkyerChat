//
//  UIView+Shadow.h
//  SkyerParking
//
//  Created by admin on 2018/7/10.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Shadow)

/**
 添加阴影
 */
-(void)skSetShadowWithColor:(UIColor *)color;

/**
 添加阴影

 @param color 阴影颜色
 @param offSet 偏移
 */
-(void)skSetShadowWithColor:(UIColor *)color
                andSizeMake:(CGSize)offSet
                     Radius:(CGFloat)Radius;
@end
