//
//  skGroupMenberListViewController.m
//  SkyerChat
//
//  Created by skyer on 2018/12/7.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import "skGroupMenberListViewController.h"
#import "groupUserModel.h"
#import "skLookoverTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "skSingleChatViewController.h"
#import "GroupMenberListModel.h"
#import "GroupWithTypeView.h"

@interface skGroupMenberListViewController ()

@property (nonatomic,strong) NSArray *arrGroupList;
@property (nonatomic,strong) NSArray *arrGroupContainList;
@property (nonatomic,strong) NSArray *arrList;

@end

@implementation skGroupMenberListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"查看群成员";
    
    [self addTableView];
    if (self.modelOther.groupType==1) {//永久群
        [self bizGroupUserlist];
    }else{//临时群
        [self queryOriginalGroupList];
    }
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
//查询群成员列表(永久群)
-(void)bizGroupUserlist{
    ///intf/bizUser/sendRegister
    NSDictionary *dic=@{@"groupNo":self.modelOther.groupNo
                        };
    
    
    [skAfTool SKPOST:skUrl(@"/intf/bizGroupUser/list") pubParame:skPubParType(0) busParame:[dic skDicToJson:dic] showHUD:YES showErrMsg:YES success:^(skResponeModel *  _Nullable responseObject) {
        
        if (responseObject.returnCode==0) {
            skResponeList *modelList=[skResponeList mj_objectWithKeyValues:responseObject.data];
            
            self.arrList=[groupUserModel mj_objectArrayWithKeyValuesArray:modelList.list];
            
            [self.tableView reloadData];
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}

-(void)queryOriginalGroupList{
    ///intf/bizUser/sendRegister
    NSDictionary *dic=@{@"xGroupNo":self.modelOther.groupNo};
    
    
    [skAfTool SKPOST:skUrl(@"/intf/bizGroupMerge/queryOriginalGroupList") pubParame:skPubParType(0) busParame:[dic skDicToJson:dic] showHUD:YES showErrMsg:YES success:^(skResponeModel *  _Nullable responseObject) {
        
        if (responseObject.returnCode==0) {
            
            skResponeList *modelList=[skResponeList mj_objectWithKeyValues:responseObject.data];
            
            self.arrGroupList=[GroupMenberListModel mj_objectArrayWithKeyValuesArray:modelList.list];
            
            [self.tableView reloadData];
        }
        
    } failure:^(NSError * _Nullable error) {
        
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
    
    if (self.modelOther.groupType==1) {//永久群
        return 1;
    }else{//临时群
        return self.arrGroupList.count;
    }
    return 1;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.modelOther.groupType==1) {//永久群
        return self.arrList.count;
    }else{//临时群
        GroupMenberListModel *model=[self.arrGroupList objectAtIndex:section];
        return model.members.count;
    }
    return self.arrList.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.modelOther.groupType==1) {//永久群
        return 0;
    }
    return 40;
}
//- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    GroupWithTypeView *view=skXibView(@"GroupWithTypeView");
//    NSLog(@"=====%@",view);
//    view.backgroundColor=KcolorBackground;
//    GroupMenberListModel *modelG=[self.arrGroupList objectAtIndex:section];
//    view.labTitle.text=modelG.toGroupName;
//    [view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(skScreenWidth, 40));
//    }];
//    return view;
//}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"skLookoverTableViewCell";
    skLookoverTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = skXibView(@"skLookoverTableViewCell");
    }
    groupUserModel *model;
    if (self.modelOther.groupType==1) {//永久群
        model=[self.arrList objectAtIndex:indexPath.row];
    }else{
        GroupMenberListModel *modelG=[self.arrGroupList objectAtIndex:indexPath.section];
        NSArray *arr=modelG.members;
        NSDictionary *dic=[arr objectAtIndex:indexPath.row];
        model=[groupUserModel mj_objectWithKeyValues:dic];
        
    }
    
    
    cell.labName.text=model.nickName.length>0?model.nickName:model.userNo;
    [cell.imageHeader sd_setImageWithURL:[NSURL URLWithString:model.portrait] placeholderImage:[UIImage imageNamed:@"default_portrait_msg"]];
    
    if (indexPath.row==0) {
        [cell setAccessoryType:(UITableViewCellAccessoryNone)];
        [cell.imageSelect setHidden:YES];
        [cell.labType setHidden:NO];
        cell.labType.text=@"群主";
    }else{
        [cell setAccessoryType:(UITableViewCellAccessoryDisclosureIndicator)];
        [cell.imageSelect setHidden:YES];
        [cell.labType setHidden:YES];
        
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.modelOther.groupType==1) {//永久群
        skSingleChatViewController *conversationVC = [[skSingleChatViewController alloc]init];
        groupUserModel *model=[self.arrList objectAtIndex:indexPath.row];
        conversationVC.conversationType = ConversationType_PRIVATE;
        conversationVC.targetId = model.userNo;
        conversationVC.title = [model.nickName length]>0?model.nickName:model.userNo;
        [self.navigationController pushViewController:conversationVC animated:YES];
    }else{//临时群
        GroupMenberListModel *modelG=[self.arrGroupList objectAtIndex:indexPath.section];
        NSArray *arr=modelG.members;
        NSDictionary *dic=[arr objectAtIndex:indexPath.row];
        groupUserModel *model=[groupUserModel mj_objectWithKeyValues:dic];
        
        skSingleChatViewController *conversationVC = [[skSingleChatViewController alloc]init];
        
        conversationVC.conversationType = ConversationType_PRIVATE;
        conversationVC.targetId = model.userNo;
        conversationVC.title = [model.nickName length]>0?model.nickName:model.userNo;
        [self.navigationController pushViewController:conversationVC animated:YES];
    }
    
    
}

@end
