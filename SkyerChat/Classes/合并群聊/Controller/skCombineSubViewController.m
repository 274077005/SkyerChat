//
//  skCombineSubViewController.m
//  SkyerChat
//
//  Created by skyer on 2018/12/28.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import "skCombineSubViewController.h"
#import "CombineGroupInfoView.h"

@interface skCombineSubViewController ()
@property (nonatomic,strong) CombineGroupInfoView *viewCombine;
@end

@implementation skCombineSubViewController
-(CombineGroupInfoView *)viewCombine{
    if (nil==_viewCombine) {
        _viewCombine=skXibView(@"CombineGroupInfoView");
        [self.view addSubview:_viewCombine];
        [_viewCombine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.top.mas_equalTo(0);
        }];
    }
    return _viewCombine;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self viewCombine];
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
