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

@interface skCombineGroupViewController ()
@property (nonatomic,assign) NSInteger rowGroup;
@property (nonatomic,strong) NSArray *arrGroupList;
@property (nonatomic,strong) NSArray *arrSelect;
@end

@implementation skCombineGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addTableView];
    
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


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrGroupList.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"CombineGroupTableViewCell";
    
    CombineGroupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = skXibView(@"CombineGroupTableViewCell");
    }
    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *rows=[NSString stringWithFormat:@"%ld",indexPath.row];
    
    if ([self.arrSelect containsObject:rows]) {
        
    }
    
    [self.tableView reloadData];
}

@end
