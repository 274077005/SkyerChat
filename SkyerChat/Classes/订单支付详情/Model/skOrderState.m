//
//  skOrderState.m
//  SkyerChat
//
//  Created by skyer on 2019/1/14.
//  Copyright © 2019 www.skyer.com. All rights reserved.
//

#import "skOrderState.h"

@implementation skOrderState
+(NSString *)getState:(NSInteger)state{
    /*
     取值:0=未支付,1=待确认支付,2=已支付,3=确认未支付, 5=已发货,6=已收货,7=申请退货中,8=待寄回,9=寄回中,10=检查货物中,11=退货完成,12=不予退货,13=取消订单
     */
    switch (state) {
        case 0:
        {
            return @"未支付";
        }
            break;
        case 1:
        {
            return @"待确认支付";
        }
            break;
        case 2:
        {
            return @"已支付";
        }
            break;
        case 3:
        {
            return @"确认未支付";
        }
            break;
        case 5:
        {
            return @"已发货";
        }
            break;
        case 6:
        {
            return @"已收货";
        }
            break;
        case 7:
        {
            return @"申请退货中";
        }
            break;
        case 8:
        {
            return @"待寄回";
        }
            break;
        case 9:
        {
            return @"寄回中";
        }
            break;
        case 10:
        {
            return @"检查货物中";
        }
            break;
        case 11:
        {
            return @"退货完成";
        }
            break;
        case 12:
        {
            return @"不予退货";
        }
            break;
        case 13:
        {
            return @"取消订单";
        }
            break;
            
            
        default:
            break;
    }
    return @"未知状态";
}
@end
