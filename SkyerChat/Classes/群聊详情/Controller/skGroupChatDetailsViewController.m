//
//  skGroupChatDetailsViewController.m
//  SkyerChat
//
//  Created by admin on 2018/10/30.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import "skGroupChatDetailsViewController.h"
#import "skGroupChatHeadersTableViewCell.h"
#import "groupUserModel.h"
#import "gruopActivictModel.h"
#import "skGroupGonggaoTableViewCell.h"
#import "groupCostemModel.h"
#import "groupCellModel.h"
#import "skGroupTitleTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "skImagePicker.h"
#import "skLookoverViewController.h"
#import "skSingleChatViewController.h"
#import "skAddGroupFriendViewController.h"
#import "skQRcodeGroupViewController.h"
#import "skGroupAcivityViewController.h"
#import "skCombineGroupViewController.h"
#import "skGonggaoViewController.h"
#import "skGroupMenberListViewController.h"
#import "chatGonggaoModel.h"
#import "skUserInfoSetViewController.h"


@interface skGroupChatDetailsViewController ()
@property (nonatomic,strong) skGroupChatHeadersTableViewCell *cellHeaders;//头像cell
@property (nonatomic,strong) NSArray *arrListGroupHeader;
@property (nonatomic,strong) groupCostemModel *modelCell;//所有的cellde模型

@property (nonatomic,strong) chatGonggaoModel *modelGonggao;
@end

@implementation skGroupChatDetailsViewController

- (chatGonggaoModel *)modelGonggao{
    if (nil==_modelGonggao) {
        _modelGonggao=[[chatGonggaoModel alloc] init];
    }
    return _modelGonggao;
}

- (groupCostemModel *)modelCell{
    if (nil==_modelCell) {
        _modelCell=[[groupCostemModel alloc] init];
    }
    return _modelCell;
}
- (skGroupChatHeadersTableViewCell *)cellHeaders{
    if (nil==_cellHeaders) {
        _cellHeaders=skXibView(@"skGroupChatHeadersTableViewCell");
        _cellHeaders.modelG=self.model;
        
        @weakify(self)
        
        [[_cellHeaders rac_signalForSelector:@selector(skDidSelectItemAtIndexPath:)] subscribeNext:^(RACTuple * _Nullable x) {
            @strongify(self)
            
            
            NSIndexPath *indexPath=x[0];
            if (indexPath.row<self.arrListGroupHeader.count) {//群主点击聊天
                if ([self.model.createUserNo isEqualToString:skUser.userNo]) {
                    groupUserModel *modelU=[self.arrListGroupHeader objectAtIndex:indexPath.row];
                    skSingleChatViewController *conversationVC = [[skSingleChatViewController alloc]init];
                    conversationVC.conversationType = ConversationType_PRIVATE;
                    conversationVC.targetId = modelU.userNo;
                    conversationVC.title = [modelU.nickName length]>0?modelU.nickName:modelU.userNo;
                    [self.navigationController pushViewController:conversationVC animated:YES];
                }else{
                    groupUserModel *modelU=[self.arrListGroupHeader objectAtIndex:indexPath.row];
                    if (modelU.memberType==1||modelU.memberType==2) {//找群主聊天
                        skSingleChatViewController *conversationVC = [[skSingleChatViewController alloc]init];
                        conversationVC.conversationType = ConversationType_PRIVATE;
                        conversationVC.targetId = modelU.userNo;
                        conversationVC.title = [modelU.nickName length]>0?modelU.nickName:modelU.userNo;
                        [self.navigationController pushViewController:conversationVC animated:YES];
                    }
                }
                
            }else if(indexPath.row==self.arrListGroupHeader.count){//邀请进群
                if ([self.model.createUserNo isEqualToString:skUser.userNo]) {
                    skAddGroupFriendViewController *view=[[skAddGroupFriendViewController alloc] init];
                    view.modelOther=self.model;
                    [self.navigationController pushViewController:view animated:YES];
                }
            }else{//删除群成员
                if ([self.model.createUserNo isEqualToString:skUser.userNo]) {
                    skLookoverViewController *view=[[skLookoverViewController alloc] init];
                    view.modelOther=self.model;
                    [self.navigationController pushViewController:view animated:YES];
                }
            }
            
        }];
        
        [[_cellHeaders.viewMore.btnMore rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            //查看群成员
            if (self.model.memberType==1||self.model.memberType==2) {
                
                skGroupMenberListViewController *view=[[skGroupMenberListViewController alloc] init];
                
                view.modelOther=self.model;
                [self.navigationController pushViewController:view animated:YES];
            }
        }];
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
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self bizGroupMergeauditList];
    [self getNewest];
    self.navigationController.navigationBarHidden = NO;
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
    
    return self.modelCell.arrList.count;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray *arr=[self.modelCell.arrList objectAtIndex:section];
    
    return arr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *arr=[self.modelCell.arrList objectAtIndex:indexPath.section];
    groupCellModel *modelCell=[arr objectAtIndex:indexPath.row];
    
    switch (modelCell.type) {
        case cellTypeNormal:
            return 50;
            break;
        case cellTypeTitle:
            return 66;
            break;
        case cellTypeHeader:
            if (self.arrListGroupHeader.count<4) {
                return 110;
            }else{
                return 180;
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
    
    NSArray *arr=[self.modelCell.arrList objectAtIndex:indexPath.section];
    groupCellModel *modelCell=[arr objectAtIndex:indexPath.row];
    
    switch (modelCell.type) {
        case cellTypeNormal:
        {
            static NSString *cellIdentifier = @"skGroupTitleTableViewCell";
            skGroupTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = skXibView(@"skGroupTitleTableViewCell");
            }
            cell.labTitle.text=modelCell.title;
            
            
            switch (modelCell.typeTitle) {
                case cellTitleTypeTitle:
                {
                    if ([modelCell.title isEqualToString:@"群公告"]) {
                        [cell.labWare setHidden:NO];
                        [cell.imageHeader setHidden:YES];
                        cell.labWare.text=self.modelGonggao.noticeContent;
                    }else if([modelCell.title isEqualToString:@"群名称"]){
                        [cell.labWare setHidden:NO];
                        [cell.imageHeader setHidden:YES];
                        cell.labWare.text=self.model.groupName;
                    }
                    
                }
                    break;
                case cellTitleTypeImage:
                {
                    [cell.labWare setHidden:YES];
                    [cell.imageHeader setHidden:NO];
                    [cell.imageHeader sd_setImageWithURL:[NSURL URLWithString:self.model.groupIcon] placeholderImage:[UIImage imageNamed:@"touxiang"]];
                }
                    break;
                case cellTitleTypeNormal:
                {
                    [cell.labWare setHidden:YES];
                    [cell.imageHeader setHidden:YES];
                }
                    break;
                    
                default:
                    break;
            }
            
            return cell;
        }
            
            break;
        case cellTypeTitle:
        {
            static NSString *cellIdentifier = @"skGroupGonggaoTableViewCell";
            skGroupGonggaoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = skXibView(@"skGroupGonggaoTableViewCell");
            }
            return cell;
        }
            break;
        case cellTypeHeader:
        {
            return self.cellHeaders;
        }
            break;
            
        default:
            break;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==self.modelCell.arrList.count-1) {
        return 50;
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, skScreenWidth, 50)];
    view.backgroundColor=KcolorBackground;
    UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(20, 10, skScreenWidth-40, 40)];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn setTitle:@"解散或退出群聊" forState:(UIControlStateNormal)];
    [btn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [btn skSetBoardRadius:5 Width:0 andBorderColor:nil];
    @weakify(self)
    [[btn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        if ([skUser.userNo isEqualToString:self.model.createUserNo]) {//群主
            [self bizGroupDelete];
        }else{//群员
            [self bizGroupUserDelete];
        }
    }];
    [view addSubview:btn];
    
    return view;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
    NSArray *arr=[self.modelCell.arrList objectAtIndex:indexPath.section];
    groupCellModel *modelCell=[arr objectAtIndex:indexPath.row];
    
    if ([modelCell.title isEqualToString:@"邀请好友"]) {//除了邀请好友大家都有权限,其他的权限只有群主
        
        skQRcodeGroupViewController *QEView=[[skQRcodeGroupViewController alloc] init];
        QEView.modelOther=self.model;
        QEView.view.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.5];
        
        QEView.modalPresentationStyle = UIModalPresentationOverFullScreen;
        
        [self presentViewController:QEView animated:NO completion:^{

        }];
    }else{
        if ([skUser.userNo isEqualToString:self.model.createUserNo]) {
            if ([modelCell.title isEqualToString:@"群头像"]) {
                [skImagePicker showImagePickerFromViewController:self allowsEditing:YES finishAction:^(UIImage *image) {
                    [self bizGroupupdate:@"" image:image];
                }];
                return;
            }
            if ([modelCell.title isEqualToString:@"发布活动"]) {
                if ([skUser.alipayQrCodeUrl length]>0||[skUser.wechatQrCodeUrl length]>0) {
                    skGroupAcivityViewController *viewActivice=[[skGroupAcivityViewController alloc] init];
                    viewActivice.modelOther=self.model;
                    [self.navigationController pushViewController:viewActivice animated:YES];
                }else{
                    [skClassMethod skAlertView:@"温馨提示" alertViewMessage:@"没有设置收款码,是否前往设置?" cancleTitle:@"取消" defaultTitle:@"确定" cancleHandler:^(UIAlertAction * _Nonnull action) {
                        
                    } sureHandler:^(UIAlertAction * _Nonnull action) {
                        skUserInfoSetViewController *view=[[skUserInfoSetViewController alloc] init];
                        [self.navigationController pushViewController:view animated:YES];
                    }];
                    
                }
                
                return;
            }
            if ([modelCell.title isEqualToString:@"申请合并群聊"]) {
                skCombineGroupViewController *view=[[skCombineGroupViewController alloc] init];
                view.modelOther=self.model;
                [self.navigationController pushViewController:view animated:YES];
                return;
            }
            if ([modelCell.title isEqualToString:@"群公告"]) {
                skGonggaoViewController *view=[[skGonggaoViewController alloc] init];
                view.modelOther=self.model;
                [self.navigationController pushViewController:view animated:YES];
                return;
            }
            if ([modelCell.title isEqualToString:@"群名称"]) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"群名称" message:nil preferredStyle:UIAlertControllerStyleAlert];
                //以下方法就可以实现在提示框中输入文本；
                
                //在AlertView中添加一个输入框
                [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                    
                    textField.placeholder = @"输入群名称";
                    textField.text=self.model.groupName;
                    
                }];
                
                //添加一个确定按钮 并获取AlertView中的第一个输入框 将其文本赋值给BUTTON的title
                [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    UITextField *envirnmentNameTextField = alertController.textFields.firstObject;
                    [self bizGroupupdate:envirnmentNameTextField.text image:nil];
                }]];
                
                //添加一个取消按钮
                [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
                
                //present出AlertView
                [self presentViewController:alertController animated:true completion:nil];
            }
            
            NSString *viewString=modelCell.goViewName;
            UIViewController *view=[[NSClassFromString(viewString) alloc] init];
            [self.navigationController pushViewController:view animated:YES];
        }else{
            [SkToast SkToastShow:@"只有群主有权限操作" withHight:300];
        }
    }
    
}



-(void)bizGroupupdate:(NSString *)name image:(UIImage*)image{
    
    ///intf/bizUser/sendRegister
    NSDictionary *dic;
    if (name.length>0) {
        dic=@{@"groupName":name.length>0?name:self.model.groupName,
              @"groupNo":self.model.groupNo
              };
    }
    if (image) {
        dic=@{
              @"groupName":name.length>0?name:self.model.groupName,
              @"groupNo":self.model.groupNo,
              @"groupIconBase64":[self imageBase64:image]
              };
    }
    
    [skAfTool SKPOST:skUrl(@"/intf/bizGroup/update") pubParame:skPubParType(0) busParame:[dic skDicToJson:dic] showHUD:YES showErrMsg:YES success:^(skResponeModel *  _Nullable responseObject) {
        
        if (responseObject.returnCode==0) {
            self.model=[GroupDesModel mj_objectWithKeyValues:responseObject.data];
            
            RCGroup *group=[[RCGroup alloc] init];
            group.groupName=self.model.groupName;
            group.groupId=self.model.groupNo;
            group.portraitUri=self.model.groupIcon;
            
            [[RCIM sharedRCIM] refreshGroupInfoCache:group withGroupId:self.model.groupNo];
            
            [self.tableView reloadData];
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}
/**
 对图片进行base64两次加密
 
 @param image 要加密的图片
 @return 加密后的字符串
 */
- (NSString *)imageBase64:(UIImage *)image
{
    //图片转base64
    NSData *data = UIImageJPEGRepresentation(image, 1.0f);
    
    NSString *encodedImageString = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    NSData *dataString = [encodedImageString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *base64String = [dataString base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    return base64String;
}
#pragma mark -  查询群成员
/**
 查询群成员
 */
-(void)bizGroupMergeauditList{
    ///intf/bizUser/sendRegister
    NSDictionary *dic=@{@"groupNo":self.model.groupNo?self.model.groupNo:@""};
    
    [skAfTool SKPOST:skUrl(@"/intf/bizGroupUser/list") pubParame:skPubParType(0) busParame:[dic skDicToJson:dic] showHUD:NO showErrMsg:NO success:^(skResponeModel *  _Nullable responseObject) {
        
        if (responseObject.returnCode==0) {
            skResponeList *modelList=[skResponeList mj_objectWithKeyValues:responseObject.data];
            
            self.arrListGroupHeader=[groupUserModel mj_objectArrayWithKeyValuesArray:modelList.list];
            self.cellHeaders.arrModelList=self.arrListGroupHeader;
            NSString *title=[NSString stringWithFormat:@"共%ld人>",self.arrListGroupHeader.count];
            [self.cellHeaders.viewMore.btnMore setTitle:title forState:(UIControlStateNormal)];
            [self.cellHeaders.collectionView reloadData];
            [self.tableView reloadData];
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}

#pragma mark - 退出群聊
-(void)bizGroupUserDelete{
    ///intf/bizUser/sendRegister
    NSDictionary *dic=@{@"groupNo":self.model.groupNo
                        };
    
    
    [skAfTool SKPOST:skUrl(@"/intf/bizGroupUser/delete") pubParame:skPubParType(0) busParame:[dic skDicToJson:dic] showHUD:YES showErrMsg:YES success:^(skResponeModel *  _Nullable responseObject) {
        
        if (responseObject.returnCode==0) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}
#pragma mark - 解散群聊
///intf/bizGroup/delete
-(void)bizGroupDelete{
    ///intf/bizUser/sendRegister
    NSDictionary *dic=@{@"groupNo":self.model.groupNo
                        };
    
    
    [skAfTool SKPOST:skUrl(@"/intf/bizGroup/delete") pubParame:skPubParType(0) busParame:[dic skDicToJson:dic] showHUD:YES showErrMsg:YES success:^(skResponeModel *  _Nullable responseObject) {
        
        if (responseObject.returnCode==0) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}

/**
 获取公告最新的一条
 */
-(void)getNewest{
    ///intf/bizUser/sendRegister
    NSDictionary *dic=@{@"groupNo":self.model.groupNo,
                        };
    [skAfTool SKPOST:skUrl(@"/intf/bizGroupNotice/getNewest") pubParame:skPubParType(0) busParame:[dic skDicToJson:dic] showHUD:NO showErrMsg:NO success:^(skResponeModel *  _Nullable responseObject) {
        
        if (responseObject.returnCode==0) {
            
            self.modelGonggao=[chatGonggaoModel mj_objectWithKeyValues:responseObject.data];
            
            [self.tableView reloadData];
            
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}
@end
