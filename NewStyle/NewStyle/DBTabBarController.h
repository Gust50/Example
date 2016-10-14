//
//  DBTabBarController.h
//  NewStyle
//
//  Created by 段博 on 16/9/23.
//  Copyright © 2016年 DuanBo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DBLeftView.h"

typedef void (^changeFrame)(BOOL isNew);

@interface DBTabBarController : UITabBarController

@property (nonatomic,strong)DBLeftView* leftView ;

@property (nonatomic,strong)changeFrame changeFrame ;

-(instancetype)init;

@end
