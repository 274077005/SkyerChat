//
//  skAuthenticationModel.h
//  SkyerChat
//
//  Created by admin on 2018/10/23.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface skAuthenticationModel : NSObject
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *IDNO;
@property (nonatomic , assign) NSInteger              userId;
@property (nonatomic , copy) NSString              * realName;
@property (nonatomic , copy) NSString              * idcardNo;
@property (nonatomic , copy) NSString              * phoneNo;
@end

NS_ASSUME_NONNULL_END
