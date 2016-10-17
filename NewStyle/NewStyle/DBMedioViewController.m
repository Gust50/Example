//
//  DBMedioViewController.m
//  NewStyle
//
//  Created by 段博 on 2016/10/11.
//  Copyright © 2016年 DuanBo. All rights reserved.
//

#import "DBMedioViewController.h"
#import "DBMediaView.h"

#import "DBTabBarController.h"
@interface DBMedioViewController ()<VideoSomeDelegate>


@property (nonatomic,strong)DBMediaView * mediaView ;



@end

@implementation DBMedioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    
    [self setUI];
    
    
    
}
-(void)setUI{
    
    [self setNav];
    [self.mediaView setMedia];
    [self changeView];
    
}


-(void)setNav{
    [self.navigationController setNavigationBarTitle:@"视频" withTitleColor:[UIColor whiteColor] withBarTinColor:[UIColor colorWithRed:0.07 green:0.72 blue:0.96 alpha:1] FromViewController:self];
 
}


//block回调改变旋转时坐标
-(void)changeView{
    
    DBTabBarController * tabbar = (DBTabBarController*)self.tabBarController ;
    __weak typeof(self)weak_self = self ;
    tabbar.changeFrame = ^(BOOL isNew)
    {
        
        if (isNew) {
            [weak_self.mediaView newFrames];
        }
        else
        {
            [weak_self.mediaView oldFrames];
        }
        
    };
}

-(DBMediaView*)mediaView{
    if (!_mediaView) {
        
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGFloat height = [UIScreen mainScreen].bounds.size.height;
        
        
        _mediaView = [[DBMediaView alloc]initWithFrame:CGRectMake(0, 0, width, height) WithUrl:@"http://baobab.wandoujia.com/api/v1/playUrl?vid=9962&editionType=default" delegate:self];
        [self.view addSubview:_mediaView];
        
        [_mediaView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        
    }

    [self.view layoutIfNeeded];
    return _mediaView;
}



// 横屏
- (void)landscapAction:(id)sender {
    [self interfaceOrientation:UIInterfaceOrientationLandscapeRight];

}

// 竖屏
- (void)portraitAction:(id)sender {
    [self interfaceOrientation:UIInterfaceOrientationPortrait];
}
- (void)interfaceOrientation:(UIInterfaceOrientation)orientation
{
    
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector             = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val                  = orientation;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
    
}


- (BOOL)shouldAutorotate
{
    return NO;
}

- (void)judgeUIDeviceOrientation

{
    [self _shouldRotateToOrientation:(UIDeviceOrientation)[UIDevice currentDevice].orientation];
    
}

-(void)_shouldRotateToOrientation:(UIDeviceOrientation)orientation {
  
    if (orientation == UIDeviceOrientationPortrait ) { // 竖屏

//        [_mediaView oldFrames];
        NSLog(@"竖屏 进来了这个方法");
    } else { // 横屏
        
        [self portraitAction:nil];
        [_mediaView oldFrames];

         NSLog(@"横屏 进来了这个方法");
    }
}


- (void)fullScreen:(UIButton*)button{
    
    NSLog(@"全屏点击了");
    if (!_mediaView.isFullScreen) {
        
        [self landscapAction:button];
        [_mediaView newFrames];
    }
    else{
        
        [self portraitAction:button];
        [_mediaView oldFrames];
    }
    _mediaView.isFullScreen = ! _mediaView.isFullScreen ;
//
}

-(void)showNavigation:(BOOL)ifShow{

    [self.navigationController setNewFrame:ifShow];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
//    self.navigationController.navigationBarHidden = YES ;
    self.tabBarController.tabBar.hidden = YES ;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.tabBarController.tabBar.hidden = NO ;
    

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
