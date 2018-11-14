//
//  skCombineGroupViewController.m
//  SkyerChat
//
//  Created by skyer on 2018/11/12.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import "skCombineGroupViewController.h"
#import "CombineGroupTableViewCell.h"
#import "skGroupModel.h"
#import "CombineGroupHeaderTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface skCombineGroupViewController ()
@property (nonatomic,assign) NSInteger rowGroup;
@property (nonatomic,strong) NSArray *arrGroupList;
@property (nonatomic,strong) NSMutableArray *arrSelect;
@property (nonatomic,strong) CombineGroupHeaderTableViewCell *cellHeader;
@end

@implementation skCombineGroupViewController
- (CombineGroupHeaderTableViewCell *)cellHeader{
    if (_cellHeader==nil) {
        _cellHeader=skXibView(@"CombineGroupHeaderTableViewCell");
    }
    return _cellHeader;
}
- (NSMutableArray *)arrSelect{
    if (nil==_arrSelect) {
        _arrSelect=[[NSMutableArray alloc] init];
    }
    return _arrSelect;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addTableView];
    [self bizGroupMyGroup];
}
-(void)addTableView{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop);
    }];
}

-(void)bizGroupMyGroup{
    NSDictionary *dic=@{@"page":@"0",
                        @"rows":[NSNumber numberWithInteger:10000]
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
        {
            return 1;
        }
            break;
        case 1:
        {
            return self.arrGroupList.count;
        }
            break;
            
        default:
            break;
    }
    return self.arrGroupList.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return 220;
            break;
        case 1:
            return 50;
            break;
            
        default:
            break;
    }
    return 50;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    
    switch (indexPath.section) {
        case 0:
        {
            return self.cellHeader;
        }
            break;
        case 1:
        {
            static NSString *cellIdentifier = @"CombineGroupTableViewCell";
            
            CombineGroupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
            if (cell == nil) {
                cell = skXibView(@"CombineGroupTableViewCell");
            }
            NSString *rows=[NSString stringWithFormat:@"%ld",indexPath.row];
            if ([self.arrSelect containsObject:rows]) {
                [cell.imageSelect setImage:[UIImage imageNamed:@"多选-选中"]];
            }else{
                [cell.imageSelect setImage:[UIImage imageNamed:@"多选-未选"]];
            }
            skGroupModel *model=[self.arrGroupList objectAtIndex:indexPath.row];
            [cell.imageHeader sd_setImageWithURL:[NSURL URLWithString:model.groupIcon] placeholderImage:[UIImage imageNamed:@"default_group_portrait"]];
            
            cell.labName.text=model.groupName;
            
            return cell;
        }
            break;
            
        default:
            break;
    }
    static NSString *cellIdentifier = @"CombineGroupTableViewCell";
    
    CombineGroupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = skXibView(@"CombineGroupTableViewCell");
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section>0) {
        NSString *rows=[NSString stringWithFormat:@"%ld",indexPath.row];
        
        if (![self.arrSelect containsObject:rows]) {
            [self.arrSelect addObject:rows];
        }else{
            [self.arrSelect removeObject:rows];
        }
        
        [self.tableView reloadData];
    }
    
}

@end
