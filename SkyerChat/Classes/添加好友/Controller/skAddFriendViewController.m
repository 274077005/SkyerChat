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

@interface skAddFriendViewController ()

@property (nonatomic,strong) NSArray *arrList;
@property (nonatomic,strong) NSMutableArray *arrListPhone;
@property (nonatomic,strong) NSMutableArray *arrListPhoneBack;

@end

@implementation skAddFriendViewController

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
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop);
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"添加好友";
    [PPGetAddressBook requestAddressBookAuthorization];
    //获取按联系人姓名首字拼音A~Z排序(已经对姓名的第二个字做了处理)
    
    [PPGetAddressBook getOriginalAddressBook:^(NSArray<PPPersonModel *> *addressBookArray) {
        self.arrList=addressBookArray;
        [self.tableView reloadData];
        [self findByPhoneNos];
    } authorizationFailure:^{
        UIAlertController *view=[UIAlertController alertControllerWithTitle:@"允许访问权限" message:@"设置-隐私-通讯录”选项中，允许APP访问您的通讯录" preferredStyle:(UIAlertControllerStyleAlert)];
        
        UIAlertAction *action=[UIAlertAction actionWithTitle:@"明白" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [view addAction:action];
    }];
    
    [self addTableView];
    
    [self createRefreshHeaderViewWithBlock:^{
        
    }];
    [self createRefreshFooterViewWithBlock:^{
        
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
    
    static NSString *cellIdentifier = @"skAddFriendTableViewCell";
    skAddFriendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = skXibView(@"skAddFriendTableViewCell");
    }
    
    PPPersonModel *model=[self.arrList objectAtIndex:indexPath.row];
    cell.labName.text=model.name;
    cell.btnPhone.text=[model.mobileArray firstObject];
    
    if ([self.arrList containsObject:[model.mobileArray firstObject]]) {
        [cell.btnAddFriend setTitle:@"已添加" forState:(UIControlStateNormal)];
        [cell.btnAddFriend setBackgroundColor:[UIColor grayColor]];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


-(void)addFriend{
    ///intf/bizUser/sendRegister
    NSDictionary *dic=@{@"phoneNo":skUser.phoneNo
                        };
    
    [skAfTool SKPOST:skUrl(@"/intf/bizLinker/create") pubParame:skPubParType(0) busParame:[dic skDicToJson:dic] showHUD:YES showErrMsg:YES success:^(skResponeModel *  _Nullable responseObject) {
        
        if (responseObject.returnCode==0) {
            
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}


-(void)findByPhoneNos{
    ///intf/bizUser/sendRegister
    
    for (int i =0; i<self.arrList.count; ++i) {
        PPPersonModel *model=[self.arrList objectAtIndex:i];
        NSString *phone=[model.mobileArray firstObject];
        if (!phone) {
            phone=@"1";
        }
        [self.arrListPhone addObject:phone];
    }
    
    
    NSDictionary *dic=@{@"phoneNos":self.arrListPhone
                        };
    
    
    [skAfTool SKPOST:skUrl(@"/intf/bizLinker/findByPhoneNos") pubParame:skPubParType(0) busParame:[dic skDicToJson:dic] showHUD:YES showErrMsg:YES success:^(skResponeModel *  _Nullable responseObject) {
        
        if (responseObject.returnCode==0) {
            
            skResponeList *modelList=[skResponeList mj_objectWithKeyValues:responseObject.data];
            
            [skLinkFriendModel mj_objectArrayWithKeyValuesArray:modelList.list];
            
            
            
            [self.tableView reloadData];
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}
@end
