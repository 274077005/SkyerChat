//
//  skResponeList.h
//  SkyerChat
//
//  Created by admin on 2018/10/15.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface skResponeList : NSObject

@property (nonatomic, assign) NSInteger endRow;
@property (nonatomic, assign) NSInteger firstPage;
@property (nonatomic, assign) BOOL hasNextPage;
@property (nonatomic, assign) BOOL hasPreviousPage;
@property (nonatomic, assign) BOOL isFirstPage;
@property (nonatomic, assign) BOOL isLastPage;
@property (nonatomic, assign) NSInteger lastPage;
@property (nonatomic, strong) NSArray * list;
@property (nonatomic, assign) NSInteger navigateFirstPage;
@property (nonatomic, assign) NSInteger navigateLastPage;
@property (nonatomic, assign) NSInteger navigatePages;
@property (nonatomic, strong) NSArray * navigatepageNums;
@property (nonatomic, assign) NSInteger nextPage;
@property (nonatomic, assign) NSInteger pageNum;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, assign) NSInteger pages;
@property (nonatomic, assign) NSInteger prePage;
@property (nonatomic, assign) NSInteger size;
@property (nonatomic, assign) NSInteger startRow;
@property (nonatomic, assign) NSInteger total;

@end

NS_ASSUME_NONNULL_END
