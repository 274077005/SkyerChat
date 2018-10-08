//
//  SKNetworking.m
//  GpsDuplicate
//
//  Created by SoKing on 2017/11/24.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import "skAFNetworkingTool.h"

@implementation skAFNetworkingTool

+ (skAFNetworkingTool *)shareInstance {
    static skAFNetworkingTool *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}

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
              reachableViaWiFi:(ReachableViaWiFi)reachableViaWiFi
{
    // 创建网络监测者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 监测到不同网络的情况
        switch (status)
        {
            case AFNetworkReachabilityStatusUnknown:
                unknown();
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                reachable();
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                reachableViaWWAN();
                
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                reachableViaWiFi();
                break;
                
            default:
                break;
        }
    }] ;
}

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
       failure:(FailureRespone)failure
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSLog(@"公共参数==>%@",pubParame);
    NSLog(@"接口地址==>%@",URLString);
    NSLog(@"业务参数==>%@",busParame);
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    //此处做一个识别，区别在于apply跟reapply token直接传dic类型，其他接口传str类型
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:URLString parameters:busParame error:nil];
    
    request.timeoutInterval = 30;
    
    request.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    
    [request setValue:@"gzip, deflate, br" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",nil];
    
    NSDictionary *headerFieldValueDictionary = pubParame;
    
    if (headerFieldValueDictionary != nil) {
        
        NSArray *arrKey=[headerFieldValueDictionary allKeys];
        
        for (int i =0; i<arrKey.count; ++i) {
            NSString *key=arrKey[i];
            NSString *value=[headerFieldValueDictionary objectForKey:key];
            [request setValue:value forHTTPHeaderField:key];
        }
        
    }
    
    manager.operationQueue.maxConcurrentOperationCount = 1;
    
    manager.responseSerializer = responseSerializer;
    //配置https证书
    
    [[manager dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
        
    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        NSString *jsonStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"获得的json==%@",jsonStr);
        
        
    }] resume];
}



@end
