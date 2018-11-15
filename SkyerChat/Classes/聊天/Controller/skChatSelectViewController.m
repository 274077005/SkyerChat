//
//  skChatSelectViewController.m
//  SkyerChat
//
//  Created by admin on 2018/11/15.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import "skChatSelectViewController.h"
#import "SkChildViews.h"
#import "skChatNilViewController.h"
#import "skUserChatViewController.h"

@interface skChatSelectViewController ()
@property (nonatomic,strong) SkChildViews *viewChild;
@end

@implementation skChatSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"聊天";
    skChatNilViewController *view0=[[skChatNilViewController alloc] init];
    skUserChatViewController *view1=[[skUserChatViewController alloc] init];
    
    self.viewChild=[[SkChildViews alloc] initWithChildViews:@[view0,view1] andTag:self andOption:(UIViewAnimationOptionLayoutSubviews)];
    
    [self.viewChild skChangVeiw:0];
    
    [[RongSDKUsed shareInstance] skRongConnectWithToken:skUser.token success:^(NSString *userId) {
        NSLog(@"融云登录成功");
        [self.viewChild skChangVeiw:1];
    } error:^(RCConnectErrorCode status) {
        
    } tokenIncorrect:^{
        
    }];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.viewChild skChangVeiw:1];
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
