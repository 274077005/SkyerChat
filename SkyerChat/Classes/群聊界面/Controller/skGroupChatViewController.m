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
#import "GBLoopView.h"
#import "chatGonggaoView.h"
#import "chatGonggaoModel.h"
#import "skFriendDesViewController.h"

@interface skGroupChatViewController ()<SDCycleScrollViewDelegate>
@property (nonatomic,strong) GroupDesModel *model;
@property (nonatomic,strong) SDCycleScrollView *viewCycle;
@property (nonatomic,strong) groupImageView *viewImage;
@property (nonatomic,strong) NSArray *arrList;
@property (nonatomic,assign) NSInteger indexSelect;
@property (nonatomic,strong) GBLoopView *paoView;
@property (nonatomic,strong) chatGonggaoView *viewGonggao;
@end

@implementation skGroupChatViewController


- (GBLoopView *)paoView{
    if (nil==_paoView) {
        _paoView=[[GBLoopView alloc] initWithFrame:CGRectMake(0, 0, skScreenWidth, 24)];
        [_paoView setSpeed:60.0f];
        [_paoView setDirection:GBLoopDirectionRight];
        [_paoView start];
    }
    return _paoView;
}

- (chatGonggaoView *)viewGonggao{
    if (nil==_viewGonggao) {
        _viewGonggao=skXibView(@"chatGonggaoView");
        [self.view addSubview:_viewGonggao];
        [_viewGonggao setHidden:YES];
    }
    return _viewGonggao;
}

- (SDCycleScrollView *)viewCycle{
    if (nil==_viewCycle) {
        
        _viewCycle = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, skScreenWidth, 200) delegate:self placeholderImage:[UIImage imageNamed:@""]];
        
        [self.viewImage.imageContainView addSubview:_viewCycle];
        
        [_viewCycle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_topLayoutGuide);
            make.left.right.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(skScreenWidth, 200));
        }];
        
        _viewCycle.pageControlBottomOffset=20;
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
            make.size.mas_equalTo(CGSizeMake(skScreenWidth, 200));
        }];
        
        @weakify(self)
        [[_viewImage.btnBack rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [_viewImage.btnBack skSetBoardRadius:17 Width:0 andBorderColor:nil];
        [_viewImage.btnMore skSetBoardRadius:17 Width:0 andBorderColor:nil];
        [_viewImage.btnBuy skSetBoardRadius:5 Width:0 andBorderColor:nil];
        if (self.model.memberType==1) {
            [_viewImage.btnBuy setTitle:@"设置" forState:(UIControlStateNormal)];
        }else{
            [_viewImage.btnBuy setTitle:@"响应" forState:(UIControlStateNormal)];
        }
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
            if (self.model.memberType==1) {
                skActivityDesViewController *view=[[skActivityDesViewController alloc] init];
                view.modelOther=[self.arrList objectAtIndex:self.indexSelect];
                [self.navigationController pushViewController:view animated:YES];
            }else{
                //响应
            }
            
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
    [self bizGroupgetGroup];//查询群信息
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.indexSelect=0;
    [self bizGoodsMyGoods];//查询群活动
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//- (void)didTapCellPortrait:(NSString *)userId{
//    if ([skUser.userNo isEqualToString:self.model.createUserNo]) {
//        [super didTapCellPortrait:userId];
//        skFriendDesViewController *view=[[skFriendDesViewController alloc] init];
//        view.skDataNeed0 = userId;
//        view.skDataNeed1 =[NSNumber numberWithInteger:self.model.groupId];
//        [self.navigationController pushViewController:view animated:YES];
//    }
//}

//获取群的详情信息
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

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    groupOnerActivityModel *model=[self.arrList objectAtIndex:index];
    self.viewImage.labTitle.text=model.goodsName;
    self.indexSelect=index;
}
//获取群的活动列表信息
-(void)bizGoodsMyGoods{
    ///intf/bizUser/sendRegister
    NSDictionary *dic=@{@"groupNo":self.targetId,
                        @"page":@"0",
                        @"rows":@"3"
                        };
    
    
    [skAfTool SKPOST:skUrl(@"/intf/bizGoods/myGroupGoods") pubParame:skPubParType(0) busParame:[dic skDicToJson:dic] showHUD:NO showErrMsg:NO success:^(skResponeModel *  _Nullable responseObject) {
        
        if (responseObject.returnCode==0) {
            
            skResponeList *modelList=[skResponeList mj_objectWithKeyValues:responseObject.data];
            
            self.arrList=[groupOnerActivityModel mj_objectArrayWithKeyValuesArray:modelList.list];
            
            
            [self getNewest];
            
        }else{
        }
        
    } failure:^(NSError * _Nullable error) {
    }];
}
/**
 获取公告最新的一条
 */
-(void)getNewest{
    ///intf/bizUser/sendRegister
    NSDictionary *dic=@{@"groupNo":self.targetId,
                        };
    [skAfTool SKPOST:skUrl(@"/intf/bizGroupNotice/getNewest") pubParame:skPubParType(0) busParame:[dic skDicToJson:dic] showHUD:NO showErrMsg:NO success:^(skResponeModel *  _Nullable responseObject) {
        
        if (responseObject.returnCode==0) {
            
            NSMutableArray *arrImage=[[NSMutableArray alloc] init];
            for (int i =0; i<self.arrList.count; ++i) {
                groupOnerActivityModel *model=[self.arrList objectAtIndex:i];
                [arrImage addObject:model.goodsPic];
            }
            self.viewCycle.imageURLStringsGroup = arrImage;
            
            chatGonggaoModel *gonggaoModel=[chatGonggaoModel mj_objectWithKeyValues:responseObject.data];
            
            NSArray *loopArrs;
            
            
            
            [self.viewGonggao.viewContain addSubview:self.paoView];
            if (self.arrList.count>0) {
                [self.conversationMessageCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(self.viewImage.mas_bottom);
                    make.bottom.mas_equalTo(self.mas_bottomLayoutGuide);
                    make.right.left.mas_equalTo(0);
                }];
                [self viewCycle];
                [self.viewCycle setHidden:NO];
                [self.viewImage setHidden:NO];
                
                
                if (gonggaoModel.noticeContent.length>0) {
                    loopArrs = [NSArray arrayWithObjects:gonggaoModel.noticeContent,nil];
                }else{
                    loopArrs = [NSArray arrayWithObjects:@"群主暂无发布公告",nil];
                }
            }else{
                [self.conversationMessageCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(self.mas_topLayoutGuide);
                    make.bottom.mas_equalTo(self.mas_bottomLayoutGuide);
                    make.right.left.mas_equalTo(0);
                }];
                [self.viewCycle setHidden:YES];
                [self.viewImage setHidden:YES];
                
                if (gonggaoModel.noticeContent.length>0) {
                    loopArrs = [NSArray arrayWithObjects:gonggaoModel.noticeContent,nil];
                }else{
                    loopArrs = [NSArray arrayWithObjects:@"群主暂无发布公告",nil];
                }
            }
            [self.viewGonggao mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.conversationMessageCollectionView.mas_top);
                make.right.left.mas_equalTo(0);
                make.height.mas_equalTo(24);
            }];
            [self.viewGonggao setHidden:NO];
            [self.paoView setTickerArrs:loopArrs];
            
        }else{
        }
        
    } failure:^(NSError * _Nullable error) {
    }];
}


- (void)dealloc
{
    NSLog(@"聊天界面销毁了");
}
@end
