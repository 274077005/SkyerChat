//
//  SKNetworking.h
//  GpsDuplicate
//
//  Created by SoKing on 2017/11/24.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "skResponeModel.h"


NS_ASSUME_NONNULL_BEGIN


typedef void (^ _Nullable SuccessRespone)(id _Nullable responseObject);     // 成功Block
typedef void (^ _Nullable FailureRespone)(NSError * _Nullable error);        // 失败Blcok

typedef void (^ _Nullable Unknown)(void);          // 未知网络状态的Block
typedef void (^ _Nullable Reachable)(void);        // 无网络的Blcok
typedef void (^ _Nullable ReachableViaWWAN)(void); // 蜂窝数据网的Block
typedef void (^ _Nullable ReachableViaWiFi)(void); // WiFi网络的Block

@interface skAFNetworkingTool : NSObject



/**
 网络请求封装的单例

 @return 返回单例本身
 */
+ (skAFNetworkingTool *)shareInstance;

/**
 *  网络监测(在什么网络状态)
 *
 *  @param unknown          未知网络
 *  @param reachable        无网络
 *  @param reachableViaWWAN 蜂窝数据网
 *  @param reachableViaWiFi WiFi网络
 */
- (void)SKNetworkStatusUnknown:(Unknown)unknown
                     reachable:(Reachable)reachable
              reachableViaWWAN:(ReachableViaWWAN)reachableViaWWAN
              reachableViaWiFi:(ReachableViaWiFi)reachableViaWiFi;
/**
 *  封装的POST请求
 *
 *  @param URLString  请求的链接
 *  @param busParame 请求的参数
 *  @param isShow     是否有等待提示菊花
 *  @param showErr    是否显示错误信息
 *  @param success    请求成功回调
 *  @param failure    请求失败回调
 */
- (void)SKPOST:(NSString *_Nullable)URLString
     pubParame:(NSDictionary *_Nullable)pubParame
     busParame:(NSString *_Nullable)busParame
       showHUD:(Boolean)isShow
    showErrMsg:(Boolean) showErr
       success:(SuccessRespone)success
       failure:(FailureRespone)failure;
@end
NS_ASSUME_NONNULL_END

