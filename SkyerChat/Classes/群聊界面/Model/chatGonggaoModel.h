//
//  chatGonggaoModel.h
//  SkyerChat
//
//  Created by skyer on 2018/12/13.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface chatGonggaoModel : NSObject
@property (nonatomic , assign) NSInteger              groupId;
@property (nonatomic , copy) NSString              * groupNo;
@property (nonatomic , copy) NSString              * noticeContent;
@property (nonatomic , assign) NSInteger              noticeId;
@property (nonatomic , copy) NSString              * noticeTitle;
@property (nonatomic , copy) NSString              * publishTime;
@property (nonatomic , assign) NSInteger              publisherId;
@property (nonatomic , copy) NSString              * publisherNo;
@end

NS_ASSUME_NONNULL_END
