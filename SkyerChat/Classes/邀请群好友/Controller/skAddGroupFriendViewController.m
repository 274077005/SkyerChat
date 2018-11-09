//
//  skAddGroupFriendViewController.m
//  SkyerChat
//
//  Created by skyer on 2018/11/8.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import "skAddGroupFriendViewController.h"
#import "skLookoverTableViewCell.h"

@interface skAddGroupFriendViewController ()
@property (nonatomic,strong) NSArray *arrList;
@property (nonatomic,assign) Boolean isMore;
@property (nonatomic,strong) NSMutableArray *arrSelect;
@property (nonatomic,strong) UIButton *btnRight;
@end

@implementation skAddGroupFriendViewController
- (NSMutableArray *)arrSelect{
    if (nil==_arrSelect) {
        _arrSelect=[[NSMutableArray alloc] init];
    }
    return _arrSelect;
}
-(UIButton *)btnRight{
    if (nil==_btnRight) {
        _btnRight=[self skCreatBtn:@"多选" btnTitleOrImage:(btntypeTitle) btnLeftOrRight:(btnStateRight)];
        @weakify(self)
        [[_btnRight rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            self.isMore=!self.isMore;
            if (self.arrSelect.count>0) {
                [skClassMethod skAlertView:@"邀请客户加入群聊" alertViewMessage:@"邀请选中的客户加入群聊" cancleTitle:@"取消" defaultTitle:@"确定" cancleHandler:^(UIAlertAction * _Nonnull action) {
                    [self.arrSelect removeAllObjects];
                    [self.tableView reloadData];
                } sureHandler:^(UIAlertAction * _Nonnull action) {
                    
                }];
            }else{
                [self.btnRight setTitle:@"多选" forState:(UIControlStateNormal)];
                [self.tableView reloadData];
            }
            
        }];
    }
    return _btnRight;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"邀请好友入群";
    // Do any additional setup after loading the view.
    [self addTableView];
    [self.btnRight setTitle:@"多选" forState:(UIControlStateNormal)];
}
-(void)addTableView{
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor=KcolorBackground;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop);
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
#pragma mark - 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 15;
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"skLookoverTableViewCell";
    skLookoverTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = skXibView(@"skLookoverTableViewCell");
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
