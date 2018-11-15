//
//  skGroupChatViewController.m
//  SkyerChat
//
//  Created by admin on 2018/10/24.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import "skGroupChatViewController.h"
#import "skGroupChatDetailsViewController.h"
#import "GroupDesModel.h"
#import "SDCycleScrollView.h"
#import "groupOnerActivityModel.h"
#import "groupImageView.h"
#import "skActivityDesViewController.h"

@interface skGroupChatViewController ()<SDCycleScrollViewDelegate>
@property (nonatomic,strong) GroupDesModel *model;
@property (nonatomic,strong) SDCycleScrollView *viewCycle;
@property (nonatomic,strong) groupImageView *viewImage;
@property (nonatomic,strong) NSArray *arrList;
@property (nonatomic,assign) NSInteger indexSelect;
@end

@implementation skGroupChatViewController
- (SDCycleScrollView *)viewCycle{
    if (nil==_viewCycle) {
        _viewCycle = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, skScreenWidth, 150) delegate:self placeholderImage:[UIImage imageNamed:@""]];
        [self.view addSubview:_viewCycle];
        [_viewCycle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_topLayoutGuide);
            make.left.right.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(skScreenWidth, 150));
        }];
        _viewCycle.pageControlBottomOffset=30;
    }
    return _viewCycle;
}
- (groupImageView *)viewImage{
    if (nil==_viewImage) {
        _viewImage=skXibView(@"groupImageView");
        [self.view addSubview:_viewImage];
        _viewImage.iamgeTitle.backgroundColor=[[UIColor grayColor] colorWithAlphaComponent:0.3];
        [_viewImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.mas_topLayoutGuide);
            make.size.mas_equalTo(CGSizeMake(skScreenWidth, 150));
        }];
        
        @weakify(self)
        [[_viewImage.btnBack rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [[_viewImage.btnMore rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            if (self.model.groupNo) {
                skGroupChatDetailsViewController *view=[[skGroupChatDetailsViewController alloc] init];
                view.model=self.model;
                [self.navigationController pushViewController:view animated:YES];
            }
        }];
        [[_viewImage.btnBuy rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            skActivityDesViewController *view=[[skActivityDesViewController alloc] init];
            view.modelOther=[self.arrList objectAtIndex:self.indexSelect];
            [self.navigationController pushViewController:view animated:YES];
        }];

    }
    return _viewImage;
}

- (GroupDesModel *)model{
    if (nil==_model) {
        _model=[[GroupDesModel alloc] init];
    }
    return _model;
}
-(UIButton *)skCreatBtn:(NSString *)title btnTitleOrImage:(btntype)TitleOrImage btnLeftOrRight:(btnState)LeftOrRight{
    
    UIButton *but = [[UIButton alloc] init];
    //    [but setBackgroundColor:[UIColor redColor]];
    but.titleLabel.font=[UIFont systemFontOfSize:14];
    but.frame =CGRectMake(0,0, 40, 40);
    
    if (TitleOrImage==btntypeTitle) {
        [but setTitle:title forState:UIControlStateNormal];
    }else{
        [but setImage:[UIImage imageNamed:title] forState:(UIControlStateNormal)];
        
    }
    
    UIBarButtonItem  *barBut = [[UIBarButtonItem alloc]initWithCustomView:but];
    
    if (LeftOrRight==btnStateLeft) {
        //        [but setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
        self.navigationItem.leftBarButtonItem = barBut;
    }else{
        //        [but setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        self.navigationItem.rightBarButtonItem = barBut;
    }
    return but;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    @weakify(self)
    [[[self skCreatBtn:@"bar-更多-白" btnTitleOrImage:(btntypeImage) btnLeftOrRight:(btnStateRight)] rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        if (self.model.groupNo) {
            skGroupChatDetailsViewController *view=[[skGroupChatDetailsViewController alloc] init];
            view.model=self.model;
            [self.navigationController pushViewController:view animated:YES];
        }
    }];
    [self bizGroupgetGroup];
    
    self.conversationMessageCollectionView.frame=CGRectMake(0, 150, skScreenWidth, skScreenHeight-150);
    [self bizGoodsMyGoods];
    [self viewCycle];
    [self viewImage];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)bizGroupgetGroup{
    ///intf/bizUser/sendRegister
    NSDictionary *dic=@{@"groupNo":self.targetId
                        };

    [skAfTool SKPOST:skUrl(@"/intf/bizGroup/getGroup") pubParame:skPubParType(0) busParame:[dic skDicToJson:dic] showHUD:NO showErrMsg:NO success:^(skResponeModel *  _Nullable responseObject) {
        
        if (responseObject.returnCode==0) {
            self.model=[GroupDesModel mj_objectWithKeyValues:responseObject.data];
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}

-(void)bizGoodsMyGoods{
    ///intf/bizUser/sendRegister
    NSDictionary *dic=@{@"goodsNo":self.targetId,
                        @"page":@"0",
                        @"rows":@"3"
                        };
    
    
    [skAfTool SKPOST:skUrl(@"/intf/bizGoods/myGoods") pubParame:skPubParType(0) busParame:[dic skDicToJson:dic] showHUD:NO showErrMsg:NO success:^(skResponeModel *  _Nullable responseObject) {
        
        if (responseObject.returnCode==0) {
            
            
            skResponeList *modelList=[skResponeList mj_objectWithKeyValues:responseObject.data];
            
            self.arrList=[groupOnerActivityModel mj_objectArrayWithKeyValuesArray:modelList.list];
            
            NSMutableArray *arrImage=[[NSMutableArray alloc] init];
            for (int i =0; i<self.arrList.count; ++i) {
                groupOnerActivityModel *model=[self.arrList objectAtIndex:i];
                [arrImage addObject:model.goodsPic];
            }
            self.viewCycle.imageURLStringsGroup = arrImage;
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    groupOnerActivityModel *model=[self.arrList objectAtIndex:index];
    self.viewImage.labTitle.text=model.goodsName;
    self.indexSelect=index;
}
@end
