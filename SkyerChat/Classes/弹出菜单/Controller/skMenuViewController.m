//
//  skMenuViewController.m
//  SkyerChat
//
//  Created by admin on 2018/10/26.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import "skMenuViewController.h"
#import "menuTableViewCell.h"

@interface skMenuViewController ()

@end

@implementation skMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addTableView];
}
-(void)addTableView{
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor=[UIColor whiteColor];
    self.tableView.bounces = NO;
    CGFloat hight=self.arrTitle.count*40;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_topLayoutGuide).offset(50);
        make.right.mas_equalTo(-30);
        make.size.mas_equalTo(CGSizeMake(120, hight));
    }];
    
//    [self.tableView skSetShadowWithColor:KcolorMain andSizeMake:CGSizeMake(0, 0) Radius:5];
    [self.tableView skSetBoardRadius:5 Width:1 andBorderColor:[UIColor groupTableViewBackgroundColor]];
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
    return self.arrTitle.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"menuTableViewCell";
    menuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = skXibView(@"menuTableViewCell");
    }
    cell.labTitle.text=self.arrTitle[indexPath.row];
    if (indexPath.row==self.arrTitle.count-1) {
        [cell.labLine setHidden:YES];
    }
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.chargeType(indexPath.row);
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
}
@end
