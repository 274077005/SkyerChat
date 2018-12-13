//
//  skGonggaoViewController.m
//  SkyerChat
//
//  Created by admin on 2018/11/15.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import "skGonggaoViewController.h"
#import "gonggaoView.h"


@interface skGonggaoViewController ()
@property (nonatomic,strong) gonggaoView *viewGonggao;
@end

@implementation skGonggaoViewController
- (gonggaoView *)viewGonggao{
    if (nil==_viewGonggao) {
        _viewGonggao=skXibView(@"gonggaoView");
        [self.view addSubview:_viewGonggao];
        [_viewGonggao mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_topLayoutGuide);
            make.left.bottom.right.mas_equalTo(0);
        }];
    }
    return _viewGonggao;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self viewGonggao];
    self.title=@"发布群公告";
    @weakify(self)
    [[[self skCreatBtn:@"发布" btnTitleOrImage:(btntypeTitle) btnLeftOrRight:(btnStateRight)] rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        if (self.viewGonggao.txtGonggao.text.length>0) {
            [self bizGroupNoticeCreate];
        }
        
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)bizGroupNoticeCreate{
    ///intf/bizUser/sendRegister
    NSDictionary *dic=@{@"groupNo":self.modelOther.groupNo,
                        @"noticeTitle":self.viewGonggao.txtGonggao.text,
                        @"noticeContent":self.viewGonggao.txtGonggao.text
                        };
    
    
    [skAfTool SKPOST:skUrl(@"/intf/bizGroupNotice/create") pubParame:skPubParType(0) busParame:[dic skDicToJson:dic] showHUD:YES showErrMsg:YES success:^(skResponeModel *  _Nullable responseObject) {
        
        if (responseObject.returnCode==0) {
            [SkToast SkToastShow:@"发布公告成功" withHight:300];
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}
@end
