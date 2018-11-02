//
//  skAddFriendViewController.m
//  SkyerChat
//
//  Created by admin on 2018/10/16.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "skAddFriendViewController.h"
#import "PPGetAddressBook.h"
#import "skAddFriendTableViewCell.h"
#import "skAddressBookModel.h"
#import "skLinkFriendModel.h"
#import "UIImageView+WebCache.h"

@interface skAddFriendViewController ()

@property (nonatomic,strong) NSArray *arrList;
@property (nonatomic,strong) NSMutableArray *arrListPhone;
@property (nonatomic,strong) NSMutableArray *arrListPhoneBack;
@property (nonatomic,strong) NSMutableDictionary *dicPhone;


@end

@implementation skAddFriendViewController
- (NSMutableDictionary *)dicPhone{
    if (nil==_dicPhone) {
        _dicPhone=[[NSMutableDictionary alloc] init];
    }
    return _dicPhone;
}
- (NSMutableArray *)arrListPhone{
    if (nil==_arrListPhone) {
        _arrListPhone=[[NSMutableArray alloc] init];
    }
    return _arrListPhone;
}
- (NSMutableArray *)arrListPhoneBack{
    if (nil==_arrListPhoneBack) {
        _arrListPhoneBack=[[NSMutableArray alloc] init];
    }
    return _arrListPhoneBack;
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
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"添加手机通讯录好友";
    [PPGetAddressBook requestAddressBookAuthorization];
    //获取按联系人姓名首字拼音A~Z排序(已经对姓名的第二个字做了处理)
    
    [PPGetAddressBook getOriginalAddressBook:^(NSArray<PPPersonModel *> *addressBookArray) {
        self.arrList=addressBookArray;
        
        [self findByPhoneNos];
        
    } authorizationFailure:^{
        UIAlertController *view=[UIAlertController alertControllerWithTitle:@"允许访问权限" message:@"设置-隐私-通讯录”选项中，允许APP访问您的通讯录" preferredStyle:(UIAlertControllerStyleAlert)];
        
        UIAlertAction *action=[UIAlertAction actionWithTitle:@"明白" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [view addAction:action];
    }];
    
    [self addTableView];
    
//    [self createRefreshHeaderViewWithBlock:^{
//        
//    }];
//    [self createRefreshFooterViewWithBlock:^{
//        
//    }];
    
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
    
    return self.arrListPhoneBack.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 56;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"skAddFriendTableViewCell";
    skAddFriendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = skXibView(@"skAddFriendTableViewCell");
    }
    
    skLinkFriendModel *model=[self.arrListPhoneBack objectAtIndex:indexPath.row];
    cell.labName.text=model.nickName?model.nickName:model.userNo;
    Boolean isAdd=model.isAdded;
    
    cell.labPhone.text=[NSString stringWithFormat:@"[手机联系人]%@",[self.dicPhone objectForKey:model.phoneNo]];
    
    if (isAdd) {
        [cell.btnAddFriend setTitle:@"已添加" forState:(UIControlStateNormal)];
        [cell.btnAddFriend setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
        [cell.btnAddFriend setEnabled:NO];
    }else{
        [cell.btnAddFriend setTitle:@"添加" forState:(UIControlStateNormal)];
        [cell.btnAddFriend setTitleColor:KcolorMain forState:(UIControlStateNormal)];
        [cell.btnAddFriend skSetBoardRadius:3 Width:1 andBorderColor:KcolorMain];
        [cell.btnAddFriend setEnabled:YES];
    }
    [cell.imageHeader sd_setImageWithURL:[NSURL URLWithString:model.portrait]];
    [cell.imageHeader skSetBoardRadius:22 Width:0 andBorderColor:[UIColor clearColor]];
    @weakify(self)
    [[cell.btnAddFriend rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        NSString *userNo=model.userNo;
        [self bizLinkerAddFriend:userNo];
    }];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)findByPhoneNos{
    ///intf/bizUser/sendRegister
    
    for (int i =0; i<self.arrList.count; ++i) {
        PPPersonModel *model=[self.arrList objectAtIndex:i];
        NSString *phone=[model.mobileArray firstObject];
        NSString *name=model.name;
        if (!phone) {
            phone=@"1";
        }
        [self.dicPhone setValue:name forKey:phone];
        [self.arrListPhone addObject:phone];
    }
    
    
    NSDictionary *dic=@{@"phoneNos":self.arrListPhone
                        };
    
    
    [skAfTool SKPOST:skUrl(@"/intf/bizLinker/findByPhoneNos") pubParame:skPubParType(0) busParame:[dic skDicToJson:dic] showHUD:YES showErrMsg:YES success:^(skResponeModel *  _Nullable responseObject) {
        
        if (responseObject.returnCode==0) {
            
            skResponeList *modelList=[skResponeList mj_objectWithKeyValues:responseObject.data];
            
           self.arrListPhoneBack =[skLinkFriendModel mj_objectArrayWithKeyValuesArray:modelList.list];
            
            [self.tableView reloadData];
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}


-(void)bizLinkerAddFriend:(NSString *)userNo{
    ///intf/bizUser/sendRegister
    NSDictionary *dic=@{@"userNo":userNo
                        };
    
    
    [skAfTool SKPOST:skUrl(@"/intf/bizLinker/create") pubParame:skPubParType(0) busParame:[dic skDicToJson:dic] showHUD:YES showErrMsg:YES success:^(skResponeModel *  _Nullable responseObject) {
        
        if (responseObject.returnCode==0) {
            [SkToast SkToastShow:@"添加好友成功" withHight:300];
            [self.tableView reloadData];
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}
@end
