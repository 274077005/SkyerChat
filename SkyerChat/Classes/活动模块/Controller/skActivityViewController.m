//
//  skActivityViewController.m
//  SkyerChat
//
//  Created by admin on 2018/10/10.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "skActivityViewController.h"
#import "SDCycleScrollView.h"
#import "viewShop.h"
#import "activityModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "skActivityDesViewController.h"
#import "skSubmitOrderViewController.h"


@interface skActivityViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,SDCycleScrollViewDelegate>
@property (nonatomic,strong) UICollectionView *collectionView;


@property (nonatomic,strong) NSArray *arrList;

@property (nonatomic,assign) NSInteger rows;

@property (nonatomic,strong) NSArray *arrListActivivt;

@end

@implementation skActivityViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.collectionView];
    
    self.title=@"活动";
    [self myGroupGoods];
    self.collectionView.mj_header = [MJRefreshNormalHeader  headerWithRefreshingBlock:^{
        self.rows=10;
        [self myGroupGoods];
    }];
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter  footerWithRefreshingBlock:^{
        self.rows+=10;
        [self myGroupGoods];
    }];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:animated];

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
-(UICollectionView *)collectionView{
    if (nil==_collectionView) {
        //1.初始化layout
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //设置collectionView滚动方向
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        //设置headerView的尺寸大小
        layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 0);
        //设置尾部的尺寸大小
//        layout.footerReferenceSize = CGSizeMake(self.view.frame.size.width, 137);
        //该方法也可以设置itemSize
        layout.itemSize =CGSizeMake((skScreenWidth-30)/2, 180);
        _collectionView=[[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.backgroundColor=KcolorBackground;
        [self.view addSubview:_collectionView];
        
        
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
            make.right.left.mas_equalTo(0);
            make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop);
        }];
        //3.注册collectionViewCell
        //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
        //注册headerView  此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致  均为reusableView
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderReusableView"];
        
//        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterReusableView"];
        
        //4.设置代理
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark mark - 代理方法UICollectionReusableView
#pragma mark collectionView代理方法
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.arrListActivivt.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    
    for (UIView *view in cell.contentView.subviews) {
        if (view) {
            [view removeFromSuperview];
        }
    }
    
    activityModel *model=[self.arrListActivivt objectAtIndex:indexPath.row];
    
    viewShop *viewS=skXibView(@"viewShop");
    [viewS.imageShop sd_setImageWithURL:[NSURL URLWithString:model.goodsPic] placeholderImage:[UIImage imageNamed:@""]];
    viewS.labNameShop.text=model.goodsName;
    viewS.labPriceShop.text=[NSString stringWithFormat:@"%ld",model.goodsPrice];
    
    
    viewS.frame=cell.bounds;
    [cell.contentView addSubview:viewS];
    return cell;
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((skScreenWidth-30)/2, 180);
}

//footer的size
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
//{
//    return CGSizeMake(10, 10);
//}

//header的size
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
//{
//    return CGSizeMake(10, 10);
//}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}


//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}


//通过设置SupplementaryViewOfKind 来设置头部或者底部的view，其中 ReuseIdentifier 的值必须和 注册是填写的一致，本例都为 “reusableView”
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind ==UICollectionElementKindSectionHeader){
        
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderReusableView" forIndexPath:indexPath];
    
        return headerView;
    }
    
//    if (kind ==UICollectionElementKindSectionFooter) {
//        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterReusableView" forIndexPath:indexPath];
//
//        return headerView;
//    }
    return nil;
}

//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了=%ld",indexPath.row);
    activityModel *model=[self.arrListActivivt objectAtIndex:indexPath.row];
    skActivityDesViewController *view=[[skActivityDesViewController alloc] init];
    view.modelOther=model;
    [self.navigationController pushViewController:view animated:YES];
}



-(void)myGroupGoods{
    ///intf/bizUser/sendRegister
    NSDictionary *dic=@{
                        @"page":[NSNumber numberWithInteger:1],
                        @"rows":[NSNumber numberWithInteger:self.rows]
                        };
    
    
    [skAfTool SKPOST:skUrl(@"/intf/bizGoods/myGroupGoods") pubParame:skPubParType(0) busParame:[dic skDicToJson:dic] showHUD:YES showErrMsg:YES success:^(skResponeModel *  _Nullable responseObject) {
        
        if (responseObject.returnCode==0) {
            [self.collectionView.mj_footer endRefreshing];
            [self.collectionView.mj_header endRefreshing];
            
            skResponeList *modelList=[skResponeList mj_objectWithKeyValues:responseObject.data];
            
            self.arrListActivivt=[activityModel mj_objectArrayWithKeyValuesArray:modelList.list];
            
            [self.collectionView reloadData];
        }
        
    } failure:^(NSError * _Nullable error) {
        [self.collectionView.mj_footer endRefreshing];
        [self.collectionView.mj_header endRefreshing];
    }];
}
@end
