//
//  skAddressBookViewController.m
//  SkyerChat
//
//  Created by admin on 2018/10/10.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "skAddressBookViewController.h"
#import "skAddressBookTableViewCell.h"
#import "skAddressBookSearch.h"
#import "skAddressBookModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "skAddFriendViewController.h"

@interface skAddressBookViewController ()
@property (nonatomic,strong) NSArray *arrList;
@property (nonatomic,strong) skAddressBookSearch *viewSearch;
@end

@implementation skAddressBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"通讯录";
    
    @weakify(self)
    [[[self skCreatBtn:@"bar-更多-白" btnTitleOrImage:(btntypeImage) btnLeftOrRight:(btnStateRight)] rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        skAddFriendViewController *view=[[skAddFriendViewController alloc] init];
        [self.navigationController pushViewController:view animated:YES];
    }];
    
    [self addTableView];
    [self getAddressBookList:@""];
    
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
-(skAddressBookSearch *)viewSearch{
    if (nil==_viewSearch) {
        _viewSearch=skXibView(@"skAddressBookSearch");
        @weakify(self)
        [[_viewSearch.txtSearch rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
            @strongify(self)
            if (x.length>0) {
                [self getAddressBookList:x];
            }
        }];
    }
    return _viewSearch;
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
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.viewSearch;
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"skAddressBookTableViewCell";
    skAddressBookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = skXibView(@"skAddressBookTableViewCell");
    }
    skAddressBookModel *model=self.arrList[indexPath.row];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.portrait] placeholderImage:[UIImage imageNamed:@"touxian"]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


/**
 获取通讯录列表

 @param keyword 关键字
 */
-(void)getAddressBookList:(NSString *)keyword{
    
    NSDictionary *dic=@{@"keyword":keyword};
    
    [skAfTool SKPOST:skUrl(@"/intf/bizLinker/list") pubParame:skPubParType(0) busParame:[dic skDicToJson:dic] showHUD:NO showErrMsg:NO success:^(skResponeModel *  _Nullable responseObject) {
        
        if (responseObject.returnCode==0) {
            
            skResponeList *modelList=[skResponeList mj_objectWithKeyValues:responseObject.data];
            
            self.arrList= [skAddressBookModel mj_keyValuesArrayWithObjectArray:modelList.list];
            
            [self.tableView reloadData];
            
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}
@end
