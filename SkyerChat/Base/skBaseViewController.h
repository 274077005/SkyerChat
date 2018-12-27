//
//  skBaseViewController.h
//  SkyerParking
//
//  Created by admin on 2018/6/28.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"

typedef NS_ENUM(NSInteger, btntype)
{
    btntypeTitle = 0,
    btntypeImage,
};
typedef NS_ENUM(NSInteger, btnState)
{
    btnStateLeft = 0,
    btnStateRight,
};


@interface skBaseViewController : UIViewController <UITableViewDelegate ,UITableViewDataSource>

#pragma mark - 这部分是UITableView的
@property (nonatomic,strong) id skDataNeed0;
@property (nonatomic,strong) id skDataNeed1;
@property (nonatomic,strong) id skDataNeed2;
@property (nonatomic,strong) id skDataNeed3;
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic,strong,readonly) MJRefreshFooter * footerView;
@property (nonatomic,strong,readonly) MJRefreshHeader * headerView;

/*
 * 更换TableViewStyle 想用 UITableViewStyleGrouped 在继承视图中重写此方法
 */

- (UITableViewStyle)tableViewStyle;

/**
 创建下拉刷新

 @param completion 下拉里面要处理
 */
- (void)createRefreshHeaderViewWithBlock:(void (^)(void))completion;

/**
 结束头部下拉刷新
 */
- (void)headerEndRefreshing;

/**
 创建上拉刷新

 @param completion 上拉刷新处理
 */
- (void)createRefreshFooterViewWithBlock:(void (^)(void))completion;

/**
 结束上拉刷新
 */
- (void)footerEndRefreshing;
#pragma mark - 这部分是导航栏的

/**
 设置导航栏左右按钮

 @param title 标题或者图片的名称
 @param TitleOrImage 设置的是标题还是图片
 @param LeftOrRight 设置的左边按钮还是右边按钮
 @return 返回一个按钮
 */
-(UIButton *)skCreatBtn:(NSString *)title btnTitleOrImage:(btntype)TitleOrImage btnLeftOrRight:(btnState)LeftOrRight;
@end
