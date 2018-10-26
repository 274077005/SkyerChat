//
//  skGroupModel.h
//  SkyerChat
//
//  Created by admin on 2018/10/24.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface skGroupModel : NSObject
@property (nonatomic , copy) NSString              * groupName;
@property (nonatomic , assign) NSInteger              groupType;
@property (nonatomic , assign) NSInteger              groupId;
@property (nonatomic , copy) NSString              * groupNo;
@property (nonatomic , copy) NSString              * groupIcon;
@end

NS_ASSUME_NONNULL_END
