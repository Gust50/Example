//
//  DBMessageController.m
//  NewStyle
//
//  Created by 段博 on 16/9/23.
//  Copyright © 2016年 DuanBo. All rights reserved.
//

#import "DBMessageController.h"


#import "Header.h"




@interface DBMessageController ()

@end

@implementation DBMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self timeLabelConfig];

}

-(void)setNav{
    

    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController setNavigationBarTitle:@"消息" withTitleColor:[UIColor whiteColor] withBarTinColor:[UIColor colorWithRed:0.07 green:0.72 blue:0.96 alpha:1] FromViewController:self];
}

#pragma mark ----创建界面

-(void)timeLabelConfig{
    

    self.timeLabel.shadowColor = [UIColor grayColor];
    self.timeLabel.shadowOffset = CGSizeMake(0.5,1.5);

    
    [self.timeLabel setAttrubutwithText:@"2016还剩多久?" withFont:18 withBackColor:[UIColor clearColor] withTextColor:[UIColor colorWithRed:1 green:0.27 blue:0.18 alpha:1] withTextAlignment:1];


    [UIView animateWithDuration:2 animations:^{
        CATransform3D rotate = CATransform3DMakeRotation(M_PI/18, 0, 1 , 0);
        
        self.timeLabel.layer.transform = CATransform3DPerspect(rotate, CGPointMake(0 , 10), 40);

    }];
   
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.timeLabel.layer shake];
        
//        DBSoundPlay * play = [DBSoundPlay standardDBSoundPlay];
        
//        [play play:@"这只是一个测试的Demo,没有什么意思.就像人,活着活着就没了"];
        
    });
    
}



#pragma mark ----3D投影算法

CATransform3D CATransform3DMakePerspective(CGPoint center, float disZ)
{
    CATransform3D transToCenter = CATransform3DMakeTranslation(-center.x, -center.y, 0);
    CATransform3D transBack = CATransform3DMakeTranslation(center.x, center.y, 0);
    CATransform3D scale = CATransform3DIdentity;
    scale.m34 = -1.0f/disZ;
    
    return CATransform3DConcat(CATransform3DConcat(transToCenter, scale), transBack);
}


CATransform3D CATransform3DPerspect(CATransform3D t, CGPoint center, float disZ)
{
    
    
    return CATransform3DConcat(t, CATransform3DMakePerspective(center, disZ));
}


#pragma mark ----控件getting setting

-(UILabel*)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        [self.view addSubview:self.timeLabel];
        
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.view).offset(10);
            make.right.equalTo(self.view).offset(-10);
            make.top.equalTo(self.view.mas_top).offset(70);
            make.height.mas_equalTo(30);
            
        }];
 
    }
    return _timeLabel;
}


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    [self setNav];
//    self.tabBarController.tabBar.hidden = NO ;
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
//    self.tabBarController.tabBar.hidden = YES ;
}

-(void)dealloc{
    NSLog(@"%@ free",self);
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
