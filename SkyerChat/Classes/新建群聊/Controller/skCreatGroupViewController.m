//
//  skCreatGroupViewController.m
//  SkyerChat
//
//  Created by admin on 2018/11/9.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import "skCreatGroupViewController.h"
#import "creatGroupView.h"
#import "skImagePicker.h"

@interface skCreatGroupViewController ()
@property (nonatomic,strong) creatGroupView *viewCreat;
@property (nonatomic,strong) UIImage *imageHeader;
@end

@implementation skCreatGroupViewController
- (creatGroupView *)viewCreat{
    if (nil==_viewCreat) {
        _viewCreat=skXibView(@"creatGroupView");
        [self.view addSubview:_viewCreat];
        [_viewCreat.btnHeader skSetBoardRadius:5 Width:2 andBorderColor:KcolorMain];
        [_viewCreat.btnCreat skSetBoardRadius:5 Width:2 andBorderColor:KcolorMain];
        [_viewCreat mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.right.left.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(skScreenWidth, 480));
        }];
        
        @weakify(self)
        [[_viewCreat.btnCreat rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            if (self.viewCreat.txtName.text.length>0) {
                [self bizGroupCreate];
            }
        }];
        [[_viewCreat.btnHeader rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [skImagePicker showImagePickerFromViewController:self allowsEditing:YES finishAction:^(UIImage *image) {
                self.imageHeader=image;
                [self.viewCreat.btnHeader setImage:image forState:(UIControlStateNormal)];
            }];
        }];
    }
    return _viewCreat;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"新建群聊";
    [self viewCreat];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)bizGroupCreate{
    ///intf/bizUser/sendRegister
    NSDictionary *dic=@{@"groupName":self.viewCreat.txtName.text,
                        @"groupIconBase64":self.imageHeader?[skClassMethod skImageBase64:self.imageHeader]:@""
                        };
    
    
    [skAfTool SKPOST:skUrl(@"/intf/bizGroup/create") pubParame:skPubParType(0) busParame:[dic skDicToJson:dic] showHUD:YES showErrMsg:YES success:^(skResponeModel *  _Nullable responseObject) {
        
        if (responseObject.returnCode==0) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}
@end
