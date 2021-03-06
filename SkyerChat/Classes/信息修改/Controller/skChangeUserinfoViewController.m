//
//  skChangeUserinfoViewController.m
//  SkyerChat
//
//  Created by admin on 2018/10/11.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "skChangeUserinfoViewController.h"
#import "skChangeUserinfoHeaderTableViewCell.h"
#import "skChangeUserinfoNikeNameTableViewCell.h"
#import "skImagePicker.h"
#import "skChangeUserinfoModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface skChangeUserinfoViewController ()

@end

@implementation skChangeUserinfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"设置头像昵称";
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

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            return 60;
        }
            break;
        case 1:
        {
            return 50;
        }
            break;
            
            
        default:
            break;
    }
    return 50;
}



- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0:
        {
            static NSString *cellIdentifier = @"skChangeUserinfoHeaderTableViewCell";
            skChangeUserinfoHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = skXibView(@"skChangeUserinfoHeaderTableViewCell");
            }
            
            [cell.imageHeader sd_setImageWithURL:[NSURL URLWithString:skUser.portrait] placeholderImage:[UIImage imageNamed:@"touxian"]];
            return cell;
        }
            break;
        case 1:
        {
            static NSString *cellIdentifier = @"skChangeUserinfoNikeNameTableViewCell";
            skChangeUserinfoNikeNameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = skXibView(@"skChangeUserinfoNikeNameTableViewCell");
            }
            cell.labNikeName.text=skUser.nickName;
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
    switch (indexPath.row) {
        case 0:
        {
            [skImagePicker showImagePickerFromViewController:self allowsEditing:YES finishAction:^(UIImage *image) {
                [self changeUserInfo:image andNikeName:@""];
            }];
        }
            break;
        case 1:
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"修改昵称" message:nil preferredStyle:UIAlertControllerStyleAlert];
            //以下方法就可以实现在提示框中输入文本；
            
            //在AlertView中添加一个输入框
            [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                
                textField.placeholder = @"输入昵称";
                textField.text=skUser.nickName;
                
            }];
            
            //添加一个确定按钮 并获取AlertView中的第一个输入框 将其文本赋值给BUTTON的title
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                UITextField *envirnmentNameTextField = alertController.textFields.firstObject;
                [self changeUserInfo:nil andNikeName:envirnmentNameTextField.text];
                
            }]];
            
            //添加一个取消按钮
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
            
            //present出AlertView
            [self presentViewController:alertController animated:true completion:nil];
        }
            break;
            
        default:
            break;
    }
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

-(void)changeUserInfo:(UIImage *)image andNikeName:(NSString *)name{
    
    NSDictionary *dic=@{@"nickName":name,
                        @"portraitBase64":image?[self imageBase64:image]:@""
                        };
    
    [skAfTool SKPOST:skUrl(@"/intf/bizUser/update") pubParame:skPubParType(0) busParame:[dic skDicToJson:dic] showHUD:YES showErrMsg:YES success:^(skResponeModel *  _Nullable responseObject) {
        
        if (responseObject.returnCode==0) {
            
            skChangeUserinfoModel *model=[skChangeUserinfoModel mj_objectWithKeyValues:responseObject.data];
            
            if (image) {
                skUser.portrait=model.portrait;
            }
            if (name.length>0) {
                skUser.nickName=model.nickName;
            }
            
            
            [self.tableView reloadData];
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}
@end
