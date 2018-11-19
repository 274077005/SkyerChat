//
//  RongInitAppKey.m
//  SkyerChat
//
//  Created by admin on 2018/9/26.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "RongSDKUsed.h"
#import "GroupModel.h"
#import "SingleModel.h"

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
        [self skSuccessLoginRong];
        RCUserInfo *user=[[RCUserInfo alloc] init];
        user.name=skUser.nickName;
        user.portraitUri=skUser.portrait;
        user.userId=userId;
        [[RCIM sharedRCIM] setCurrentUserInfo:user];
        [[RCIM sharedRCIM] setEnableMessageAttachUserInfo:YES];
        
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

-(void)skSuccessLoginRong{
    //设置会话列表头像和会话页面头像
    
    [[RCIM sharedRCIM] setConnectionStatusDelegate:self];
    
    [RCIM sharedRCIM].globalConversationPortraitSize = CGSizeMake(40, 40);
    //    [RCIM sharedRCIM].portraitImageViewCornerRadius = 10;
    //开启用户信息和群组信息的持久化
    [RCIM sharedRCIM].enablePersistentUserInfoCache = YES;
    //设置用户信息源和群组信息源
    [RCIM sharedRCIM].userInfoDataSource = self;
    [RCIM sharedRCIM].groupInfoDataSource = self;
    
    //设置接收消息代理
    [RCIM sharedRCIM].receiveMessageDelegate = self;
    //    [RCIM sharedRCIM].globalMessagePortraitSize = CGSizeMake(46, 46);
    //开启输入状态监听
    [RCIM sharedRCIM].enableTypingStatus = YES;
    [RCIM sharedRCIM].disableMessageNotificaiton=YES;
    //开启发送已读回执
    [RCIM sharedRCIM].enabledReadReceiptConversationTypeList =
    @[ @(ConversationType_PRIVATE), @(ConversationType_DISCUSSION), @(ConversationType_GROUP) ];
    
    //开启多端未读状态同步
    [RCIM sharedRCIM].enableSyncReadStatus = YES;
    
    //设置显示未注册的消息
    //如：新版本增加了某种自定义消息，但是老版本不能识别，开发者可以在旧版本中预先自定义这种未识别的消息的显示
    [RCIM sharedRCIM].showUnkownMessage = YES;
//    [RCIM sharedRCIM].showUnkownMessageNotificaiton = YES;
    
    //群成员数据源
    [RCIM sharedRCIM].groupMemberDataSource = self;
    
    //开启消息@功能（只支持群聊和讨论组, App需要实现群成员数据源groupMemberDataSource）
    [RCIM sharedRCIM].enableMessageMentioned = YES;
    
    //开启消息撤回功能
    [RCIM sharedRCIM].enableMessageRecall = YES;
}



//用户信息提供者
- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *userInfo))completion{
    
    NSLog(@"用户信息提供者ID=%@",userId);
    [self getUser:userId completion:^(RCUserInfo *userInfo) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[RCIM sharedRCIM] refreshUserInfoCache:userInfo withUserId:userId];
        });
        return completion(userInfo);
    }];
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
- (void)getAllMembersOfGroup:(NSString *)groupId
                      result:(void (^)(NSArray<NSString *> *userIdList))resultBlock{
    
}
- (void)onRCIMConnectionStatusChanged:(RCConnectionStatus)status {
    if (status == ConnectionStatus_KICKED_OFFLINE_BY_OTHER_CLIENT) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"强制下线" message:@"您的账号已在别处登录" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action=[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertController addAction:action];
        [skVSView presentViewController:alertController animated:YES completion:^{
            
        }];
        
        [skRootViewController skRootLoginViewController];
    }
}

-(void)getGroupSimple:(NSString *)groupId completion:(void (^)(RCGroup *groupInfo))completion{
    
    NSDictionary *dic=@{@"groupNo":groupId
                        };
    
    
    [skAfTool SKPOST:skUrl(@"/intf/bizGroup/getGroupSimple") pubParame:skPubParType(0) busParame:[dic skDicToJson:dic] showHUD:NO showErrMsg:NO success:^(skResponeModel *  _Nullable responseObject) {
        
        if (responseObject.returnCode==0) {
            GroupModel *model=[GroupModel mj_objectWithKeyValues:responseObject.data];
            
            RCGroup *group=[[RCGroup alloc] init];
            group.groupName=model.groupName;
            group.groupId=groupId;
            group.portraitUri=model.groupIcon;
            
            return completion(group);
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}

-(void)getUser:(NSString *)userNo completion:(void (^)(RCUserInfo *userInfo))completion{
    
    NSDictionary *dic=@{@"userNo":userNo};
    
    [skAfTool SKPOST:skUrl(@"/intf/bizUser/getUserSimple") pubParame:skPubParType(0) busParame:[dic skDicToJson:dic] showHUD:NO showErrMsg:NO success:^(skResponeModel *  _Nullable responseObject) {
        
        if (responseObject.returnCode==0) {
            SingleModel *model=[SingleModel mj_objectWithKeyValues:responseObject.data];
            
            
            RCUserInfo *user=[[RCUserInfo alloc] init];
            user.name=model.nickName;
            user.portraitUri=model.portrait;
            user.userId=userNo;
            
            completion(user);
        }else{
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}

@end
