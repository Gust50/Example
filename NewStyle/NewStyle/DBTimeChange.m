//
//  DBTimeChange.m
//  NewStyle
//
//  Created by 段博 on 2016/10/17.
//  Copyright © 2016年 DuanBo. All rights reserved.
//

#import "DBTimeChange.h"

@implementation DBTimeChange
#pragma mark - Utils

+ (NSString *)getStringFromCMTime:(CMTime)time
{
    float currentTimeValue = (CGFloat)time.value/time.timescale;//得到当前的播放时
    
    NSDate * currentDate = [NSDate dateWithTimeIntervalSince1970:currentTimeValue];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond ;
    NSDateComponents *components = [calendar components:unitFlags fromDate:currentDate];
    
    if (currentTimeValue >= 3600 )
    {
        return [NSString stringWithFormat:@"%ld:%ld:%02ld",components.hour,components.minute,components.second];
    }
    else
    {
        return [NSString stringWithFormat:@"%ld:%02ld",components.minute,components.second];
    }
}

+ (NSString *)getVideoLengthFromTimeLength:(float)timeLength
{
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:timeLength];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond ;
    NSDateComponents *components = [calendar components:unitFlags fromDate:date];
    
    if (timeLength >= 3600 )
    {
        return [NSString stringWithFormat:@"%ld:%ld:%02ld",components.hour,components.minute,components.second];
    }
    else
    {
        return [NSString stringWithFormat:@"%ld:%02ld",components.minute,components.second];
    }
}
@end
