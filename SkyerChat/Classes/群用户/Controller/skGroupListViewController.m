//
//  skAddressBookViewController.m
//  SkyerChat
//
//  Created by admin on 2018/10/10.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "skGroupListViewController.h"
#import "skAddressBookTableViewCell.h"
#import "skAddressBookSearch.h"
#import "skAddressBookModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

#import "skGroupModel.h"
#import "PersonalTableViewCell.h"
#import "skGroupChatViewController.h"
#import "skMyClientViewController.h"


@interface skGroupListViewController ()
@property (nonatomic,strong) NSArray *arrList;
@property (nonatomic,strong) skAddressBookSearch *viewSearch;
@property (nonatomic,strong) skAddressBookModel *model;
@property (nonatomic,strong) NSMutableArray <skGroupModel *>*arrGroupList;
@property (nonatomic,assign) NSInteger rowGroup;

@end

@implementation skGroupListViewController

- (NSMutableArray *)arrGroupList{
    if (nil==_arrGroupList) {
        _arrGroupList=[[NSMutableArray alloc] init];
        
    }
    return _arrGroupList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.title=@"通讯录";
    [self addTableView];
    
    [self bizGroupMyGroup];
    
    [self createRefreshHeaderViewWithBlock:^{
        self.rowGroup=0;
        [self bizGroupMyGroup];
    }];
    [self createRefreshFooterViewWithBlock:^{
        self.rowGroup+=10;
        [self bizGroupMyGroup];
    }];
    
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
    return self.arrGroupList.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 30;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.viewSearch;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UILabel *labTitel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, skScreenWidth, 30)];
    labTitel.text=[NSString stringWithFormat:@"拥有%ld个群组",self.arrGroupList.count];
    labTitel.font=[UIFont systemFontOfSize:15];
    labTitel.textColor=[UIColor whiteColor];
    labTitel.textAlignment=1;
    labTitel.backgroundColor=skUIColorFromRGB(0xEEEEEE);
    return labTitel;
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"skAddressBookTableViewCell";
    skAddressBookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = skXibView(@"skAddressBookTableViewCell");
    }
    skGroupModel *model=self.arrGroupList[indexPath.row];
    
    [cell.imageTitle sd_setImageWithURL:[NSURL URLWithString:model.groupNo] placeholderImage:[UIImage imageNamed:@"default_group_portrait"]];
    
    cell.labTitle.text=model.groupName;
    
    cell.labMessage.text = model.groupNo;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    skGroupModel *model1=[self.arrGroupList objectAtIndex:indexPath.row];
    skGroupChatViewController *view=[[skGroupChatViewController alloc] initWithConversationType:(ConversationType_GROUP) targetId:model1.groupNo];
    
    view.title=model1.groupName;
    
    [skVSView.navigationController pushViewController:view animated:YES];
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
            
            self.arrList= [skAddressBookModel mj_objectArrayWithKeyValuesArray:modelList.list];
            
            [self.tableView reloadData];
            
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}


-(void)bizGroupMyGroup{
    NSDictionary *dic=@{@"page":@"0",
                        @"rows":[NSNumber numberWithInteger:self.rowGroup]
                        };
    
    
    [skAfTool SKPOST:skUrl(@"/intf/bizGroup/myGroups") pubParame:skPubParType(0) busParame:[dic skDicToJson:dic] showHUD:NO showErrMsg:NO success:^(skResponeModel *  _Nullable responseObject) {
        [self footerEndRefreshing];
        [self headerEndRefreshing];
        if (responseObject.returnCode==0) {
            
            skResponeList *modelList=[skResponeList mj_objectWithKeyValues:responseObject.data];
            
            self.arrGroupList=[skGroupModel mj_objectArrayWithKeyValuesArray:modelList.list];
            [self.tableView reloadData];
        }
        
    } failure:^(NSError * _Nullable error) {
        [self footerEndRefreshing];
        [self headerEndRefreshing];
    }];
}

@end
