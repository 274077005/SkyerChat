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
#import "combineModel.h"
#import "skImagePicker.h"

@interface skCombineGroupViewController ()
@property (nonatomic,assign) NSInteger rowGroup;
@property (nonatomic,strong) NSArray *arrGroupList;
@property (nonatomic,strong) NSMutableArray *arrSelect;
@property (nonatomic,strong) CombineGroupHeaderTableViewCell *cellHeader;
@property (nonatomic,strong) combineModel *model;
@property (nonatomic,strong) UIImage *imageHeader;
@end

@implementation skCombineGroupViewController
- (combineModel *)model{
    if (nil==_model) {
        _model=[[combineModel alloc] init];
    }
    return _model;
}
- (CombineGroupHeaderTableViewCell *)cellHeader{
    if (_cellHeader==nil) {
        _cellHeader=skXibView(@"CombineGroupHeaderTableViewCell");
        [_cellHeader.btnHeader skSetBoardRadius:40 Width:0 andBorderColor:nil];
        @weakify(self)
        [[_cellHeader.btnHeader rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [skImagePicker showImagePickerFromViewController:self allowsEditing:YES finishAction:^(UIImage *image) {
                if (image) {
                    self.imageHeader=image;
                    [self.cellHeader.btnHeader setImage:nil forState:(UIControlStateNormal)];
                    [self.cellHeader.btnHeader setBackgroundImage:image forState:(UIControlStateNormal)];
                }
                
            }];
        }];
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
    self.title=@"合并群聊天";
    RAC(self.model,groupName)=self.cellHeader.txtName.rac_textSignal;
    RAC(self.model,mergeDays)=self.cellHeader.txtDay.rac_textSignal;
    @weakify(self)
    [[[self skCreatBtn:@"合并" btnTitleOrImage:(btntypeTitle) btnLeftOrRight:(btnStateRight)] rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        [self applyMergeGroup];
    }];
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
        skGroupModel *model=[self.arrGroupList objectAtIndex:indexPath.row];
        if (![self.modelOther.groupNo isEqualToString:model.groupNo]) {
            if (![self.arrSelect containsObject:rows]) {
                [self.arrSelect addObject:rows];
            }else{
                [self.arrSelect removeObject:rows];
            }
            
            [self.tableView reloadData];
        }else{
            [SkToast SkToastShow:@"发起者不能选取" withHight:300];
        }
        
    }
}

-(void)applyMergeGroup{
    ///intf/bizUser/sendRegister
    NSMutableArray *arrNos=[[NSMutableArray alloc] init];
    for (int i=0; i<self.arrSelect.count; ++i) {
        skGroupModel *model=[self.arrGroupList objectAtIndex:i];
        [arrNos addObject:model.groupNo];
    }
    NSDictionary *dic=@{@"fromGroupNo":self.modelOther.groupNo,
                        @"toGroupNos":arrNos,
                        @"groupIconBase64":[skClassMethod skImageBase64:self.imageHeader]?[skClassMethod skImageBase64:self.imageHeader]:@"",
                        @"xGroupName":self.model.groupName?self.model.groupName:@"",
                        @"mergeDays":self.model.mergeDays?self.model.mergeDays:@"30"
                        };
    
    
    [skAfTool SKPOST:skUrl(@"/intf/bizGroupMerge/applyMergeGroup") pubParame:skPubParType(0) busParame:[dic skDicToJson:dic] showHUD:YES showErrMsg:YES success:^(skResponeModel *  _Nullable responseObject) {
        
        if (responseObject.returnCode==0) {
            [SkToast SkToastShow:@"合并成功" withHight:300];
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}

@end
