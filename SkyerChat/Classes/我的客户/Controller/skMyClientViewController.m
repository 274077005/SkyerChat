//
//  skMyClientViewController.m
//  SkyerChat
//
//  Created by admin on 2018/10/25.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import "skMyClientViewController.h"
#import "myClientModel.h"
#import "myClientTableViewCell.h"
#import "myClientModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "skSingleChatViewController.h"
#import "skAddressBookSearch.h"
@interface skMyClientViewController ()
@property (nonatomic,strong) NSArray *arrList;
@property (nonatomic,strong) skAddressBookSearch *viewSearch;
@end

@implementation skMyClientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"客户";
    [self addTableView];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
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
            [self getAddressBookList:x];
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
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 30;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.viewSearch;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UILabel *labTitel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, skScreenWidth, 30)];
    labTitel.text=[NSString stringWithFormat:@"拥有%ld个客户",self.arrList.count];
    labTitel.font=[UIFont systemFontOfSize:15];
    labTitel.textColor=[UIColor whiteColor];
    labTitel.textAlignment=1;
    labTitel.backgroundColor=KcolorBackground;
    return labTitel;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"myClientTableViewCell";
    myClientTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = skXibView(@"myClientTableViewCell");
    }
    myClientModel *model=[self.arrList objectAtIndex:indexPath.row];
    
    cell.labNikeName.text=model.nickName.length>0?model.nickName:model.userNo;
    [cell.imageTitle sd_setImageWithURL:[NSURL URLWithString:model.portrait] placeholderImage:[UIImage imageNamed:@"default_portrait_msg"]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    myClientModel *model=[self.arrList objectAtIndex:indexPath.row];
    skSingleChatViewController *view=[[skSingleChatViewController alloc] initWithConversationType:(ConversationType_PRIVATE) targetId:model.userNo];
    view.title=[model.nickName length]>0?model.nickName:model.userNo;
    [self.navigationController pushViewController:view animated:YES];
}
/**
 获取通讯录列表
 
 @param keyword 关键字
 */
-(void)getAddressBookList:(NSString *)keyword{
    NSDictionary *dic=@{@"keywordss":keyword};
    if (keyword.length>0) {
        dic=@{@"keyword":keyword};
    }
    
    
    [skAfTool SKPOST:skUrl(@"/intf/bizLinker/list") pubParame:skPubParType(0) busParame:[dic skDicToJson:dic] showHUD:NO showErrMsg:NO success:^(skResponeModel *  _Nullable responseObject) {
        
        if (responseObject.returnCode==0) {
            
            skResponeList *modelList=[skResponeList mj_objectWithKeyValues:responseObject.data];
            
            self.arrList= [myClientModel mj_objectArrayWithKeyValuesArray:modelList.list];
            
            [self.tableView reloadData];
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}
@end
