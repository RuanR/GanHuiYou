//
//  StevTableView.h
//  Stev_Framework
//
//  Created by 孙向前 on 14-5-20.
//  Copyright (c) 2014年 孙向前. All rights reserved.
//

#import <Foundation/Foundation.h>

#define RHTableView_PageSize 10
@interface StevTableView : UITableView

@property (nonatomic,copy)NSString *urlString;
@property (nonatomic, strong) NSMutableArray *dataArray;

- (void)showRefreshHeader;
- (void)hiddenRefreshHeader;
- (void)showLoadmoreFooter;
- (void)hiddenLoadmoreFooter;

- (void)refresh;

@end
