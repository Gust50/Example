//
//  DBTimeChange.h
//  NewStyle
//
//  Created by 段博 on 2016/10/17.
//  Copyright © 2016年 DuanBo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBTimeChange : NSObject
+ (NSString *)getStringFromCMTime:(CMTime)time;
+ (NSString *)getVideoLengthFromTimeLength:(float)timeLength;
@end
