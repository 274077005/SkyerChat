//
//  groupUserModel.h
//  SkyerChat
//
//  Created by admin on 2018/11/1.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface groupUserModel : NSObject
@property (nonatomic , copy) NSString              * joinTime;
@property (nonatomic , assign) NSInteger              groupId;
@property (nonatomic , copy) NSString              * userNo;
@property (nonatomic , assign) NSInteger              memberType;
@property (nonatomic , copy) NSString              * portrait;
@property (nonatomic , assign) NSInteger              userId;
@property (nonatomic , assign) BOOL              isGag;
@end

NS_ASSUME_NONNULL_END
