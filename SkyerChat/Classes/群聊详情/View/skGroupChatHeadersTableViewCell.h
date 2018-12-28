//
//  skGroupChatHeadersTableViewCell.h
//  SkyerChat
//
//  Created by admin on 2018/10/31.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "groupUserModel.h"
#import "skGroupMoreView.h"
#import "GroupDesModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface skGroupChatHeadersTableViewCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) GroupDesModel *modelG;
@property (nonatomic,strong) NSArray *arrModelList;
@property (nonatomic,strong) skGroupMoreView *viewMore;
-(void)skDidSelectItemAtIndexPath:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
