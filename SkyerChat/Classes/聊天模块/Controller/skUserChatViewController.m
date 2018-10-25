//
//  skUserChatViewController.m
//  SkyerChat
//
//  Created by admin on 2018/10/10.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "skUserChatViewController.h"
#import "skGroupChatViewController.h"
#import "skSingleChatViewController.h"


@interface skUserChatViewController ()

@end

@implementation skUserChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"聊天";
    // Do any additional setup after loading the view.
    //设置需要显示哪些类型的会话
    [self setDisplayConversationTypeArray:@[@(ConversationType_PRIVATE),
                                        @(ConversationType_DISCUSSION),
                                        @(ConversationType_CHATROOM),
                                        @(ConversationType_GROUP),
                                        @(ConversationType_APPSERVICE),
                                        @(ConversationType_SYSTEM)]];
    //设置需要将哪些类型的会话在会话列表中聚合显示
    [self setCollectionConversationType:@[@(ConversationType_SYSTEM),
                                          @(ConversationType_PUSHSERVICE)]];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//重写RCConversationListViewController的onSelectedTableRow事件
- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType
         conversationModel:(RCConversationModel *)model
               atIndexPath:(NSIndexPath *)indexPath {
    
    RCConversationType type=model.conversationType;
    
    switch (type) {
        case ConversationType_PRIVATE://单聊
        {
            skSingleChatViewController *conversationVC = [[skSingleChatViewController alloc]init];
            conversationVC.conversationType = model.conversationType;
            conversationVC.targetId = model.targetId;
            conversationVC.title = model.conversationTitle;
            [self.navigationController pushViewController:conversationVC animated:YES];
        }
            break;
        case ConversationType_GROUP://群组
        {
            skGroupChatViewController *conversationVC = [[skGroupChatViewController alloc]init];
            conversationVC.conversationType = model.conversationType;
            conversationVC.targetId = model.targetId;
            conversationVC.title = model.conversationTitle;
            [self.navigationController pushViewController:conversationVC animated:YES];
        }
            break;
            
        default:
            break;
    }
    
    

}
@end
