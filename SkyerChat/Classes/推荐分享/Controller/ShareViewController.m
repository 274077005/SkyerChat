//
//  ShareViewController.m
//  SkyerParking
//
//  Created by admin on 2018/7/20.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "ShareViewController.h"
#import "ShareViews.h"
#import "skModShareConfig.h"
#import "UIImageView+WebCache.h"

@interface ShareViewController ()
@property (nonatomic,strong) ShareViews *viewShare;
@end

@implementation ShareViewController
- (ShareViews *)viewShare{
    if (_viewShare==nil) {
        _viewShare=skXibView(@"ShareViews");
        
        [self.view addSubview:_viewShare];
        [_viewShare.imageUser skSetBoardRadius:30 Width:0 andBorderColor:nil];
        [_viewShare mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.mas_equalTo(0);
        }];
        //微信好友分享
        [[_viewShare.btnWechat rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            [skModShareConfig skShare:SSDKPlatformSubTypeWechatSession];
        }];
        //朋友圈分享
        [[_viewShare.btnWechatFriend rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [skModShareConfig skShare:SSDKPlatformSubTypeWechatTimeline];
        }];
        //QQ好友
        [[_viewShare.btnShareQQ rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [skModShareConfig skShare:SSDKPlatformTypeQQ];
        }];
        
        //朋友圈分享
        [[_viewShare.btnShareZool rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [skModShareConfig skShare:SSDKPlatformSubTypeQZone];
        }];
        
    }
    return _viewShare;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"推荐分享";
    [self viewShare];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
