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
@interface skMyClientViewController ()
@property (nonatomic,strong) NSArray *arrList;
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


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"myClientTableViewCell";
    myClientTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = skXibView(@"myClientTableViewCell");
    }
    myClientModel *model=[self.arrList objectAtIndex:indexPath.row];
    
    cell.labNikeName.text=model.nickName?model.nickName:model.userNo;
    [cell.imageTitle sd_setImageWithURL:[NSURL URLWithString:model.portrait] placeholderImage:[UIImage imageNamed:@"default_portrait_msg"]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    myClientModel *model=[self.arrList objectAtIndex:indexPath.row];
    skSingleChatViewController *view=[[skSingleChatViewController alloc] initWithConversationType:(ConversationType_PRIVATE) targetId:model.userNo];
    view.title=model.nickName?model.nickName:model.userNo;
    [self.navigationController pushViewController:view animated:YES];
}
/**
 获取通讯录列表
 
 @param keyword 关键字
 */
-(void)getAddressBookList:(NSString *)keyword{
    
    NSDictionary *dic=@{@"keywordss":keyword};
    
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
