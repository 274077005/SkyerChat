//
//  skBaseViewController.m
//  SkyerParking
//
//  Created by admin on 2018/6/28.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "skBaseViewController.h"

@interface skBaseViewController ()



@end

@implementation skBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"skBase界面加载%@",self);
    [self initView];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    NSLog(@"skBase界面出现%@",self);
}
-(void)dealloc{
    NSLog(@"skBase界面销毁%@",self);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 初始化页面信息
 */
-(void)initView{
    self.view.backgroundColor=[UIColor whiteColor];
}

#pragma mark - 初始化UITableView
// 更换TableViewStyle 想用 UITableViewStyleGrouped 在继承视图中重写此方法
-(UITableViewStyle)tableViewStyle{
    return UITableViewStylePlain;
}
/**
 懒加载UItableview

 @return tableView
 */
-(UITableView *)tableView{
    if (nil==_tableView) {
        _tableView=[[UITableView alloc] initWithFrame:self.view.bounds style:self.tableViewStyle];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
    }
    return _tableView;
}

#pragma mark - UITableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *baseCellIdentifier = @"baseCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:baseCellIdentifier];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:baseCellIdentifier];
    }
    
    return cell;
}
#pragma mark - 上下拉加载
//创建下拉刷新试图
- (void)createRefreshHeaderViewWithBlock:(void (^)(void))completion
{
    self.tableView.mj_header = [MJRefreshNormalHeader  headerWithRefreshingBlock:^{
        completion();
    }];
    _headerView = self.tableView.mj_header;
}
- (void)headerEndRefreshing{
    [self.tableView.mj_header endRefreshing];
}

//创建上拉加载试图
- (void)createRefreshFooterViewWithBlock:(void (^)(void))completion
{
    self.tableView.mj_footer = [MJRefreshBackNormalFooter  footerWithRefreshingBlock:^{
        completion();
    }];
    _footerView = self.tableView.mj_footer;
}
- (void)footerEndRefreshing{
    [self.tableView.mj_footer endRefreshing];
}

- (void)headerRefreshData
{
    NSLog(@"下拉刷新");
}

- (void)footerRefreshData
{
    NSLog(@"上拉加载");
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

@end
