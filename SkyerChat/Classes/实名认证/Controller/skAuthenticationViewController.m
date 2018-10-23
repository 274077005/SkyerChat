//
//  skAuthenticationViewController.m
//  SkyerChat
//
//  Created by admin on 2018/10/23.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import "skAuthenticationViewController.h"
#import "skAuthenticationTableViewCell.h"
#import "skAuthenticationModel.h"

@interface skAuthenticationViewController ()
@property (nonatomic,strong) skAuthenticationModel *model;
@end

@implementation skAuthenticationViewController

- (skAuthenticationModel *)model{
    if (nil==_model) {
        _model=[[skAuthenticationModel alloc] init];
    }
    return _model;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"实名认证";
    [self addTableView];
    if (skUser.idcardNo.length==0) {
        @weakify(self)
        [[[self skCreatBtn:@"认证" btnTitleOrImage:(btntypeTitle) btnLeftOrRight:(btnStateRight)] rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [self bizUserUpdate];
        }];
    }
    
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
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"skAuthenticationTableViewCell";
    skAuthenticationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = skXibView(@"skAuthenticationTableViewCell");
    }
    switch (indexPath.row) {
        case 0:
        {
            cell.labTitle.text=@"真实姓名:";
            if (skUser.idcardNo.length>0) {
                [cell.textInfo setEnabled:NO];
            }
            cell.textInfo.placeholder=@"请输入真实姓名";
            cell.textInfo.text=skUser.realName;
            RAC(self.model,name)=cell.textInfo.rac_textSignal;
        }
            break;
        case 1:
        {
            if (skUser.idcardNo.length>0) {
                [cell.textInfo setEnabled:NO];
            }
            cell.labTitle.text=@"身份证号:";
            cell.textInfo.placeholder=@"请输入身份证号码";
            cell.textInfo.text=skUser.idcardNo;
            RAC(self.model,IDNO)=cell.textInfo.rac_textSignal;
        }
            break;
            
        default:
            break;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)bizUserUpdate{
    ///intf/bizUser/sendRegister
    NSDictionary *dic=@{@"realName":self.model.name,
                        @"idcardNo":self.model.IDNO,
                        @"phoneNo":skUser.phoneNo,
                        @"smsCode":@""
                        };
    
    
    [skAfTool SKPOST:skUrl(@"/intf/bizUser/update") pubParame:skPubParType(0) busParame:[dic skDicToJson:dic] showHUD:YES showErrMsg:YES success:^(skResponeModel *  _Nullable responseObject) {
        
        if (responseObject.returnCode==0) {
            
            self.model=[skAuthenticationModel mj_objectWithKeyValues:responseObject.data];
            skUser.idcardNo=self.model.idcardNo;
            skUser.realName=self.model.realName;
            [SkToast SkToastShow:@"修改成功" withHight:300];
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}
@end
