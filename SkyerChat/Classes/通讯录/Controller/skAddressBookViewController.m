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
#import "skAddFriendViewController.h"
#import "skMenuViewController.h"

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
    
    @weakify(self)
    [[[self skCreatBtn:@"bar-更多-白" btnTitleOrImage:(btntypeImage) btnLeftOrRight:(btnStateRight)] rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        
        
        
        skMenuViewController *viewCharge=[[skMenuViewController alloc] init];
        //关键语句，必须有
        viewCharge.arrTitle=@[@"新建聊天群",@"合并聊天群",@"添加好友"];
        viewCharge.view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.1];
        viewCharge.modalPresentationStyle = UIModalPresentationOverFullScreen;
        [viewCharge setChargeType:^(NSInteger index) {
            NSLog(@"%ld",index);
            switch (index) {
                case 0:
                {
                    
                }
                    break;
                case 1:
                {
                    
                }
                    break;
                case 2:
                {
                    skAddFriendViewController *view=[[skAddFriendViewController alloc] init];
                    [self.navigationController pushViewController:view animated:YES];
                }
                    break;
                case 3:
                {
                    
                }
                    break;
                case 4:
                {
                    
                }
                    break;
                    
                default:
                    break;
            }
        }];
        [skVSView presentViewController:viewCharge animated:NO completion:^(void){
            
        }];
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
