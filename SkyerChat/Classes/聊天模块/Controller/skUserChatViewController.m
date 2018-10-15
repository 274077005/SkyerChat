//
//  skUserChatViewController.m
//  SkyerChat
//
//  Created by admin on 2018/10/10.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "skUserChatViewController.h"

@interface skUserChatViewController ()

@end

@implementation skUserChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"聊天列表";
    // Do any additional setup after loading the view.
    //设置需要显示哪些类型的会话
    [self setDisplayConversationTypeArray:@[@(ConversationType_PRIVATE),
                                        @(ConversationType_DISCUSSION),
                                        @(ConversationType_CHATROOM),
                                        @(ConversationType_GROUP),
                                        @(ConversationType_APPSERVICE),
                                        @(ConversationType_SYSTEM)]];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
