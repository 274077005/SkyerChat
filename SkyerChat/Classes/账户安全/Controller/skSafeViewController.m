//
//  skSafeViewController.m
//  SkyerChat
//
//  Created by admin on 2018/10/22.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import "skSafeViewController.h"
#import "skSafeTableViewCell.h"
#import "skChangePasswordViewController.h"

@interface skSafeViewController ()

@end

@implementation skSafeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"账户安全";
    [self addTableView];
    
    
    
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
        case 0:
        {
            return 1;
        }
            break;
        case 1:
        {
            return 2;
        }
            break;
            
        default:
            break;
    }
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    
    static NSString *cellIdentifier = @"skSafeTableViewCell";
    skSafeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = skXibView(@"skSafeTableViewCell");
    }
    
    switch (indexPath.section) {
        case 0:
        {
            cell.labTitle.text=@"重置密码";
            cell.labContain.text=@"";
            return cell;
        }
            break;
        case 1:
        {
            
            switch (indexPath.row) {
                case 0:
                {
                    cell.labTitle.text=@"实名认证";
                    cell.labContain.text=@"已认证";
                }
                    break;
                case 1:
                {
                    cell.labTitle.text=@"电话";
                    cell.labContain.text=skUser.phoneNo;
                    [cell setAccessoryType:(UITableViewCellAccessoryNone)];
                }
                    break;
                    
                default:
                    break;
            }
            return cell;
        }
            break;
            
        default:
            break;
            
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 0:
            {
                skChangePasswordViewController *view=[[skChangePasswordViewController alloc] init];
                [self.navigationController pushViewController:view animated:YES];
            }
            break;
            
        default:
            break;
    }
}

@end
