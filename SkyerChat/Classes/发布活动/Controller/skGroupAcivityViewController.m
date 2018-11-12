//
//  skGroupAcivityViewController.m
//  SkyerChat
//
//  Created by skyer on 2018/11/12.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import "skGroupAcivityViewController.h"
#import "ActivityView.h"
@interface skGroupAcivityViewController ()
@property (nonatomic ,strong) ActivityView *viewActivity;
@end

@implementation skGroupAcivityViewController
- (ActivityView *)viewActivity{
    if (nil==_viewActivity) {
        _viewActivity=skXibView(@"ActivityView");
    }
    return _viewActivity;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.viewActivity];
    self.title=@"发布活动";
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
