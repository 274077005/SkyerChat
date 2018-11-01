//
//  skGroupChatDetailsViewController.m
//  SkyerChat
//
//  Created by admin on 2018/10/30.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import "skGroupChatDetailsViewController.h"
#import "skGroupChatHeadersTableViewCell.h"
#import "skGroupChatTitleTableViewCell.h"

@interface skGroupChatDetailsViewController ()
@property (nonatomic,strong) skGroupChatHeadersTableViewCell *cellHeaders;
@end

@implementation skGroupChatDetailsViewController

- (skGroupChatHeadersTableViewCell *)cellHeaders{
    if (nil==_cellHeaders) {
        _cellHeaders=skXibView(@"skGroupChatHeadersTableViewCell");
        [_cellHeaders.collectionView reloadData];
    }
    return _cellHeaders;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"聊天信息";
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
    return 1;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 15;
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return self.cellHeaders;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


-(void)auditList{
    ///intf/bizUser/sendRegister
    NSDictionary *dic=@{@"groupNo":@""};
    
    
    [skAfTool SKPOST:skUrl(@"/intf/bizGroupMerge/auditList") pubParame:skPubParType(0) busParame:[dic skDicToJson:dic] showHUD:YES showErrMsg:YES success:^(skResponeModel *  _Nullable responseObject) {
        
        if (responseObject.returnCode==0) {
            
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}

@end
