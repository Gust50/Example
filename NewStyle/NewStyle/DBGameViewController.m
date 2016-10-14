//
//  DBGameViewController.m
//  NewStyle
//
//  Created by 段博 on 16/9/30.
//  Copyright © 2016年 DuanBo. All rights reserved.
//

#import "DBGameViewController.h"



#import "GameHeader.h"


@interface DBGameViewController ()<BtnDelegate>


@end

@implementation DBGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUI];
    
}

-(void)setUI{

   
    [self setTankControlView];
    
    [self setNav];
    
    [self setMap];
    
    [self.view addSubview:self.selfTank];
    
}


-(void)setNav{
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton * backBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBt setAttrubutwithTitle:@"返回" TitleColor:[UIColor blackColor] BackColor:nil Font:14 CornerRadius:0 BorderWidth:0 BorderColor:nil];
    [backBt addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
 
    [self.view addSubview:backBt];
    
    [backBt mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(self.view).offset(10);
        make.size.mas_equalTo(CGSizeMake(60, 30));
    }];
    
}

//初始化按键
-(void)setTankControlView{
    DBTankControl * controlView = [[DBTankControl alloc]init];
    controlView.delegate = self ;
    [self.view addSubview:controlView];
}

//初始化tank
-(DBSelfTankModel*)selfTank{
    if (!_selfTank) {
        _selfTank = [[DBSelfTankModel alloc]initWithFrame:CGRectMake(TANK_MODEL_W  * 5 , SCREEN_W - TANK_MODEL_W  , TANK_MODEL_W , TANK_MODEL_W )];
    }
    return _selfTank;
}

//初始化地图
-(void)setMap{
 
    DBMap1 * map = [[DBMap1 alloc]init];
    _mapDataArray = map.mapArray ;
    
    
    [self.view addSubview:map];
    
}
//返回按钮
-(void)back{

    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}



#pragma mark ----设置一些基础属性

//可旋转
- (BOOL)shouldAutorotate
{
    return YES;
}


- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscapeLeft;
}

//判断tank边界
-(void)judgeEdge{
    
    CGRect TankFrame = _selfTank.frame ;
    
    //判断边界
    CGRect newFrame = [DBCalculate judgeEdgewWithFrame:TankFrame withDireection:_direction];

    //判断碰撞障碍物
    BOOL isCollided = [DBCalculate judgeCollidedWithBrick:self.mapDataArray TankFrame:TankFrame moveDirection:_direction];
    
    
    
    
    if (!CGRectEqualToRect(TankFrame, newFrame))
    {
        [self.selfTank setMoving:YES] ;
        [self tankMoveWithFrame:newFrame];
        
    }
    
}

//tank Move Animation
-(void)tankMoveWithFrame:(CGRect)newFrame{
    
    [self.selfTank changeImage:_direction];
    
    [UIView animateWithDuration:0.4 animations:^{
        _selfTank.frame = newFrame ;
    } completion:^(BOOL finished) {
        [self.selfTank setMoving:NO]  ;
        }];
}



#pragma mark ----tankDelegate
- (void)tankMove:(UIButton*)button{
    
    NSLog(@"移动");

    _direction = button.tag - 100 ;
    
    if (!_timer) {
        
         if (!self.selfTank.moving) {
             
             NSLog(@"%d",self.selfTank.moving);
            _timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(judgeEdge) userInfo:nil repeats:YES];
            [_timer fire] ;
       
         }
    }
    
}
- (void)tankStop:(UIButton*)button{
    NSLog(@"停止");

    [_timer invalidate];
    _timer = nil ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
