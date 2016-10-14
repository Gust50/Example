//
//  DBTabBarController.m
//  NewStyle
//
//  Created by 段博 on 16/9/23.
//  Copyright © 2016年 DuanBo. All rights reserved.
//



#import "DBTabBarController.h"

#import "DBMessageController.h"

#import "DBTencentController.h"

#import "DBWeChatController.h"




@interface DBTabBarController ()

@property(nonatomic,strong)UISwipeGestureRecognizer * swip;
@property(nonatomic,assign)CGPoint beganPoint;

@end

@implementation DBTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange) name:UIDeviceOrientationDidChangeNotification object:nil];

    
    
    
}

-(instancetype)init
{
    if (self == [super init])
    {
        
        DBMessageController * message = [[DBMessageController alloc]init];
        UINavigationController * messageNav =[[UINavigationController alloc]initWithRootViewController:message];

        DBTencentController  * tencent = [[DBTencentController alloc]init];
        UINavigationController * tencentNav = [[UINavigationController alloc]initWithRootViewController:tencent];
        
        DBWeChatController * wechat = [[DBWeChatController alloc]init];
        UINavigationController * wechatNav = [[UINavigationController alloc]initWithRootViewController:wechat];
        
        [self setBarItemAttributesWithTitle:@"消息" withPosition:UIOffsetMake(0, -10) withFont:16 withBarItem:messageNav.tabBarItem];
        [self setBarItemAttributesWithTitle:@"QQ" withPosition:UIOffsetMake(0, -10) withFont:16  withBarItem:tencentNav.tabBarItem];
        [self setBarItemAttributesWithTitle:@"游戏" withPosition:UIOffsetMake(0, -10) withFont:16 withBarItem:wechatNav.tabBarItem];

        self.viewControllers = @[messageNav,tencentNav,wechatNav];
    
        NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
        
        [center addObserver:self selector:@selector(showLeftView:) name:@"showLeftView" object:nil];

        self.tabBar.tintColor = [UIColor colorWithRed:0.07 green:0.72 blue:0.96 alpha:1];
        [self.view insertSubview:self.leftView atIndex:0];
       
    }
    
    return self ;
}


#pragma mark 设置tabBar属性
-(void)setBarItemAttributesWithTitle:(NSString*)title withPosition:(UIOffset)offset withFont:(NSInteger)fontSize  withBarItem:(UITabBarItem*)BarItem
{
    
    BarItem.title = title ;
    [BarItem setTitlePositionAdjustment:offset];

    [BarItem setTitleTextAttributes:@{
                                          NSFontAttributeName:[UIFont systemFontOfSize:fontSize],
                                          }
                               forState:UIControlStateNormal];


}

#pragma mark 显示左侧界面leftView


//点击导航栏显示左侧界面

-(void)showLeftView:(NSNotification*)noti
{

    if (self.view.frame.origin.x == 0)    {
        
        [self showView];
        
        [self.leftView startMoveBubble];

    }
    else {

        [self hiddenView];
    }
    
}

#pragma mark 添加移除手势
-(void)addUISwipeGestureRecognizer
{
    _swip  = [[UISwipeGestureRecognizer alloc ]initWithTarget:self action:@selector(hidLeftView:)];
    
    [self.view addGestureRecognizer:_swip];
}

-(void)removeSwipeGestureRecognizer
{
    
    [self.view removeGestureRecognizer:_swip];
    
    _swip = nil ;
}


#pragma mark 显示 影藏左侧页面
-(void)showView{

    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect newFrame = self.view.frame ;
        newFrame.origin.x = self.view.frame.size.width * 3 /4;
        self.view.frame = newFrame ;
        
        CGRect leftViewFrame = self.leftView.frame ;
        leftViewFrame.origin.x = -SCREEN_W *3 /4 ;
        self.leftView.frame = leftViewFrame;
        
    } completion:^(BOOL finished) {
        [self addUISwipeGestureRecognizer];
    }];

}

-(void)hiddenView{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect newFrame = self.view.frame ;
        newFrame.origin.x = 0;
        self.view.frame = newFrame ;
        
        CGRect leftViewFrame = self.leftView.frame ;
        leftViewFrame.origin.x = -SCREEN_W / 2 ;
        self.leftView.frame = leftViewFrame;
        
    } completion:^(BOOL finished) {

        [self.leftView stopMoveBubble];
        
        [self removeSwipeGestureRecognizer];
  
    }];
}



#pragma mark 捕捉手势 计算滑动距离

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (_swip) {
        
        UITouch* touch=[[event allTouches] anyObject];
        _beganPoint  =[touch locationInView:self.view.superview];
        
        NSLog(@"%f,%f",_beganPoint.x,_beganPoint.y);
 
    }
    
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
   
    if (_swip) {

        UITouch* touch=[[event allTouches] anyObject];
        CGPoint  move =[touch locationInView:self.view.superview];
        CGRect newTabFrame = self.view.frame ;
        newTabFrame.origin.x += (move.x - _beganPoint.x) ;

        if (newTabFrame.origin.x >= 0 && newTabFrame.origin.x <= SCREEN_W * 0.75) {
            
            _beganPoint = move ;
            
            NSLog(@"%f,%f  新x %f",move.x,move.y   ,newTabFrame.origin.x);
            
            self.view.frame = newTabFrame ;
        }
    }
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if (_swip) {

        NSLog(@"%f, tab %f ",0.35 * SCREEN_W,self.view.frame.origin.x);

        if (self.view.frame.origin.x < 0.35 * SCREEN_W)
        {
            [self hiddenView];
        }
        else {
            [self showView];
        }
        
    }
}

-(void)hidLeftView:(UISwipeGestureRecognizer*)swip
{

}

-(UIView*)leftView
{
    if (!_leftView) {
        _leftView = [[DBLeftView alloc]initWithFrame:CGRectMake(-SCREEN_W/2, 0, SCREEN_W *3/4, SCREEN_H)];
    }
    return  _leftView;
}

#pragma mark ----设置一些基础属性



- (BOOL)shouldAutorotate
{
    return [self.selectedViewController shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [self.selectedViewController supportedInterfaceOrientations];
}

- (void)deviceOrientationDidChange
{
    
    NSLog(@"NAV deviceOrientationDidChange:%ld",[UIDevice currentDevice].orientation);
    
    if (![self shouldAutorotate]) {
        
        if([UIDevice currentDevice].orientation == UIDeviceOrientationPortrait) {
            [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait];
            [self orientationChange:NO];
            //注意： UIDeviceOrientationLandscapeLeft 与 UIInterfaceOrientationLandscapeRight
        } else if ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft) {
            [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight];
            [self orientationChange:YES];
        }

    }

}

- (void)orientationChange:(BOOL)landscapeRight
{
    self.changeFrame(landscapeRight);
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    if (landscapeRight) {
        [UIView animateWithDuration:0.2f animations:^{
            self.view.transform = CGAffineTransformMakeRotation(M_PI_2);
            self.view.bounds = CGRectMake(0, 0, width, height);
            
        }];
    } else {
        
        [UIView animateWithDuration:0.2f animations:^{
            self.view.transform = CGAffineTransformMakeRotation(0);
            self.view.bounds = CGRectMake(0, 0, width, height);
   
        }];
    }
 
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
