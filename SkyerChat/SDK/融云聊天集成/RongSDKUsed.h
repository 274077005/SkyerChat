//
//  RongInitAppKey.h
//  SkyerChat
//
//  Created by admin on 2018/9/26.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RongSDKUsed : NSObject <RCIMConnectionStatusDelegate,RCIMUserInfoDataSource,RCIMGroupInfoDataSource,RCIMGroupUserInfoDataSource,RCIMGroupMemberDataSource,RCIMReceiveMessageDelegate>

@property (nonatomic,strong) NSMutableArray *arrMember;

+ (RongSDKUsed *)shareInstance;

-(void)skSuccessLoginRong;
/**
 初始化融云
 
 @param key 融云的appkey
 */
-(void)initRongWithAppkey:(NSString *)key;

/**
 链接融云服务器

 @param token 后台注册的token
 */
- (void)skRongConnectWithToken:(NSString *)token
                       success:(void (^)(NSString *userId))successBlock
                         error:(void (^)(RCConnectErrorCode status))errorBlock
                tokenIncorrect:(void (^)(void))tokenIncorrectBlock;


/**
 返回未读消息数

 @return 未读消息的数量
 */
-(NSInteger)skGetCount;
@end
