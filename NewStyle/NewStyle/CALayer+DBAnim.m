//
//  CALayer+DBAnim.m
//  NewStyle
//
//  Created by 段博 on 16/9/28.
//  Copyright © 2016年 DuanBo. All rights reserved.
//

#import "CALayer+DBAnim.h"

@implementation CALayer (DBAnim)


-(void)shake{
    
    CAKeyframeAnimation * kfa = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    
    //震动幅度
    CGFloat s = 5;
    
    kfa.values = @[@(-s),@(0),@(s),@(0),@(-s),@(0),@(s),@(0)];
    
    //时长
    kfa.duration = 0.3f;
    
    //重复
    kfa.repeatCount = 4;
    
    //移除
    kfa.removedOnCompletion = YES;
    
    [self addAnimation:kfa forKey:@"shake"];
}

-(void)transformAnimation{
    
    CABasicAnimation * rotationAnimation = [[CABasicAnimation alloc]init];
    
    
    [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];//"z"还可以是“x”“y”，表示沿z轴旋转
    rotationAnimation.toValue = [NSNumber numberWithFloat:10];
    // 3 is the number of 360 degree rotations
    // Make the rotation animation duration slightly less than the other animations to give it the feel
    // that it pauses at its largest scale value
    rotationAnimation.duration = 2.0f;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]; //缓入缓出
    
    [self addAnimation:rotationAnimation forKey:@"transformAnimation"];
    

    
}







@end
