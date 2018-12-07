//
//  skGroupChatHeadersTableViewCell.m
//  SkyerChat
//
//  Created by admin on 2018/10/31.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import "skGroupChatHeadersTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>


#define KCellID @"skGroupChatHeadersViewID"
#define KHedderID @"skGroupChatHeadersViewHedderID"
#define KFooterID @"skGroupChatHeadersViewFooterID"

@implementation skGroupChatHeadersTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(skGroupMoreView *)viewMore{
    if (nil==_viewMore) {
        _viewMore=skXibView(@"skGroupMoreView");
        [_viewMore mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(skScreenWidth, 40));
        }];
    }
    return _viewMore;
}
-(UICollectionView *)collectionView{
    if (nil==_collectionView) {
        //1.初始化layout
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //设置collectionView滚动方向
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        //设置headerView的尺寸大小
        layout.headerReferenceSize = CGSizeMake(self.frame.size.width, 20);
        //设置尾部的尺寸大小
//        layout.footerReferenceSize = CGSizeMake(self.frame.size.width, 30);
//        该方法也可以设置itemSize
        
        
        layout.itemSize =CGSizeMake((skScreenWidth-60)/5, 60);
        _collectionView=[[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        
        [self.contentView addSubview:_collectionView];
        [_collectionView setBackgroundColor:[UIColor whiteColor]];
        
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.right.left.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
        //3.注册collectionViewCell
        //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:KCellID];
        //注册headerView  此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致  均为reusableView
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:KHedderID];
        
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:KFooterID];
        _collectionView.bounces = NO;
        //4.设置代理
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}
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
    if (self.arrModelList.count<=8) {
        return self.arrModelList.count+2;
    }else{
        return 10;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    /*
     static NSString *cellIdentifier = @"AddressListTableViewCell";
     AddressListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
     if (cell == nil) {
     cell = skXibView(@"AddressListTableViewCell");
     }
     */
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KCellID forIndexPath:indexPath];
    
    for (UIView *view in cell.contentView.subviews) {
        if (view) {
            [view removeFromSuperview];
        }
    }
    
    UIImageView *imageHeaderView=[[UIImageView alloc] init];
    [cell.contentView addSubview:imageHeaderView];
    [imageHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.centerX.mas_equalTo(cell.contentView.mas_centerX);
        make.centerY.mas_equalTo(cell.contentView.mas_centerY);
    }];
    if (indexPath.row<self.arrModelList.count) {
        groupUserModel *model=[self.arrModelList objectAtIndex:indexPath.row];
        [imageHeaderView sd_setImageWithURL:[NSURL URLWithString:model.portrait] placeholderImage:[UIImage imageNamed:@"default_portrait_msg"]];
    }else if(indexPath.row==self.arrModelList.count){
        [imageHeaderView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"jia"]];
    }else{
        [imageHeaderView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"jian"]];
    }
    
    
    [imageHeaderView skSetBoardRadius:25 Width:1 andBorderColor:[UIColor whiteColor]];

    
    
    return cell;
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((skScreenWidth-60)/5, 60);
}

//footer的size
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
//{
//    return CGSizeMake(10, 10);
//}

//header的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(skScreenWidth , 40);
}

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
        
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:KHedderID forIndexPath:indexPath];
        
        [headerView addSubview:self.viewMore];
        return headerView;
    }
    
    return nil;
}

//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了=%ld",indexPath.row);
    [self skDidSelectItemAtIndexPath:indexPath];
}
-(void)skDidSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
