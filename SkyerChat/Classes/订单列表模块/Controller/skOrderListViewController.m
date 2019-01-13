//
//  skOrderListViewController.m
//  SkyerChat
//
//  Created by skyer on 2019/1/11.
//  Copyright © 2019 www.skyer.com. All rights reserved.
//

#import "skOrderListViewController.h"
#import "skOrderListTableViewCell.h"
#import "skOrderBuyersViewController.h"
#import "skSellerViewController.h"

@interface skOrderListViewController ()

@end

@implementation skOrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addTableView];
    self.title=@"订单";
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)addTableView{
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor=KcolorBackground;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop);
    }];
}
#pragma mark - 代理方法


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"skOrderListTableViewCell";
    skOrderListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = skXibView(@"skOrderListTableViewCell");
    }
    switch (indexPath.row) {
        case 0:
        {
            cell.labTitle.text=@"商家订单管理";
        }
            break;
        case 1:
        {
            cell.labTitle.text=@"买家订单管理";
        }
            break;
            
        default:
            break;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
        {
            skSellerViewController *view=[[skSellerViewController alloc] init];
            [self.navigationController pushViewController:view animated:YES];
        }
            break;
        case 1:
        {
            skOrderBuyersViewController *view=[[skOrderBuyersViewController alloc] init];
            [self.navigationController pushViewController:view animated:YES];
        }
            break;
            
        default:
            break;
    }
    
}
@end
