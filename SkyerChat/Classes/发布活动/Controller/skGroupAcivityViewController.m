//
//  skGroupAcivityViewController.m
//  SkyerChat
//
//  Created by skyer on 2018/11/12.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import "skGroupAcivityViewController.h"
#import "ActivityView.h"
#import "skImagePicker.h"
#import "groupActivityModel.h"
@interface skGroupAcivityViewController ()
@property (nonatomic ,strong) ActivityView *viewActivity;
@property (nonatomic,strong) groupActivityModel *model;
@property (nonatomic,strong) UIImage *image1;
@property (nonatomic,strong) UIImage *image2;
@end

@implementation skGroupAcivityViewController
- (groupActivityModel *)model{
    if (nil==_model) {
        _model=[[groupActivityModel alloc] init];
    }
    return _model;
}
- (ActivityView *)viewActivity{
    if (nil==_viewActivity) {
        _viewActivity=skXibView(@"ActivityView");
        @weakify(self)
        
        [[_viewActivity.btnAddImage rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [skImagePicker showImagePickerFromViewController:self allowsEditing:YES finishAction:^(UIImage *image) {
                if (self.image1==nil) {
                    self.image1=image;
                    self.viewActivity.image1.image=self.image1;
                }else{
                    self.image2=image;
                    self.viewActivity.image2.image=self.image2;
                }
            }];
        }];
    }
    return _viewActivity;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.viewActivity];
    self.title=@"发布活动";
    @weakify(self)
    [[[self skCreatBtn:@"发布" btnTitleOrImage:(btntypeTitle) btnLeftOrRight:(btnStateRight)] rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        [self bizGoodscreate];
    }];
    
    RAC(self.model,goodsName)=self.viewActivity.txtName.rac_textSignal;
    RAC(self.model,goodsDesc)=self.viewActivity.txtDes.rac_textSignal;
    RAC(self.model,goodsPrice)=self.viewActivity.txtPrice.rac_textSignal;
    RAC(self.model,activityPrice)=self.viewActivity.txtPriceActivice.rac_textSignal;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)bizGoodscreate{
    ///intf/bizUser/sendRegister
    
    
    NSString *imageSt1=[skClassMethod skImageBase64:self.image1];
    NSString *imageSt2=[skClassMethod skImageBase64:self.image2];
    
    NSMutableArray *arrImage=[[NSMutableArray alloc] init];
    
    if (self.image1) {
        [arrImage addObject:imageSt1];
    }
    if (self.image2) {
        [arrImage addObject:imageSt2];
    }
    
    NSDictionary *dic=@{@"goodsName":self.model.goodsName,
                        @"goodsDesc":self.model.goodsDesc,
                        @"goodsPicsBase64":arrImage,
                        @"goodsPrice":self.model.goodsPrice,
                        @"activityPrice":self.model.activityPrice,
                        @"groupNo":self.modelOther.groupNo
                        };
    
    
    [skAfTool SKPOST:skUrl(@"/intf/bizGoods/create") pubParame:skPubParType(0) busParame:[dic skDicToJson:dic] showHUD:YES showErrMsg:YES success:^(skResponeModel *  _Nullable responseObject) {
        
        if (responseObject.returnCode==0) {
            [SkToast SkToastShow:@"发布成功" withHight:300];
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}
@end
