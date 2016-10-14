//
//  DBLeftView.m
//  NewStyle
//
//  Created by 段博 on 16/9/26.
//  Copyright © 2016年 DuanBo. All rights reserved.
//

#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define SCREEN_W [UIScreen mainScreen].bounds.size.width



#import "DBLeftView.h"




@implementation DBLeftView


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
     Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame

{
    if (self == [super initWithFrame:frame])
    {
        _newFrame = frame ;
        
        [self addSubview:self.leftTopImage];
        [self addSubview:self.leftBackImage];
        
        [self addSubview:self.userImage];
        [self addSubview:self.userName];
        [self addSubview:self.userDiscripe];
    }
    return self ;
}



//创建移动的气泡
-(void)setBubble{

    NSInteger  x = _newFrame.size.width ;
    CGFloat newX = arc4random() % x;
   
    UIImageView * bubbleView = [[UIImageView alloc]initWithFrame:CGRectMake(newX, _newFrame.size.height, 30, 30)];
    bubbleView.image =[UIImage imageNamed:[NSString stringWithFormat:@"bubble%d",arc4random()%3]];
    [self addSubview:bubbleView];
    
    
    CGFloat AnimH = _newFrame.size.height -  CGRectGetMaxY(_userImage.frame)-10 ; //动画路径高度,

    //动画路径
    UIBezierPath *heartTravelPath = [UIBezierPath bezierPath];
    [heartTravelPath moveToPoint:bubbleView.center];
    
    //随机终点
    CGFloat ViewX = bubbleView.center.x;
    CGFloat ViewY = bubbleView.center.y;
    CGPoint endPoint = CGPointMake(ViewX , ViewY - AnimH);
    
    //随机control点
    NSInteger j = arc4random_uniform(2);
    NSInteger travelDirection = 1- (2*j);//随机放向 -1 OR 1
    
    NSInteger m1 = ViewX + travelDirection*(arc4random_uniform(20) + 50);
    NSInteger n1 = ViewY - 60 + travelDirection*arc4random_uniform(20);
    NSInteger m2 = ViewX - travelDirection*(arc4random_uniform(20) + 50);
    NSInteger n2 = ViewY - 90 + travelDirection*arc4random_uniform(20);
    CGPoint controlPoint1 = CGPointMake(m1, n1);//control根据自己动画想要的效果做灵活的调整
    CGPoint controlPoint2 = CGPointMake(m2, n2);
    //根据贝塞尔曲线添加动画
    [heartTravelPath addCurveToPoint:endPoint controlPoint1:controlPoint1 controlPoint2:controlPoint2];
    
    //关键帧动画,实现整体图片位移
    CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyFrameAnimation.path = heartTravelPath.CGPath;
    keyFrameAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    keyFrameAnimation.duration = 6 ;//往上飘动画时长,可控制速度
    [bubbleView.layer addAnimation:keyFrameAnimation forKey:@"positionOnPath"];

    [UIView animateWithDuration:2 delay:4 options:1 animations:^{
     
        bubbleView.alpha = 0.;


    } completion:^(BOOL finished) {
        
        [bubbleView removeFromSuperview];
    }];
    
}

-(void)startMoveBubble{
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(setBubble) userInfo:nil repeats:YES ];

    [_timer fire];
}
-(void)stopMoveBubble{
    
    [_timer invalidate];
    _timer = nil ;
}

-(UIImageView*)leftTopImage{
    if (!_leftTopImage) {
        _leftTopImage = [[UIImageView alloc]initWithFrame:CGRectMake( 0, 0 , _newFrame.size.width, _newFrame.size.height*0.25)];
        
        _leftTopImage.image = [UIImage imageNamed:@"leftTop"];
    }
    return _leftTopImage ;
}

-(UIImageView*)leftBackImage{
    if (!_leftBackImage) {
        _leftBackImage = [[UIImageView alloc]initWithFrame:CGRectMake( 0, CGRectGetMaxY(_leftTopImage.frame) , _newFrame.size.width, _newFrame.size.height*0.75)];
        _leftBackImage.image = [UIImage imageNamed:@"leftBack.jpg"];
    }
    return _leftBackImage ;
}

-(UIImageView*)userImage{
    if (!_userImage) {
        _userImage = [[UIImageView alloc]initWithFrame:CGRectMake( 15, 60, 60, 60)];
        _userImage.layer.cornerRadius = 30 ;
        _userImage.image = [UIImage imageNamed:@"userImage"];
    }
    return _userImage ;
}

-(UILabel*)userName{
    if (!_userName) {
        _userName=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_userImage.frame)+10, _userImage.frame.origin.y, _newFrame.size.width - CGRectGetMaxX(_userImage.frame) -40, 20)];
        _userName.text = @"一条猫";
        _userName.textColor = [UIColor blackColor];
        _userName.font = [UIFont systemFontOfSize:14];
        _userName.textAlignment = 1 ;
        
    }
    return _userName;
}

-(UILabel*)userDiscripe{
    if (!_userDiscripe) {
        _userDiscripe = [[UILabel alloc]initWithFrame:CGRectMake(0, _newFrame.size.height - 30, _newFrame.size.width, 30)];
        _userDiscripe.text =@"这只是一个测试的Demo,没有什么意思.就像人,活着活着就死了";
        _userDiscripe.textAlignment =1  ;
        _userDiscripe.textColor = [UIColor yellowColor];
        _userDiscripe.font = [UIFont systemFontOfSize:12];
        _userDiscripe.numberOfLines = 0 ;
    }
    return _userDiscripe;
}


@end
