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

@interface skAddFriendViewController ()
@property (nonatomic,strong) NSDictionary *dicArrList;
@property (nonatomic,strong) NSArray *arrCodeList;
@property (nonatomic,strong) NSArray *arrList;
@end

@implementation skAddFriendViewController
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
    [PPGetAddressBook getOrderAddressBook:^(NSDictionary<NSString *,NSArray *> *addressBookDict, NSArray *nameKeys) {
        
        self.dicArrList=addressBookDict;
        self.arrCodeList=nameKeys;
        [self.tableView reloadData];
        //addressBookDict: 装着所有联系人的字典
        //nameKeys: A~Z拼音字母数组;
        //刷新 tableView
        
    } authorizationFailure:^{
        NSLog(@"请在iPhone的“设置-隐私-通讯录”选项中，允许PPAddressBook访问您的通讯录");
        UIAlertController *view=[UIAlertController alertControllerWithTitle:@"允许访问权限" message:@"设置-隐私-通讯录”选项中，允许APP访问您的通讯录" preferredStyle:(UIAlertControllerStyleAlert)];
        
        UIAlertAction *action=[UIAlertAction actionWithTitle:@"明白" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [view addAction:action];
    }];
    
    
    [self addTableView];
    [self getAddressBookList:@""];
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
    return self.arrCodeList.count;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSString *key=self.arrCodeList[section];
    NSArray *arr=[self.dicArrList objectForKey:key];
    
    return arr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, skScreenWidth, 20)];
    lab.text=self.arrCodeList[section];
    lab.textAlignment=1;
    lab.backgroundColor=KcolorBackground;
    
    return lab;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"skAddFriendTableViewCell";
    skAddFriendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = skXibView(@"skAddFriendTableViewCell");
    }
    
    NSString *key=self.arrCodeList[indexPath.section];
    NSArray *arr=[self.dicArrList objectForKey:key];
    PPPersonModel *model=[arr objectAtIndex:indexPath.row];
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

/**
 获取通讯录列表
 
 @param keyword 关键字
 */
-(void)getAddressBookList:(NSString *)keyword{
    
    NSDictionary *dic=@{@"keyword":keyword};
    
    [skAfTool SKPOST:skUrl(@"/intf/bizLinker/list") pubParame:skPubParType(0) busParame:[dic skDicToJson:dic] showHUD:NO showErrMsg:NO success:^(skResponeModel *  _Nullable responseObject) {
        
        if (responseObject.returnCode==0) {
            
            skResponeList *modelList=[skResponeList mj_objectWithKeyValues:responseObject.data];
            
            self.arrList= [skAddressBookModel mj_keyValuesArrayWithObjectArray:modelList.list];
            
            [self.tableView reloadData];
            
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}

-(void)addFriend{
    ///intf/bizUser/sendRegister
    NSDictionary *dic=@{@"phoneNo":skUser.phoneNo
                        };
    
    [skAfTool SKPOST:skUrl(@"/intf/bizLinker/create") pubParame:skPubParType(portNameSendRegister) busParame:[dic skDicToJson:dic] showHUD:YES showErrMsg:YES success:^(skResponeModel *  _Nullable responseObject) {
        
        if (responseObject.returnCode==0) {
            
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}
@end
