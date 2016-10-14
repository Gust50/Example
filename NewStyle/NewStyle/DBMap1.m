//
//  DBMap1.m
//  NewStyle
//
//  Created by 段博 on 16/10/1.
//  Copyright © 2016年 DuanBo. All rights reserved.
//

#import "DBMap1.h"
#import "ModelData.h"



#define move_w tankFrame.size.width/2 ;


#define top_edge (SCREEN_W - 26 * 12)


@implementation DBMap1

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)init{
    if (self == [super init]) {
        
        [self setMapArray];
        
    }
    
    return self ;
}

-(void)setMapArray{
    
    if (!_mapArray) {
        _mapArray = [NSMutableArray array];
    }
    
    for (int i = 0 ; i < 12; i ++){
        for (int j  = 0 ; j < 12; j ++){
            
            if (i > 0 && i < 10) {
                
                if (i == 2){
                    
                    
                    if (j != 0 && j != 11) {
                        
                        
                        [_mapArray insertObject:@"0" atIndex:(i * 12 + j)];
                        
                    }
                    else{
                        
                        UIImageView * map =[[UIImageView alloc]initWithFrame:CGRectMake(LEFT_EDGE + j * TANK_MODEL_W, top_edge + i * TANK_MODEL_W, TANK_MODEL_W, TANK_MODEL_W)];
                        [self addSubview:map];
                        map.image = [UIImage imageNamed:@"brick-1"];
                        
                        
                        [_mapArray insertObject:@"1" atIndex:(i * 12 + j)];
                        
                    }

                }
                else{
                    
                    UIImageView * map =[[UIImageView alloc]initWithFrame:CGRectMake(LEFT_EDGE + j * TANK_MODEL_W, top_edge + i * TANK_MODEL_W, TANK_MODEL_W, TANK_MODEL_W)];
                    [self addSubview:map];
                    map.image = [UIImage imageNamed:@"brick-1"];
                    
                    [_mapArray insertObject:@"1" atIndex:(i * 12 + j)];


                }
                
            }
            else{
                
                
                [_mapArray insertObject:@"0" atIndex:(i * 12 + j)];
                
                
            }
            
        }
    }
}

@end
