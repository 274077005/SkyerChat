//
//  skSellerViewController.m
//  SkyerChat
//
//  Created by skyer on 2019/1/13.
//  Copyright © 2019 www.skyer.com. All rights reserved.
//

#import "skSellerViewController.h"
#import "LXScrollContentView.h"
#import "LXSegmentTitleView.h"
#import "skSellerViewController1.h"
#import "skSellerViewController2.h"
#import "skSellerViewController3.h"

@interface skSellerViewController ()<LXSegmentTitleViewDelegate,LXScrollContentViewDelegate>
@property (nonatomic, strong) LXSegmentTitleView *titleView;

@property (nonatomic, strong) LXScrollContentView *contentView;
@end

@implementation skSellerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self reloadData];
    self.title=@"商家订单管理";
}

- (void)setupUI{
    self.titleView = [[LXSegmentTitleView alloc] initWithFrame:CGRectZero];
    self.titleView.itemMinMargin = 15.f;
    self.titleView.delegate = self;
    self.titleView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    [self.view addSubview:self.titleView];
    
    self.contentView = [[LXScrollContentView alloc] initWithFrame:CGRectZero];
    self.contentView.delegate = self;
    [self.view addSubview:self.contentView];
}

- (void)segmentTitleView:(LXSegmentTitleView *)segmentView selectedIndex:(NSInteger)selectedIndex lastSelectedIndex:(NSInteger)lastSelectedIndex{
    self.contentView.currentIndex = selectedIndex;
}

- (void)contentViewDidScroll:(LXScrollContentView *)contentView fromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex progress:(float)progress{
    
}

- (void)contentViewDidEndDecelerating:(LXScrollContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex{
    self.titleView.selectedIndex = endIndex;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.titleView.frame = CGRectMake(0, 0, self.view.frame.size.width, 35);
    self.contentView.frame = CGRectMake(0, 35, self.view.frame.size.width, self.view.frame.size.height - 35);
}

- (void)reloadData{
    NSArray *titles = @[@"未支付",@"待收货",@"已完成"];
    self.titleView.segmentTitles = titles;
    NSMutableArray *vcs = [[NSMutableArray alloc] init];
    for (int i = 0; i<titles.count; ++i) {
        switch (i) {
            case 0:
            {
                skSellerViewController1 *vc = [[skSellerViewController1 alloc] init];
                [vcs addObject:vc];
                //                vc.view.backgroundColor=[UIColor redColor];
                vc.title = [titles objectAtIndex:i];
            }
                break;
            case 1:
            {
                skSellerViewController2 *vc = [[skSellerViewController2 alloc] init];
                [vcs addObject:vc];
                //                vc.view.backgroundColor=[UIColor greenColor];
                vc.title = [titles objectAtIndex:i];
            }
                break;
            case 2:
            {
                skSellerViewController3 *vc = [[skSellerViewController3 alloc] init];
                [vcs addObject:vc];
                //                vc.view.backgroundColor=[UIColor yellowColor];
                vc.title = [titles objectAtIndex:i];
            }
                break;
                
            default:
                break;
        }
        
        
        
    }
    [self.contentView reloadViewWithChildVcs:vcs parentVC:self];
    self.titleView.selectedIndex = 0;
    self.contentView.currentIndex = 0;
}
@end
