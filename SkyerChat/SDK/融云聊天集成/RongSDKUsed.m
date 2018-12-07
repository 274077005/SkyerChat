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
#import "groupUserModel.h"

@implementation RongSDKUsed

+ (RongSDKUsed *)shareInstance {
    static RongSDKUsed *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[[self class] alloc] init];
        
    });
    return instance;
}
#pragma mark - 容易初始化
-(void)initRongWithAppkey:(NSString *)key{
    [[RCIM sharedRCIM] initWithAppKey:key];
    //设置用户信息源和群组信息源
    
}
#pragma mark 链接融云
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
#pragma mark 设置参数
-(void)skSuccessLoginRong{
    //设置会话列表头像和会话页面头像
    [[RCIM sharedRCIM] setConnectionStatusDelegate:self];
    [RCIM sharedRCIM].globalConversationPortraitSize = CGSizeMake(40, 40);
    //开启用户信息和群组信息的持久化
    [RCIM sharedRCIM].enablePersistentUserInfoCache = YES;
    //设置用户信息源和群组信息源
    [RCIM sharedRCIM].userInfoDataSource = self;
    [RCIM sharedRCIM].groupInfoDataSource = self;
    //设置接收消息代理
    [RCIM sharedRCIM].receiveMessageDelegate = self;
    //开启输入状态监听
    [RCIM sharedRCIM].enableTypingStatus = YES;
    //是否关闭所有的本地通知，默认值是NO
    [RCIM sharedRCIM].disableMessageNotificaiton=NO;
    //开启发送已读回执
    [RCIM sharedRCIM].enabledReadReceiptConversationTypeList =
    @[ @(ConversationType_PRIVATE), @(ConversationType_DISCUSSION), @(ConversationType_GROUP) ];
    
    //开启多端未读状态同步
    [RCIM sharedRCIM].enableSyncReadStatus = YES;
    
    //设置显示未注册的消息
    //如：新版本增加了某种自定义消息，但是老版本不能识别，开发者可以在旧版本中预先自定义这种未识别的消息的显示
    [RCIM sharedRCIM].showUnkownMessage = YES;
    
    //群成员数据源
    [RCIM sharedRCIM].groupMemberDataSource = self;
    
    //开启消息@功能（只支持群聊和讨论组, App需要实现群成员数据源groupMemberDataSource）
    [RCIM sharedRCIM].enableMessageMentioned = YES;
    
    //开启消息撤回功能
    [RCIM sharedRCIM].enableMessageRecall = YES;
}


#pragma mark - 用户信息提供者
//用户信息提供者
- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *userInfo))completion{
    
    NSLog(@"用户信息提供者ID=%@",userId);
    [self getUser:userId completion:^(RCUserInfo *userInfo) {
        [[RCIM sharedRCIM] refreshUserInfoCache:userInfo withUserId:userId];
        completion(userInfo);
    }];
    RCUserInfo *userInfo=[[RCIM sharedRCIM] getUserInfoCache:userId];
    completion(userInfo);
}
#pragma mark 服务器返回指定用户信息
-(void)getUser:(NSString *)userNo completion:(void (^)(RCUserInfo *userInfo))completion{
    
    NSDictionary *dic=@{@"userNo":userNo};
    
    [skAfTool SKPOST:skUrl(@"/intf/bizUser/getUserSimple") pubParame:skPubParType(0) busParame:[dic skDicToJson:dic] showHUD:NO showErrMsg:NO success:^(skResponeModel *  _Nullable responseObject) {
        
        if (responseObject.returnCode==0) {
            SingleModel *model=[SingleModel mj_objectWithKeyValues:responseObject.data];
            RCUserInfo *user=[[RCUserInfo alloc] init];
            user.name=[model.nickName length]>0?model.nickName:userNo;
            user.portraitUri=model.portrait;
            user.userId=userNo;
            completion(user);
        }else{
            
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}
#pragma mark 群组信息提供者
//群组信息提供者
- (void)getGroupInfoWithGroupId:(NSString *)groupId completion:(void (^)(RCGroup *groupInfo))completion{
    NSLog(@"群组信息提供者=%@",groupId);
    
    [self getGroupSimple:groupId completion:^(RCGroup *groupInfo) {
        [[RCIM sharedRCIM] refreshGroupInfoCache:groupInfo withGroupId:groupId];
        completion(groupInfo);
    }];
    
    RCGroup *groupInfo=[[RCIM sharedRCIM] getGroupInfoCache:groupId];
    completion(groupInfo);
}
#pragma mark 服务器返回指定群信息
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
#pragma mark - 群成员信息列表 @功能用到
-(void)getGroupList:(NSString *)groupId
                     result:(void (^)(NSArray<NSString *> *userIdList))resultBlock{
    ///intf/bizUser/sendRegister
    NSDictionary *dic=@{@"groupNo":groupId
                        };
    
    
    [skAfTool SKPOST:skUrl(@"/intf/bizGroupUser/list") pubParame:skPubParType(0) busParame:[dic skDicToJson:dic] showHUD:YES showErrMsg:YES success:^(skResponeModel *  _Nullable responseObject) {
        
        if (responseObject.returnCode==0) {
            skResponeList *modelList=[skResponeList mj_objectWithKeyValues:responseObject.data];
            
            NSArray *arrList=[groupUserModel mj_objectArrayWithKeyValuesArray:modelList.list];
            NSMutableArray *arrMember=[[NSMutableArray alloc] init];
            for (int i = 0; i<arrList.count; ++i) {
                groupUserModel *model=[arrList objectAtIndex:i];
                [arrMember addObject:model.userNo];
            }
            resultBlock(arrMember);
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}
#pragma mark 群名片信息提供者
- (void)getAllMembersOfGroup:(NSString *)groupId
                      result:(void (^)(NSArray<NSString *> *userIdList))resultBlock{
    
    [self getGroupList:groupId result:^(NSArray<NSString *> *userIdList) {
        resultBlock(userIdList);
    }];
    
}
#pragma mark - 强登回调
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
#pragma mark - 接受到消息的回调
//这两个直接看注释，写的非常详细
-(BOOL)onRCIMCustomLocalNotification:(RCMessage*)message
                      withSenderName:(NSString *)senderName{
    
    NSLog(@"收到了消息");
    
    return NO;
}
-(BOOL)onRCIMCustomAlertSound:(RCMessage *)message{
    NSLog(@"收到消息提示音");
    return NO;
}
/*!
 接收消息的回调方法
 
 @param message     当前接收到的消息
 @param left        还剩余的未接收的消息数，left>=0
 
 @discussion 如果您设置了IMKit消息监听之后，SDK在接收到消息时候会执行此方法（无论App处于前台或者后台）。
 其中，left为还剩余的、还未接收的消息数量。比如刚上线一口气收到多条消息时，通过此方法，您可以获取到每条消息，left会依次递减直到0。
 您可以根据left数量来优化您的App体验和性能，比如收到大量消息时等待left为0再刷新UI。
 */
-(void)onRCIMReceiveMessage:(RCMessage *)message left:(int)left{
    
    int unreadMsgCount = [[RCIMClient sharedRCIMClient] getUnreadCount:@[@(ConversationType_PRIVATE),
                                                                         @(ConversationType_GROUP),
                                                                         @(ConversationType_SYSTEM)
                                                                         ]];
    
    NSString * unreadNum = [NSString stringWithFormat:@"%d",unreadMsgCount];
    NSDictionary * dict = @{@"unreadNum":unreadNum};
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MessageUnreadNum" object:nil userInfo:dict];
    
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    
    if (version >= 8.0) {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
    UIApplication *app = [UIApplication sharedApplication];
    app.applicationIconBadgeNumber = unreadMsgCount;
}

#pragma mark 所有的未读消息

-(NSInteger)skGetCount{
    NSInteger unreadMsgCount = [[RCIMClient sharedRCIMClient] getUnreadCount:@[@(ConversationType_PRIVATE),
                                                                         @(ConversationType_GROUP),
                                                                         @(ConversationType_SYSTEM)
                                                                         ]];
    return unreadMsgCount;
}
@end
