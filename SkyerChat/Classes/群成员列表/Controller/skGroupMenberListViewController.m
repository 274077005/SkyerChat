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
#import "skFriendDesViewController.h"
#import "GroupDesModel.h"

@interface skGroupMenberListViewController ()

@property (nonatomic,strong) NSArray *arrGroupList;
@property (nonatomic,strong) NSArray *arrGroupContainList;
@property (nonatomic,strong) NSArray *arrList;
@property (nonatomic,strong) NSMutableArray *arrSelect;

@end

@implementation skGroupMenberListViewController
- (NSMutableArray *)arrSelect{
    if (nil==_arrSelect) {
        _arrSelect=[[NSMutableArray alloc] init];
    }
    return  _arrSelect;
}
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
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.modelOther.groupType==1) {//永久群
        return self.arrList.count;
    }else{//临时群
        
        
        NSString *select=[NSString stringWithFormat:@"%ld",section];
        
        if ([self.arrSelect containsObject:select]) {
            GroupMenberListModel *model=[self.arrGroupList objectAtIndex:section];
            return model.members.count;
        }else{
            return 0;
        }
        
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.modelOther.groupType==1) {//永久群
        return 0;
    }else{
        return 40;
    }
    
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, skScreenWidth, 40)];
    view.backgroundColor=[UIColor whiteColor];
    
    GroupMenberListModel *modelG=[self.arrGroupList objectAtIndex:section];

    UILabel *labTitle=[[UILabel alloc] initWithFrame:CGRectMake(10 , 10, 200, 20)];
    [view addSubview:labTitle];
    labTitle.textColor=[UIColor grayColor];
    labTitle.text=modelG.toGroupName;
    
    NSString *select=[NSString stringWithFormat:@"%ld",section];
    
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(skScreenWidth-30, 10, 20, 20)];
    if ([self.arrSelect containsObject:select]){
        imageView.image=[UIImage imageNamed:@"小图标-箭头-下"];
    }else{
        imageView.image=[UIImage imageNamed:@"小图标-箭头右"];
    }
    
    [view addSubview:imageView];
    
    UIButton *btnSelect=[[UIButton alloc] initWithFrame:view.bounds];
    btnSelect.tag=section;
    @weakify(self)
    [[btnSelect rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        
        
        if ([self.arrSelect containsObject:select]){
            [self.arrSelect removeObject:select];
        }else{
            [self.arrSelect addObject:select];
        }
        
        [self.tableView reloadData];
        
    }];
    [view addSubview:btnSelect];
    
    
    UILabel *labLine=[[UILabel alloc] initWithFrame:CGRectMake(0, 39, skScreenWidth, 1)];
    labLine.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [view addSubview:labLine];
    
    return view;
}


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
    
    if (model.memberType==1) {
        [cell.imageSelect setHidden:YES];
        [cell.labType setHidden:NO];
        cell.labType.text=@" 群主 ";
        [cell.labType skSetBoardRadius:4 Width:0 andBorderColor:nil];
        [cell.labType setBackgroundColor:KcolorMain];
    }else if (model.memberType==2){
        [cell.imageSelect setHidden:YES];
        [cell.labType setHidden:NO];
        cell.labType.text=@" 管理员 ";
        [cell.labType skSetBoardRadius:4 Width:0 andBorderColor:nil];
        [cell.labType setBackgroundColor:KcolorMain];
    }else{
        
        [cell.imageSelect setHidden:YES];
        [cell.labType setHidden:YES];
    }
    [cell setAccessoryType:(UITableViewCellAccessoryDisclosureIndicator)];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    if (self.modelOther.groupType==1) {//永久群
//        skSingleChatViewController *conversationVC = [[skSingleChatViewController alloc]init];
//        groupUserModel *model=[self.arrList objectAtIndex:indexPath.row];
//        conversationVC.conversationType = ConversationType_PRIVATE;
//        conversationVC.targetId = model.userNo;
//        conversationVC.title = [model.nickName length]>0?model.nickName:model.userNo;
//        [self.navigationController pushViewController:conversationVC animated:YES];
//    }else{//临时群
//        GroupMenberListModel *modelG=[self.arrGroupList objectAtIndex:indexPath.section];
//        NSArray *arr=modelG.members;
//        NSDictionary *dic=[arr objectAtIndex:indexPath.row];
//        groupUserModel *model=[groupUserModel mj_objectWithKeyValues:dic];
//
//        skSingleChatViewController *conversationVC = [[skSingleChatViewController alloc]init];
//
//        conversationVC.conversationType = ConversationType_PRIVATE;
//        conversationVC.targetId = model.userNo;
//        conversationVC.title = [model.nickName length]>0?model.nickName:model.userNo;
//        [self.navigationController pushViewController:conversationVC animated:YES];
//    }
    if (self.modelOther.groupType==1) {//永久群
        groupUserModel *model=[self.arrList objectAtIndex:indexPath.row];
        skFriendDesViewController *view=[[skFriendDesViewController alloc] init];
        view.skDataNeed0 = model;
        view.skDataNeed1 = self.modelOther;
        [self.navigationController pushViewController:view animated:YES];
    }else{//临时群
        GroupMenberListModel *modelG=[self.arrGroupList objectAtIndex:indexPath.section];
        NSArray *arr=modelG.members;
        NSDictionary *dic=[arr objectAtIndex:indexPath.row];
        groupUserModel *model=[groupUserModel mj_objectWithKeyValues:dic];
        skFriendDesViewController *view=[[skFriendDesViewController alloc] init];
        view.skDataNeed0 = model;
        view.skDataNeed1 = self.modelOther;
        [self.navigationController pushViewController:view animated:YES];
    }
    
    
    
}

@end
