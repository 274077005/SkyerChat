//
//  groupCostemModel.m
//  SkyerChat
//
//  Created by admin on 2018/11/2.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import "groupCostemModel.h"
#import "groupCellModel.h"

@implementation groupCostemModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setDataWithUser];
    }
    return self;
}
-(void)setDataWithUser{
    self.arrList=[[NSMutableArray alloc] init];
    
    groupCellModel *model7=[[groupCellModel alloc] init];
    model7.title=@"群头像";
    model7.goViewName=@"";
    model7.type=cellTypeHeader;
    NSArray *arr0=@[model7];
    [self.arrList addObject:arr0];
    
    groupCellModel *model0=[[groupCellModel alloc] init];
    model0.title=@"群公告";
    model0.goViewName=@"";
    model0.type=cellTypeNormal;
    
    groupCellModel *model1=[[groupCellModel alloc] init];
    model1.title=@"群头像";
    model1.goViewName=@"";
    model1.typeTitle=cellTitleTypeImage;
    model1.type=cellTypeNormal;
    
    groupCellModel *model2=[[groupCellModel alloc] init];
    model2.title=@"群名称";
    model2.goViewName=@"";
    model2.typeTitle=cellTitleTypeTitle;
    model2.type=cellTypeNormal;
    
    NSArray *arr1=@[model0,model1,model2];
    [self.arrList addObject:arr1];
    
    groupCellModel *model3=[[groupCellModel alloc] init];
    model3.title=@"发布活动";
    model3.goViewName=@"skGroupAcivityViewController";
    model3.type=cellTypeNormal;
    
    groupCellModel *model4=[[groupCellModel alloc] init];
    model4.title=@"邀请好友";
    model4.goViewName=@"";
    model4.type=cellTypeNormal;
    
    groupCellModel *model5=[[groupCellModel alloc] init];
    model5.title=@"申请合并群聊";
    model5.goViewName=@"";
    model5.type=cellTypeNormal;
    
//    groupCellModel *model6=[[groupCellModel alloc] init];
//    model6.title=@"解散群";
//    model6.goViewName=@"";
//    model6.type=cellTypeNormal;
    NSArray *arr2=@[model3,model4,model5];
    [self.arrList addObject:arr2];
    
}
@end
