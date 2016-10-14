//
//  DBSelfTankModel.h
//  NewStyle
//
//  Created by 段博 on 16/10/1.
//  Copyright © 2016年 DuanBo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DBSelfTankModel : UIView

@property (nonatomic,strong)UIImageView * tank ;
@property (nonatomic)BOOL moving ;


+ (DBSelfTankModel *)sharedManager ;

-(void)changeImage:(NSInteger)direction ;

-(instancetype)initWithFrame:(CGRect)frame ;

-(void)setMovingWith:(BOOL)moving;
@end
