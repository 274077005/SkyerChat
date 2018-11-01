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
#import "groupUserModel.h"
#import "skGroupGonggaoTableViewCell.h"

@interface skGroupChatDetailsViewController ()
@property (nonatomic,strong) skGroupChatHeadersTableViewCell *cellHeaders;//头像cell
@property (nonatomic,strong) skGroupGonggaoTableViewCell *cellGonggao;//公告cell
@property (nonatomic,strong) NSArray *arrListGroupHeader;//群用户头像列表
@end

@implementation skGroupChatDetailsViewController

- (skGroupChatHeadersTableViewCell *)cellHeaders{
    if (nil==_cellHeaders) {
        _cellHeaders=skXibView(@"skGroupChatHeadersTableViewCell");
        [_cellHeaders.collectionView reloadData];
    }
    return _cellHeaders;
}
- (skGroupGonggaoTableViewCell *)cellGonggao{
    if (nil==_cellGonggao) {
        _cellGonggao=skXibView(@"skGroupGonggaoTableViewCell");
    }
    return _cellGonggao;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"聊天信息";
    [self addTableView];
    [self bizGroupMergeauditList];
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0://显示头像的
        {
            return 1;
        }
            break;
        case 1://显示群公告和群活动
        {
            return 2;
        }
            break;
            
        default:
            break;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            {
                if (self.arrListGroupHeader.count>=6) {
                    return 180;
                }else{
                    return 110;
                }
            }
            break;
        case 1:
        {
            switch (indexPath.row) {
                case 0:
                {
                    return 66;//群公告
                }
                    break;
                case 1:
                {
                    return 60;//群活动
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0;
    }
    return 10;
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            return self.cellHeaders;
        }
            break;
        case 1:
        {
            switch (indexPath.row) {
                case 0:
                {
                    return self.cellGonggao;//群公告
                }
                    break;
                case 1:
                {
                    return self.cellGonggao;//群活动
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
    return self.cellHeaders;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


-(void)bizGroupMergeauditList{
    ///intf/bizUser/sendRegister
    NSDictionary *dic=@{@"groupNo":self.model.groupNo};
    
    [skAfTool SKPOST:skUrl(@"/intf/bizGroupUser/list") pubParame:skPubParType(0) busParame:[dic skDicToJson:dic] showHUD:NO showErrMsg:NO success:^(skResponeModel *  _Nullable responseObject) {
        
        if (responseObject.returnCode==0) {
            skResponeList *modelList=[skResponeList mj_objectWithKeyValues:responseObject.data];
            
            self.arrListGroupHeader=[groupUserModel mj_objectArrayWithKeyValuesArray:modelList.list];
            self.cellHeaders.arrModelList=self.arrListGroupHeader;
            [self.cellHeaders.collectionView reloadData];
            [self.tableView reloadData];
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}

@end
