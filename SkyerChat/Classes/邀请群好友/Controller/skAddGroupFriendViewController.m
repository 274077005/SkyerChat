//
//  skAddGroupFriendViewController.m
//  SkyerChat
//
//  Created by skyer on 2018/11/8.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import "skAddGroupFriendViewController.h"
#import "skLookoverTableViewCell.h"
#import "groupUserModel.h"
#import "myClientModel.h"
#import "UIImageView+WebCache.h"

@interface skAddGroupFriendViewController ()
@property (nonatomic,strong) NSArray *arrListGroupMenber;
@property (nonatomic,strong) NSArray *arrListMyFriend;
@property (nonatomic,strong) NSMutableArray *arrSelect;
@property (nonatomic,strong) UIButton *btnRight;
@property (nonatomic,strong) NSMutableArray *arrCanAddMember;
@end

@implementation skAddGroupFriendViewController

-(NSMutableArray *)arrCanAddMember{
    if (nil==_arrCanAddMember) {
        _arrCanAddMember=[[NSMutableArray alloc] init];
    }
    return _arrCanAddMember;
}
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
                [self bizGroupUserCreate];
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
    [self bizGroupUserlist];
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
    return self.arrCanAddMember.count;
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
    myClientModel *modelC=[self.arrCanAddMember objectAtIndex:indexPath.row];
    
    NSString *row=[NSString stringWithFormat:@"%ld",indexPath.row];
    if ([self.arrSelect containsObject:row]) {
        [cell.imageSelect setImage:[UIImage imageNamed:@"多选-选中"]];
    }else{
        [cell.imageSelect setImage:[UIImage imageNamed:@"多选-未选"]];
    }
    [cell.imageHeader sd_setImageWithURL:[NSURL URLWithString:modelC.portrait] placeholderImage:[UIImage imageNamed:@"default_portrait_msg"]];
    cell.labName.text=modelC.nickName.length>0?modelC.nickName:modelC.userNo;
    
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

#pragma mark 群成员列表

-(void)bizGroupUserlist{
    ///intf/bizUser/sendRegister
    NSDictionary *dic=@{@"groupNo":self.modelOther.groupNo
                        };
    
    
    [skAfTool SKPOST:skUrl(@"/intf/bizGroupUser/list") pubParame:skPubParType(0) busParame:[dic skDicToJson:dic] showHUD:YES showErrMsg:YES success:^(skResponeModel *  _Nullable responseObject) {
        
        if (responseObject.returnCode==0) {
            skResponeList *modelList=[skResponeList mj_objectWithKeyValues:responseObject.data];
            
            self.arrListGroupMenber=[groupUserModel mj_objectArrayWithKeyValuesArray:modelList.list];
            [self skDataSelect];
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
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
            
            self.arrListMyFriend= [myClientModel mj_objectArrayWithKeyValuesArray:modelList.list];
            
            [self skDataSelect];
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}


-(void)skDataSelect{
    
    self.arrCanAddMember=[[NSMutableArray alloc] initWithArray:self.arrListMyFriend];
    for (int i=0; i<self.arrListMyFriend.count; ++i) {
        myClientModel *modelC=[self.arrListMyFriend objectAtIndex:i];
        NSString *userNoC=modelC.userNo;
        
        for (int k=0; k<self.arrListGroupMenber.count; ++k) {
            groupUserModel *modelG=[self.arrListGroupMenber objectAtIndex:k];
            NSString *userNoG=modelG.userNo;
            if ([userNoC isEqualToString:userNoG]) {
                [self.arrCanAddMember removeObject:modelC];
            }
        }
    }
    [self.tableView reloadData];
}

-(void)bizGroupUserCreate{
    ///intf/bizUser/sendRegister
    NSMutableArray *arrNos=[[NSMutableArray alloc] init];
    for (int i =0; i<self.arrSelect.count; ++i) {
        NSString *intselect=[self.arrSelect objectAtIndex:i];
        myClientModel *modelc=[self.arrCanAddMember objectAtIndex:[intselect intValue]];
        [arrNos addObject:modelc.userNo];
    }
    NSDictionary *dic=@{@"groupNo":self.modelOther.groupNo,
                        @"userNos":arrNos
                        };
    
    
    [skAfTool SKPOST:skUrl(@"/intf/bizGroupUser/pullIn") pubParame:skPubParType(0) busParame:[dic skDicToJson:dic] showHUD:YES showErrMsg:YES success:^(skResponeModel *  _Nullable responseObject) {
        
        if (responseObject.returnCode==0) {
            [SkToast SkToastShow:@"加群成功" withHight:300];
            [self.btnRight setTitle:@"确定(0)" forState:(UIControlStateNormal)];
            [self.arrSelect removeAllObjects];
            [self.arrCanAddMember removeAllObjects];
            [self bizGroupUserlist];
            [self getAddressBookList:@""];
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
    
}

@end
