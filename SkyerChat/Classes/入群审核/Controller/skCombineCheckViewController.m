//
//  skCombineCheckViewController.m
//  SkyerChat
//
//  Created by admin on 2018/11/19.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import "skCombineCheckViewController.h"
#import "CombineCheckTableViewCell.h"
#import "combineCheckModel.h"

@interface skCombineCheckViewController ()
@property (nonatomic,assign) NSInteger rows;
@property (nonatomic,strong) NSArray *arrList;
@end

@implementation skCombineCheckViewController
-(void)addTableView{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop);
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"群合并申请审核";
    [self addTableView];
    [self auditList];
    
    skWeakSelf(self)
    [self createRefreshHeaderViewWithBlock:^{
        weakself.rows=10;
        [self auditList];
    }];
    [self createRefreshFooterViewWithBlock:^{
        weakself.rows+=10;
        [self auditList];
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
-(void)auditList{
    ///intf/bizUser/sendRegister
    NSDictionary *dic=@{@"page":@"0",
                        @"rows":[NSNumber numberWithInteger:self.rows]
                        };
    
    
    [skAfTool SKPOST:skUrl(@"/intf/bizGroupMerge/auditList") pubParame:skPubParType(0) busParame:[dic skDicToJson:dic] showHUD:YES showErrMsg:YES success:^(skResponeModel *  _Nullable responseObject) {
        [self footerEndRefreshing];
        [self headerEndRefreshing];
        if (responseObject.returnCode==0) {
            
            skResponeList *modelList=[skResponeList mj_objectWithKeyValues:responseObject.data];
            
            self.arrList=[combineCheckModel mj_objectArrayWithKeyValuesArray:modelList.list];
            [self.tableView reloadData];
        }
        
    } failure:^(NSError * _Nullable error) {
        [self footerEndRefreshing];
        [self headerEndRefreshing];
    }];
}

#pragma mark - 代理方法


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrList.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"CombineCheckTableViewCell";
    CombineCheckTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = skXibView(@"CombineCheckTableViewCell");
        @weakify(self)
        [[cell.btnSure rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [self auditJoinMergedGroup:x.tag andStay:@"1"];
        }];
        [[cell.btnEnSure rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [self auditJoinMergedGroup:x.tag andStay:@"2"];
        }];
    }
    cell.btnEnSure.tag=indexPath.row;
    cell.btnSure.tag=indexPath.row;
    combineCheckModel *model=[self.arrList objectAtIndex:indexPath.row];
    
    cell.labTitle.text=[NSString stringWithFormat:@"群(%@)向你申请合并(%@)",model.fromGroupName,model.toGroupName];
    
    cell.labNewGroupName.text=model.xoxoGroupName;
    cell.labTime.text=model.applyTime;
    cell.labMregeDay.text=[NSString stringWithFormat:@"%ld",model.mergeDays];
    cell.labWhoConbine.text=model.fromUserNo;
    //0=待审核,1=同意,2=不同意
    
    switch (model.status) {
        case 0:
        {
            cell.labState.text=@"待审核";
        }
            break;
        case 1:
        {
            cell.labState.text=@"已同意";
        }
            break;
        case 2:
        {
            cell.labState.text=@"已拒绝";
        }
            break;
            
        default:
            break;
    }
    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)auditJoinMergedGroup:(NSInteger)btnTag andStay:(NSString *)status{
    ///intf/bizUser/sendRegister
    combineCheckModel *model=[self.arrList objectAtIndex:btnTag];
    NSDictionary *dic=@{@"mergeNo":model.mergeNo,
                        @"fromGroupNo":[NSNumber numberWithInteger:model.fromGroupId],
                        @"status":status//1=同意,2=不同意
                        };
    
    
    [skAfTool SKPOST:skUrl(@"/intf/bizGroupMerge/auditJoinMergedGroup") pubParame:skPubParType(0) busParame:[dic skDicToJson:dic] showHUD:YES showErrMsg:YES success:^(skResponeModel *  _Nullable responseObject) {
        
        if (responseObject.returnCode==0) {
            [self auditList];
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}

@end
