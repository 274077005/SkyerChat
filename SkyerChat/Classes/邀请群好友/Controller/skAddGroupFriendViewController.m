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
            if (self.arrSelect.count>0) {
                
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
    [self.btnRight setTitle:@"确定(0)" forState:(UIControlStateNormal)];
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

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrList.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"skLookoverTableViewCell";
    skLookoverTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = skXibView(@"skLookoverTableViewCell");
    }
    [cell setAccessoryType:(UITableViewCellAccessoryNone)];
    [cell.imageSelect setHidden:NO];
    [cell.labType setHidden:YES];
    
    NSString *row=[NSString stringWithFormat:@"%ld",indexPath.row];
    if ([self.arrSelect containsObject:row]) {
        [cell.imageSelect setImage:[UIImage imageNamed:@"多选-选中"]];
    }else{
        [cell.imageSelect setImage:[UIImage imageNamed:@"多选-未选"]];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *row=[NSString stringWithFormat:@"%ld",indexPath.row];
    if (![self.arrSelect containsObject:row]) {
        [self.arrSelect addObject:row];
    }else{
        [self.arrSelect removeObject:row];
    }
    [self.btnRight setTitle:[NSString stringWithFormat:@"确定(%ld)",self.arrSelect.count] forState:(UIControlStateNormal)];
    [self.tableView reloadData];
}
@end
