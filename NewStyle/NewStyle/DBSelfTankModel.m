//
//  DBSelfTankModel.m
//  NewStyle
//
//  Created by 段博 on 16/10/1.
//  Copyright © 2016年 DuanBo. All rights reserved.
//

#import "DBSelfTankModel.h"



@implementation DBSelfTankModel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (DBSelfTankModel *)sharedManager
{
    static DBSelfTankModel * TankModel = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        
        TankModel = [[self alloc] init];
        TankModel.frame = CGRectMake(TANK_MODEL_W  * 2 , SCREEN_H - TANK_MODEL_W  , TANK_MODEL_W , TANK_MODEL_W ) ;
    });
    return TankModel;
} 

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self == [super initWithFrame:frame]) {
        _tank = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, TANK_MODEL_W , TANK_MODEL_W )];
        _tank.image = [UIImage imageNamed:@"self_top"];
        self.moving = NO ;
        [self addSubview:_tank];
    }
    return self ;
}

-(void)changeImage:(NSInteger)direction{
    switch (direction) {
        case 1:
            _tank.image = [UIImage imageNamed:@"self_top"];
            break;
        case 2:
            _tank.image = [UIImage imageNamed:@"self_bottom"];
            break;

        case 3:
            _tank.image = [UIImage imageNamed:@"self_left"];
            break;

        case 4:
            _tank.image = [UIImage imageNamed:@"self_right"];
            break;

            
        default:
            break;
    }
    
}

-(void)setMovingWith:(BOOL)moving{
    self.moving = moving ;
}


@end
