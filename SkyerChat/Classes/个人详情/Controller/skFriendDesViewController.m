//
//  skFriendDesViewController.m
//  SkyerChat
//
//  Created by skyer on 2018/12/26.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import "skFriendDesViewController.h"
#import "skFriendHeaderTableViewCell.h"
#import "skFriendInfoTableViewCell.h"
#import "skFriendModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "GroupDesModel.h"
#import "groupUserModel.h"
#import "skSingleChatViewController.h"

@interface skFriendDesViewController ()
@property (nonatomic,strong) skFriendModel *model;
@end

@implementation skFriendDesViewController

-(void)addTableView{
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor=KcolorBackground;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop);
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addTableView];
    [self bizGroupUserGet];
}

/**
 查询群单个群成员的个人信息
 */
-(void)bizGroupUserGet{
    ///intf/bizUser/sendRegister
    
    groupUserModel *modelU=self.skDataNeed0;
    
    NSDictionary *dic1=@{@"groupId":[NSNumber numberWithInteger:modelU.groupId],
                        @"userId":[NSNumber numberWithInteger:modelU.userId]
                        };
    
    NSDictionary *dic=@{@"gid":dic1};
    
    [skAfTool SKPOST:skUrl(@"/intf/bizGroupUser/get") pubParame:skPubParType(0) busParame:[dic skDicToJson:dic] showHUD:YES showErrMsg:YES success:^(skResponeModel *  _Nullable responseObject) {
        
        if (responseObject.returnCode==0) {
            self.model=[skFriendModel mj_objectWithKeyValues:responseObject.data];
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
    return 2;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
        {
            GroupDesModel *modelG = self.skDataNeed1;
            if (modelG.memberType==1) {
                return 3;
            }else{
                return 1;
            }
        }
            
            break;
            
        default:
            break;
    }
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return 70;
            break;
        case 1:
            return 50;
            break;
            
        default:
            break;
    }
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 10;
            break;
        case 1:
            return 80;
            break;
            
        default:
            break;
    }
    return 50;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    CGFloat height =10;
    if (section>0) {
        height=100;
    }
    
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, skScreenWidth, height)];
    view.backgroundColor=KcolorBackground;
    if (section>0) {
        UIButton *btnChat=[[UIButton alloc] initWithFrame:CGRectMake(20, 30, skScreenWidth-20*2, 50)];
        [btnChat setTitle:@"发起会话" forState:(UIControlStateNormal)];
        [btnChat setBackgroundColor:KcolorMain];
        [btnChat skSetBoardRadius:5 Width:0 andBorderColor:nil];
        
        @weakify(self)
        [[btnChat rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            groupUserModel *model=self.skDataNeed0;
            
            skSingleChatViewController *conversationVC = [[skSingleChatViewController alloc]init];
            
            conversationVC.conversationType = ConversationType_PRIVATE;
            conversationVC.targetId = model.userNo;
            conversationVC.title = [model.nickName length]>0?model.nickName:model.userNo;
            [self.navigationController pushViewController:conversationVC animated:YES];
        }];
        
        [view addSubview:btnChat];
    }
    return view;
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:
        {
            static NSString *cellIdentifier = @"skFriendHeaderTableViewCell";
            skFriendHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = skXibView(@"skFriendHeaderTableViewCell");
            }
            
            [cell.imageHeader sd_setImageWithURL:[NSURL URLWithString:self.model.portrait] placeholderImage:[UIImage imageNamed:@"default_portrait_msg"]];
            [cell.imageHeader skSetBoardRadius:24 Width:0 andBorderColor:nil];
            
            
            cell.labNikeName.text=[self.model.nickName length]>0?self.model.nickName:self.model.userNo;
            return cell;
        }
            break;
        case 1:
        {
            static NSString *cellIdentifier = @"skFriendInfoTableViewCell";
            skFriendInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = skXibView(@"skFriendInfoTableViewCell");
                
                @weakify(self)
                [[cell.btnSwith rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
                    @strongify(self)
                    switch (x.tag) {
                        case 0:
                        {
                            [self bizUserUpdate];
                        }
                            break;
                        case 1:
                        {
                            
                        }
                            break;
                            
                        default:
                            break;
                    }
                }];
            }
            switch (indexPath.row) {
                case 0:
                {
                    cell.labName.text=@"禁言";
                    [cell.btnSwith setOn:self.model.isGag];
                    cell.btnSwith.tag=indexPath.row;
                }
                    break;
                case 1:
                {
                    cell.labName.text=@"设置为管理员";
                    [cell.btnSwith setOn:self.model.memberType==2?YES:NO];
                    cell.btnSwith.tag=indexPath.row;
                }
                    break;
                case 2:
                {
                    cell.labName.text=@"踢出群组";
                    [cell.btnSwith setHidden:YES];
                }
                    break;
                    
                default:
                    break;
            }
            return cell;
        }
            break;
            
        default:
            break;
    }
    
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row==2) {
        groupUserModel *model=self.skDataNeed0;
        GroupDesModel *modelG = self.skDataNeed1;
        [self bizGroupUserdelete:modelG.groupNo kickOut:model.userNo];
    }
}
-(void)bizGroupUserdelete:(NSString *)groupNo kickOut:(NSString *)kickOut{
    ///intf/bizUser/sendRegister
    NSDictionary *dic=@{@"groupNo":groupNo,
                        @"userNos":@[kickOut]
                        };
    
    
    [skAfTool SKPOST:skUrl(@"/intf/bizGroupUser/kickOut") pubParame:skPubParType(0) busParame:[dic skDicToJson:dic] showHUD:YES showErrMsg:YES success:^(skResponeModel *  _Nullable responseObject) {
        
        if (responseObject.returnCode==0) {
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}

#pragma mark - 禁言
-(void)bizUserUpdate{
    ///intf/bizUser/sendRegister
    
    GroupDesModel *modelG = self.skDataNeed1;
    
    NSDictionary *dic=@{@"userNo":self.model.userNo,
                        @"groupNo":modelG.groupNo,
                        @"isGag":[NSNumber numberWithBool:!self.model.isGag],
                        };
    
    
    [skAfTool SKPOST:skUrl(@"/intf/bizGroupUser/update") pubParame:skPubParType(0) busParame:[dic skDicToJson:dic] showHUD:YES showErrMsg:YES success:^(skResponeModel *  _Nullable responseObject) {
        
        if (responseObject.returnCode==0) {
            self.model.isGag=!self.model.isGag;
            [self.tableView reloadData];
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}

@end
