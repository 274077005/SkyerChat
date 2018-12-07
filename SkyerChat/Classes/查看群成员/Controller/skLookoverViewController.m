//
//  skLookoverViewController.m
//  SkyerChat
//
//  Created by admin on 2018/11/6.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import "skLookoverViewController.h"
#import "groupUserModel.h"
#import "skLookoverTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "skSingleChatViewController.h"

@interface skLookoverViewController ()
@property (nonatomic,strong) NSArray *arrList;
@property (nonatomic,strong) NSMutableArray *arrSelect;
@property (nonatomic,strong) UIButton *btnRight;
@end

@implementation skLookoverViewController
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
                [self bizGroupUserdeleteMore:self.modelOther.groupNo];
            }
        }];
    }
    return _btnRight;
}

-(void)bizGroupUserdeleteMore:(NSString *)groupNo{
    ///intf/bizUser/sendRegister
    NSMutableArray *arr1=[[NSMutableArray alloc] init];
    
    for (int i =0; i<self.arrSelect.count; ++i) {
        NSString *index=[self.arrSelect objectAtIndex:i];
        groupUserModel *model=[self.arrList objectAtIndex:[index intValue]];
        [arr1 addObject:model.userNo];
    }
    
    NSDictionary *dic=@{@"groupNo":groupNo,
                        @"userNos":arr1
                        };
    
    
    [skAfTool SKPOST:skUrl(@"/intf/bizGroupUser/kickOut") pubParame:skPubParType(0) busParame:[dic skDicToJson:dic] showHUD:YES showErrMsg:YES success:^(skResponeModel *  _Nullable responseObject) {
        
        if (responseObject.returnCode==0) {
            [self.arrSelect removeAllObjects];
            [self bizGroupUserlist];
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"删除群成员";
    // Do any additional setup after loading the view.
    [self addTableView];
    [self bizGroupUserlist];
    [self.btnRight setTitle:@"确定(0)" forState:(UIControlStateNormal)];
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
    return 1;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrList.count;
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
    groupUserModel *model=[self.arrList objectAtIndex:indexPath.row];
    cell.labName.text=model.nickName.length>0?model.nickName:model.userNo;
    [cell.imageHeader sd_setImageWithURL:[NSURL URLWithString:model.portrait] placeholderImage:[UIImage imageNamed:@"default_portrait_msg"]];
    
    if (indexPath.row==0) {
        [cell setAccessoryType:(UITableViewCellAccessoryNone)];
        [cell.imageSelect setHidden:YES];
        [cell.labType setHidden:NO];
        cell.labType.text=@"群主";
    }else{
        [cell setAccessoryType:(UITableViewCellAccessoryNone)];
        [cell.imageSelect setHidden:NO];
        [cell.labType setHidden:YES];
        
        NSString *row=[NSString stringWithFormat:@"%ld",indexPath.row];
        if ([self.arrSelect containsObject:row]) {
            [cell.imageSelect setImage:[UIImage imageNamed:@"多选-选中"]];
        }else{
            [cell.imageSelect setImage:[UIImage imageNamed:@"多选-未选"]];
        }
    }
    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row>0) {
        NSString *row=[NSString stringWithFormat:@"%ld",indexPath.row];
        if (![self.arrSelect containsObject:row]) {
            [self.arrSelect addObject:row];
        }else{
            [self.arrSelect removeObject:row];
        }
        [self.btnRight setTitle:[NSString stringWithFormat:@"确定(%ld)",self.arrSelect.count] forState:(UIControlStateNormal)];
        [self.tableView reloadData];
    }
    
    
    
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

// 定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

// 进入编辑模式，按下出现的编辑按钮后,进行删除操作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        groupUserModel *model=[self.arrList objectAtIndex:indexPath.row];
        [self bizGroupUserdelete:self.modelOther.groupNo kickOut:model.userNo];
    }
}
-(void)bizGroupUserdelete:(NSString *)groupNo kickOut:(NSString *)kickOut{
    ///intf/bizUser/sendRegister
    NSDictionary *dic=@{@"groupNo":groupNo,
                        @"userNos":@[kickOut]
                        };
    
    
    [skAfTool SKPOST:skUrl(@"/intf/bizGroupUser/kickOut") pubParame:skPubParType(0) busParame:[dic skDicToJson:dic] showHUD:YES showErrMsg:YES success:^(skResponeModel *  _Nullable responseObject) {
        
        if (responseObject.returnCode==0) {
            [self bizGroupUserlist];
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}


// 修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}



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

@end
