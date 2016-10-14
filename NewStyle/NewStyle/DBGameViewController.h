//
//  DBGameViewController.h
//  NewStyle
//
//  Created by 段博 on 16/9/30.
//  Copyright © 2016年 DuanBo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Header.h"
#import "ModelData.h"


@interface DBGameViewController : UIViewController

@property (nonatomic,strong)DBSelfTankModel * selfTank ;
@property (nonatomic,strong)NSTimer * timer ;
//移动方向
@property (nonatomic,assign)NSInteger  direction;
//地图控件数
@property (nonatomic,strong) NSArray * mapDataArray; 
@end
