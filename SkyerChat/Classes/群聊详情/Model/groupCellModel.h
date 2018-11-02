//
//  groupCellModel.h
//  SkyerChat
//
//  Created by admin on 2018/11/2.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, cellType)
{
    cellTypeNormal= 0,//普通的
    cellTypeTitle,//有文字的
    cellTypeHeader,//有文字的
};

typedef NS_ENUM(NSInteger, cellTitleType)
{
    cellTitleTypeNormal= 0,//没有文字的
    cellTitleTypeTitle,//有文字的
    cellTitleTypeImage,//有图片的
};
NS_ASSUME_NONNULL_BEGIN

@interface groupCellModel : NSObject
@property (nonatomic , copy) NSString * title;
@property (nonatomic , copy) NSString * titleRight;
@property (nonatomic , copy) NSString * goViewName;
@property (nonatomic , assign) cellType  type;
@property (nonatomic , assign) cellTitleType  typeTitle;
@end

NS_ASSUME_NONNULL_END
