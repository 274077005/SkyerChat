//
//  skGonggaoViewController.m
//  SkyerChat
//
//  Created by admin on 2018/11/15.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import "skGonggaoViewController.h"
#import "gonggaoView.h"


@interface skGonggaoViewController ()
@property (nonatomic,strong) gonggaoView *viewGonggao;
@end

@implementation skGonggaoViewController
- (gonggaoView *)viewGonggaoP{
    if (nil==_viewGonggao) {
        _viewGonggao=skXibView(@"gonggaoView");
        [self.view addSubview:_viewGonggao];
    }
    return _viewGonggao;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self viewGonggao];
    
    @weakify(self)
    [[[self skCreatBtn:@"发布" btnTitleOrImage:(btntypeTitle) btnLeftOrRight:(btnStateRight)] rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        
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
