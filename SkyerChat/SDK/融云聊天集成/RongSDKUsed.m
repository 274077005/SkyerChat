//
//  RongInitAppKey.m
//  SkyerChat
//
//  Created by admin on 2018/9/26.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "RongSDKUsed.h"
#import "GroupModel.h"

@implementation RongSDKUsed

+ (RongSDKUsed *)shareInstance {
    static RongSDKUsed *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[[self class] alloc] init];
        
    });
    return instance;
}

-(void)initRongWithAppkey:(NSString *)key{
    [[RCIM sharedRCIM] initWithAppKey:key];
    //设置用户信息源和群组信息源
}

- (void)skRongConnectWithToken:(NSString *)token
                 success:(void (^)(NSString *userId))successBlock
                   error:(void (^)(RCConnectErrorCode status))errorBlock
          tokenIncorrect:(void (^)(void))tokenIncorrectBlock{
    [[RCIM sharedRCIM] connectWithToken:token success:^(NSString *userId) {
        NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
        [[RCIM sharedRCIM] setConnectionStatusDelegate:self];
        [[RCIM sharedRCIM] setUserInfoDataSource:self];
        [[RCIM sharedRCIM] setGroupInfoDataSource:self];
        successBlock(userId);
    } error:^(RCConnectErrorCode status) {
        NSLog(@"登陆的错误码为:%ld", status);
        errorBlock(status);
    } tokenIncorrect:^{
        //token过期或者不正确。
        //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
        //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
        NSLog(@"token错误");
        tokenIncorrectBlock();
    }];
}
//用户信息提供者
- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *userInfo))completion{
    
    NSLog(@"用户信息提供者ID=%@",userId);
    
    RCUserInfo *user=[[RCUserInfo alloc] init];
    if ([userId isEqualToString:skUser.userNo]) {
        user.userId=userId;
        user.portraitUri=skUser.portrait;
        user.name=skUser.nickName;
    }
    
    
    return completion(user);
}
//群组信息提供者
- (void)getGroupInfoWithGroupId:(NSString *)groupId completion:(void (^)(RCGroup *groupInfo))completion{
    NSLog(@"群组信息提供者=%@",groupId);
    
    [self getGroupSimple:groupId completion:^(RCGroup *groupInfo) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[RCIM sharedRCIM] refreshGroupInfoCache:groupInfo withGroupId:groupId];
        });
        completion(groupInfo);
    }];
}
- (void)onRCIMConnectionStatusChanged:(RCConnectionStatus)status {
    if (status == ConnectionStatus_KICKED_OFFLINE_BY_OTHER_CLIENT) {
        NSLog(@"强登了");
        [skRootViewController skRootLoginViewController];
    }
}

-(void)getGroupSimple:(NSString *)groupId completion:(void (^)(RCGroup *groupInfo))completion{
    
    NSDictionary *dic=@{@"groupId":@"",
                        @"groupNo":groupId
                        };
    RCGroup *group=[[RCGroup alloc] init];
    
    [skAfTool SKPOST:skUrl(@"/intf/bizGroup/getGroupSimple") pubParame:skPubParType(0) busParame:[dic skDicToJson:dic] showHUD:NO showErrMsg:NO success:^(skResponeModel *  _Nullable responseObject) {
        
        if (responseObject.returnCode==0) {
            GroupModel *model=[GroupModel mj_objectWithKeyValues:responseObject.data];
            
            group.groupName=model.groupName;
            group.groupId=groupId;
            group.portraitUri=model.groupIcon;
            
            return completion(group);
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}

@end
