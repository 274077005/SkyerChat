//
//  MyActivictViewsTableViewCell.h
//  SkyerChat
//
//  Created by skyer on 2018/12/17.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyActivictViewsTableViewCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) UICollectionView *collectionView;
@end

NS_ASSUME_NONNULL_END
