//
//  skCombineSubViewController.m
//  SkyerChat
//
//  Created by skyer on 2018/12/28.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import "skCombineSubViewController.h"
#import "CombineGroupInfoView.h"
#import "skGroupModel.h"
#import "skImagePicker.h"
#import "combineModel.h"

@interface skCombineSubViewController ()
@property (nonatomic,strong) CombineGroupInfoView *viewCombine;

@property (nonatomic,strong) UIImage *imageHeader;
@property (nonatomic,strong) combineModel *model;
@end

@implementation skCombineSubViewController

- (combineModel *)model{
    if (nil==_model) {
        _model=[[combineModel alloc] init];
    }
    return _model;
}

-(CombineGroupInfoView *)viewCombine{
    if (nil==_viewCombine) {
        _viewCombine=skXibView(@"CombineGroupInfoView");
        [self.view addSubview:_viewCombine];
        [_viewCombine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.top.mas_equalTo(0);
        }];
        @weakify(self)
        [[_viewCombine.btnHeader rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [skImagePicker showImagePickerFromViewController:self allowsEditing:YES finishAction:^(UIImage *image) {
                if (image) {
                    self.imageHeader=image;
                    [self.viewCombine.btnHeader setImage:nil forState:(UIControlStateNormal)];
                    [self.viewCombine.btnHeader setBackgroundImage:image forState:(UIControlStateNormal)];
                }
            }];
        }];
        
        [[_viewCombine.btnSubmit rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [self applyMergeGroup];
        }];
    }
    return _viewCombine;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self viewCombine];
    RAC(self.model,groupName)=self.viewCombine.txtName.rac_textSignal;
    RAC(self.model,mergeDays)=self.viewCombine.txtDate.rac_textSignal;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)applyMergeGroup{
    ///intf/bizUser/sendRegister
    NSMutableArray *arrNos=[[NSMutableArray alloc] init];
    
    for (int i=0; i<self.arrSelect.count; ++i) {
        NSInteger index=[[self.arrSelect objectAtIndex:i] integerValue];
        skGroupModel *model=[self.arrGroupList objectAtIndex:index];
        
        [arrNos addObject:model.groupNo];
    }
    NSDictionary *dic=@{@"fromGroupNo":self.modelOther.groupNo,
                        @"toGroupNos":arrNos,
                        @"groupIconBase64":[skClassMethod skImageBase64:self.imageHeader]?[skClassMethod skImageBase64:self.imageHeader]:@"",
                        @"xGroupName":self.model.groupName?self.model.groupName:@"",
                        @"mergeDays":self.model.mergeDays?self.model.mergeDays:@"30"
                        };
    
    
    [skAfTool SKPOST:skUrl(@"/intf/bizGroupMerge/applyMergeGroup") pubParame:skPubParType(0) busParame:[dic skDicToJson:dic] showHUD:YES showErrMsg:YES success:^(skResponeModel *  _Nullable responseObject) {
        
        if (responseObject.returnCode==0) {
            [SkToast SkToastShow:@"合并成功" withHight:300];
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}
@end
