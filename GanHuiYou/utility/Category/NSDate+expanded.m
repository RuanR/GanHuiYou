//
//  NSDate+expanded.m
//  Stev_Framework
//
//  Created by 孙向前 on 14-9-4.
//  Copyright (c) 2014年 孙向前. All rights reserved.
//

#import "NSDate+expanded.h"

@implementation NSDate (expanded)
/**
 *  获取NSDateComponents ，通过其计算时间差
 *
 *  @param endDate 时间字符串
 *
 *  @return NSDateComponents对象
 */
- (NSDateComponents *)countTimeWithEndDate:(NSDate *)endDate{
    if (!endDate) {
        return nil;
    }
    NSCalendar* chineseClendar = [ [ NSCalendar alloc ] initWithCalendarIdentifier:NSGregorianCalendar ];
    NSUInteger unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit;
    NSDateComponents *cps = [ chineseClendar components:unitFlags fromDate:self  toDate:endDate  options:0];
    return cps;
}
/**
 *  获取NSDateComponents ，通过其计算时间差
 *
 *  @param dateFormatStr 格式化标准
 *  @param endDateStr    时间字符串
 *
 *  @return NSDateComponents对象
 */
- (NSDateComponents *)countTimeWithFormatStr:(NSString *)dateFormatStr withEndDateStr:(NSString *)endDateStr{
    if (!endDateStr.length) {
        return nil;
    }
    if (!dateFormatStr.length) {
        dateFormatStr = @"yyyyMMddHHmmss";
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormatStr];
    NSDate *toDate = [dateFormatter dateFromString:endDateStr];
    return [self countTimeWithEndDate:toDate];
}

@end
