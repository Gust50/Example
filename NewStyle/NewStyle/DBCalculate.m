//
//  DBCalculate.m
//  NewStyle
//
//  Created by 段博 on 16/10/2.
//  Copyright © 2016年 DuanBo. All rights reserved.
//

#import "DBCalculate.h"

@implementation DBCalculate

//判断边界
+(CGRect)judgeEdgewWithFrame:(CGRect)tankFrame withDireection:(NSInteger)direction{
    
    NSInteger move_w = tankFrame.size.width/2 ;
    NSInteger leftEdge = tankFrame.size.width * 5 + 0.5 ;
    NSInteger rightEdge = tankFrame.size.width * 17 +2 ;
   
    switch (direction) {
        case 1:
        {
            if (tankFrame.origin.y - move_w >= TOP_EDGE) {
                tankFrame.origin.y -= move_w ;
                
            }
            return tankFrame ;

        }
            break;
        case 2:
        {
            if (CGRectGetMaxY(tankFrame) + move_w <= SCREEN_H) {
                tankFrame.origin.y += move_w ;
            }
            return tankFrame ;

        }
            break;
            
        case 3:
        {

            if (tankFrame.origin.x - move_w >= leftEdge) {
                tankFrame.origin.x -= move_w ;
            }
            return tankFrame ;
            
        }
            break;
            
        case 4:
        {
            if (CGRectGetMaxX(tankFrame) + move_w <= rightEdge) {
                tankFrame.origin.x += move_w ;
            }
            return tankFrame ;
            
        }
            break;
            
        default:
            break;
            
    }
    
    return tankFrame;
}

//判断障碍物
+(BOOL)judgeCollidedWithBrick:(NSArray*)BrickArray TankFrame:(CGRect)tankFrame moveDirection:(NSInteger)direction{
    

    NSInteger move_w = tankFrame.size.width/2 ;
    NSInteger leftEdge = tankFrame.size.width * 5 + 0.5 ;
    NSInteger rightEdge = tankFrame.size.width * 17 +2 ;

    
    switch (direction) {
        case 1:
        {
            if (tankFrame.origin.y - move_w >= TOP_EDGE) {
                tankFrame.origin.y -= move_w ;
                
            }
            return YES ;
            
        }
            break;
        case 2:
        {
            if (CGRectGetMaxY(tankFrame) + move_w <= SCREEN_H) {
                tankFrame.origin.y += move_w ;
            }
            return YES ;
            
        }
            break;
            
        case 3:
        {
            
            if (tankFrame.origin.x - move_w >= leftEdge) {
                tankFrame.origin.x -= move_w ;
            }
            return YES ;
            
        }
            break;
            
        case 4:
        {
            if (CGRectGetMaxX(tankFrame) + move_w <= rightEdge) {
                tankFrame.origin.x += move_w ;
            }
            return YES ;
            
        }
            break;
            
        default:
            break;
            
    }

    
    return YES ;
}
@end
