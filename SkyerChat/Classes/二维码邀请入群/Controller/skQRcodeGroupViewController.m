//
//  skQRcodeGroupViewController.m
//  SkyerChat
//
//  Created by admin on 2018/11/13.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import "skQRcodeGroupViewController.h"
#import "QRCodeViews.h"
#import "QRCodeModel.h"
#import "UIImageView+WebCache.h"

@interface skQRcodeGroupViewController ()
@property (nonatomic,strong) QRCodeViews *viewQR;
@end

@implementation skQRcodeGroupViewController
- (QRCodeViews *)viewQR{
    if (nil==_viewQR) {
        _viewQR=skXibView(@"QRCodeViews");
        [self.view addSubview:_viewQR];
        [_viewQR skSetBoardRadius:10 Width:0 andBorderColor:nil];
        [_viewQR.imageGroupHeader skSetBoardRadius:30 Width:0 andBorderColor:nil];
        [_viewQR mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(skScreenWidth-60, 400));
            make.centerX.mas_equalTo(self.view.mas_centerX);
            make.centerY.mas_equalTo(self.view.mas_centerY);
        }];
    }
    return _viewQR;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor=[[UIColor grayColor] colorWithAlphaComponent:0.3];
    [self bizInviteToGroupCreate];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)bizInviteToGroupCreate{
    ///intf/bizUser/sendRegister
    NSDictionary *dic=@{@"groupNo":self.modelOther.groupNo
                        };
    
    
    [skAfTool SKPOST:skUrl(@"/intf/bizInviteToGroup/create") pubParame:skPubParType(0) busParame:[dic skDicToJson:dic] showHUD:YES showErrMsg:YES success:^(skResponeModel *  _Nullable responseObject) {
        
        if (responseObject.returnCode==0) {
            QRCodeModel *model=[QRCodeModel mj_objectWithKeyValues:responseObject.data];
            
            [self.viewQR.imageGroupHeader sd_setImageWithURL:[NSURL URLWithString:self.modelOther.groupIcon] placeholderImage:[UIImage imageNamed:@"default_group_portrait"]];
            
            self.viewQR.labGroupName.text=self.modelOther.groupName;
            
            [self.viewQR.imageGroupQR sd_setImageWithURL:[NSURL URLWithString:model.qrCodeUrl]];
            
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:NO completion:nil];
}
@end
