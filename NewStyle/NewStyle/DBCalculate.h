//
//  DBCalculate.h
//  NewStyle
//
//  Created by 段博 on 16/10/2.
//  Copyright © 2016年 DuanBo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBCalculate : NSObject
//判断边界
+(CGRect)judgeEdgewWithFrame:(CGRect)tankFrame withDireection:(NSInteger)direction;
//判断障碍物
+(BOOL)judgeCollidedWithBrick:(NSArray*)BrickArray TankFrame:(CGRect)tankFrame moveDirection:(NSInteger)direction;
@end
