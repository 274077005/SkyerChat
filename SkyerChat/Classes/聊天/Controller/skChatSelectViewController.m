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
#import "skAddFriendViewController.h"
#import "skMenuViewController.h"
#import "skCreatGroupViewController.h"
#import "QRCodeScanViewController.h"
#import "skCombineCheckViewController.h"

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
    
    [[RongSDKUsed shareInstance] skRongConnectWithToken:skUser.token success:^(NSString *userId) {
        NSLog(@"融云登录成功");
        [self.viewChild skChangVeiw:1];
    } error:^(RCConnectErrorCode status) {
        
    } tokenIncorrect:^{
        
    }];
    [self.viewChild skChangVeiw:0];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.viewChild skChangVeiw:1];
    });
    
    @weakify(self)
    [[[self skCreatBtn:@"bar-更多-白" btnTitleOrImage:(btntypeImage) btnLeftOrRight:(btnStateRight)] rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        
        
        
        skMenuViewController *viewCharge=[[skMenuViewController alloc] init];
        //关键语句，必须有
        viewCharge.arrTitle=@[@"新建聊天群",@"添加好友",@"扫一扫",@"合并审核"];
        viewCharge.view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.1];
        viewCharge.modalPresentationStyle = UIModalPresentationOverFullScreen;
        [viewCharge setChargeType:^(NSInteger index) {
            NSLog(@"%ld",index);
            switch (index) {
                case 0:
                {
                    skCreatGroupViewController *view=[[skCreatGroupViewController alloc] init];
                    [self.navigationController pushViewController:view animated:YES];
                }
                    break;
                case 1:
                {
                    skAddFriendViewController *view=[[skAddFriendViewController alloc] init];
                    [self.navigationController pushViewController:view animated:YES];
                }
                    break;
                case 2:
                {
                    QRCodeScanViewController *view=[[QRCodeScanViewController alloc] init];
                    @weakify(self)
                    
                    [[view rac_signalForSelector:@selector(skScanResult:)] subscribeNext:^(RACTuple * _Nullable x) {
                        @strongify(self)
                        [self bizGroupUserCreate:x[0]];
                        
                    }];
                    [self.navigationController pushViewController:view animated:YES];
                    
                }
                    break;
                case 3:
                {
                    skCombineCheckViewController *view=[[skCombineCheckViewController  alloc] init];
                    [self.navigationController pushViewController:view animated:YES];
                    
                }
                    break;
                    
                default:
                    break;
            }
        }];
        [skVSView presentViewController:viewCharge animated:NO completion:^(void){
            
        }];
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
-(void)bizGroupUserCreate:(NSString *)groupNo{
    ///intf/bizUser/sendRegister
    
    NSLog(@"====%@",groupNo);
    NSArray *arrList=[groupNo componentsSeparatedByString:@"/"];
    if (arrList.count>0) {
        NSDictionary *dic=@{@"inviteSecret":[arrList lastObject],
                            };
        
        
        [skAfTool SKPOST:skUrl(@"/intf/bizGroupUser/create") pubParame:skPubParType(0) busParame:[dic skDicToJson:dic] showHUD:YES showErrMsg:YES success:^(skResponeModel *  _Nullable responseObject) {
            
            if (responseObject.returnCode==0) {
                [SkToast SkToastShow:@"加群成功" withHight:300];
            }
            
        } failure:^(NSError * _Nullable error) {
            
        }];
    }
    
}
@end
