//
//  DBTankControl.m
//  NewStyle
//
//  Created by 段博 on 16/10/2.
//  Copyright © 2016年 DuanBo. All rights reserved.
//

#import "DBTankControl.h"




@implementation DBTankControl

@synthesize delegate;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)init{
    
    if (self==[super init]) {
        
        self.frame = CGRectMake(0, 0, SCREEN_H , SCREEN_W) ;
        
        [self setEdge];
        
        
        [self setButton];
    }
    self.userInteractionEnabled = YES ;
    return self ;
}

-(void)setEdge{
    
    UIView * leftLine = [[UIView alloc]initWithFrame:CGRectMake(TANK_MODEL_W  * 5 - 0.5, 0, 0.5 , SCREEN_W)];
    leftLine.backgroundColor = [UIColor blackColor];
    [self addSubview:leftLine];
    
    UIView * rightLine = [[UIView alloc]initWithFrame:CGRectMake(TANK_MODEL_W  * 17 + 0.5, 0, 0.5 , SCREEN_W)];
    rightLine.backgroundColor = [UIColor blackColor];
    [self addSubview:rightLine];
    
}

-(void)setButton{
    
    [self addSubview:self.upButton];

    [self addSubview:self.bottomButton];
    
    [self addSubview:self.leftButton];
    
    [self addSubview:self.rightButton];
    
}

-(UIButton*)upButton{
    if (!_upButton) {
        
        self.upButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.upButton.frame = CGRectMake(15+TANK_MODEL_W, SCREEN_W - TANK_MODEL_W * 3 - 15 , TANK_MODEL_W, TANK_MODEL_W);
        [self.upButton setImage:[UIImage imageNamed:@"dir_up"] forState:UIControlStateNormal];
        [self.upButton addTarget:self action:@selector(moveOnce:) forControlEvents:UIControlEventTouchUpInside];
        [self.upButton addTarget:self action:@selector(move:) forControlEvents:UIControlEventTouchDown];
        self.upButton.tag = 101 ;

    }
    return _upButton;
}


-(UIButton*)bottomButton{
    if (!_bottomButton) {
        
        self.bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.bottomButton.frame = CGRectMake(15+ TANK_MODEL_W, SCREEN_W - TANK_MODEL_W  - 15 , TANK_MODEL_W, TANK_MODEL_W);
        [self.bottomButton setImage:[UIImage imageNamed:@"dir_down"] forState:UIControlStateNormal];
        [self.bottomButton addTarget:self action:@selector(moveOnce:) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomButton addTarget:self action:@selector(move:) forControlEvents:UIControlEventTouchDown];
        self.bottomButton.tag = 102 ;
        
    }
    return _bottomButton;
}
-(UIButton*)leftButton{
    if (!_leftButton) {
        
        self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.leftButton.frame = CGRectMake(15,  SCREEN_W - TANK_MODEL_W * 2 - 15 , TANK_MODEL_W, TANK_MODEL_W);
        [self.leftButton setImage:[UIImage imageNamed:@"dir_left"] forState:UIControlStateNormal];
        [self.leftButton addTarget:self action:@selector(moveOnce:) forControlEvents:UIControlEventTouchUpInside];
        [self.leftButton addTarget:self action:@selector(move:) forControlEvents:UIControlEventTouchDown];
        self.leftButton.tag = 103 ;
        
    }
    return _leftButton;
}
-(UIButton*)rightButton{
    if (!_rightButton) {
        
        self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.rightButton.frame = CGRectMake(15+TANK_MODEL_W * 2, SCREEN_W - TANK_MODEL_W * 2 - 15 , TANK_MODEL_W, TANK_MODEL_W);
        [self.rightButton setImage:[UIImage imageNamed:@"dir_right"] forState:UIControlStateNormal];
        [self.rightButton addTarget:self action:@selector(moveOnce:) forControlEvents:UIControlEventTouchUpInside];
        [self.rightButton addTarget:self action:@selector(move:) forControlEvents:UIControlEventTouchDown];
        self.rightButton.tag = 104 ;
        
    }
    return _rightButton;
}
-(void)move:(UIButton*)button{
    
    [delegate tankMove:button];
    
}

-(void)moveOnce:(UIButton*)button{
    
    [delegate tankStop:button];    
    
}
@end
