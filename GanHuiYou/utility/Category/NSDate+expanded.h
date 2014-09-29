//
//  NSDate+expanded.h
//  Stev_Framework
//
//  Created by 孙向前 on 14-9-4.
//  Copyright (c) 2014年 孙向前. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (expanded)

/**
 *  获取NSDateComponents ，通过其计算时间差
 *
 *  @param endDate 时间字符串
 *
 *  @return NSDateComponents对象
 */
- (NSDateComponents *)countTimeWithEndDate:(NSDate *)endDate;

/**
 *  获取NSDateComponents ，通过其计算时间差
 *
 *  @param dateFormatStr 格式化标准
 *  @param endDateStr    时间字符串
 *
 *  @return NSDateComponents对象
 */
- (NSDateComponents *)countTimeWithFormatStr:(NSString *)dateFormatStr withEndDateStr:(NSString *)endDateStr;

@end
