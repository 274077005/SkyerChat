//
//  skResponeModel.h
//  TingCheDao
//
//  Created by admin on 2018/6/2.
//  Copyright © 2018年 DLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface skResponeModel : NSObject
@property (nonatomic ,assign) NSInteger returnCode;
@property (nonatomic ,strong) NSString *message;
@property (nonatomic ,strong) id data;
@end
