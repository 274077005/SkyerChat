//
//  skAddressBookViewController.m
//  SkyerChat
//
//  Created by admin on 2018/10/26.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import "skAddressBookViewController.h"
#import "SkPageViews.h"
#import "SkChildViews.h"
#import "skGroupListViewController.h"
#import "skMyClientViewController.h"
#import "AddressBookTitleView.h"


@interface skAddressBookViewController ()
@property (nonatomic,strong) SkChildViews *viewChild;
@property (nonatomic,strong) AddressBookTitleView *viewTitle;

@end

@implementation skAddressBookViewController
- (AddressBookTitleView *)viewTitle{
    
    if (nil==_viewTitle) {
        _viewTitle=skXibView(@"AddressBookTitleView");
        [_viewTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(skScreenWidth-140, 30));
        }];
        @weakify(self)
        [[_viewTitle.btnQun rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            NSLog(@"群聊");
            [self labSize];
            [self.viewChild skChangVeiw:0];
        }];
        [[_viewTitle.btnKehu rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            NSLog(@"客户");
            [self labSize];
            [self.viewChild skChangVeiw:1];
        }];
    }
    return _viewTitle;
}
-(void)labSize{
    
    [self.viewTitle.labQun setHidden:!self.viewTitle.labQun.isHidden];
    [self.viewTitle.btnQun setTitleColor:self.viewTitle.labQun.isHidden?[UIColor lightTextColor]:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self.viewTitle.labKehu setHidden:!self.viewTitle.labKehu.isHidden];
    [self.viewTitle.btnKehu setTitleColor:self.viewTitle.labKehu.isHidden?[UIColor lightTextColor]:[UIColor whiteColor] forState:(UIControlStateNormal)];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView=self.viewTitle;
    // Do any additional setup after loading the view.
    skGroupListViewController *view0=[[skGroupListViewController alloc] init];
    skMyClientViewController *view1=[[skMyClientViewController alloc] init];
    
    
    self.viewChild=[[SkChildViews alloc] initWithChildViews:@[view0,view1] andTag:self andOption:(UIViewAnimationOptionLayoutSubviews)];
    
    [self.viewChild skChangVeiw:0];
    
    
}





@end
