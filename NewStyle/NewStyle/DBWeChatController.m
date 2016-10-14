//
//  DBWeChatController.m
//  NewStyle
//
//  Created by 段博 on 16/9/23.
//  Copyright © 2016年 DuanBo. All rights reserved.
//

#import "DBWeChatController.h"
#import "DBMedioViewController.h"

#import "Header.h"
@interface DBWeChatController ()

@end

@implementation DBWeChatController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self setUI];
    
}

-(void)setUI{
    
    
    [self setTankStart];
}

-(void)setNav{
    
    self.view.backgroundColor = [UIColor whiteColor];

    [self.navigationController setNavigationBarTitle:@"微信" withTitleColor:[UIColor whiteColor] withBarTinColor:[UIColor colorWithRed:0.07 green:0.72 blue:0.96 alpha:1] FromViewController:self];
    
}

#pragma mark ----设置控件属性
-(void)setTankStart{
    
    
    [self.tankStart setAttrubutwithTitle:@"视频" TitleColor:[UIColor whiteColor] BackColor:[UIColor colorWithRed:0.07 green:0.72 blue:0.96 alpha:1] Font:16 CornerRadius:5 BorderWidth:0 BorderColor:0];
  
    
}

#pragma mark ----控件getting setting
-(UIButton*)tankStart{
    if (!_tankStart) {
        
        _tankStart = [[UIButton alloc]init];
        [_tankStart addTarget:self action:@selector(PushToGameControl) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_tankStart];
        
        [_tankStart mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.view);
            make.size.mas_equalTo(CGSizeMake(SCREEN_W - 40, 30));

        }];
    }
    
    return _tankStart;
    
    
    
}

#pragma mark ----点击事件

-(void)PushToGameControl{
    
    DBMedioViewController * medio = [[DBMedioViewController alloc]init];
    
    [self.navigationController pushViewController:medio animated:YES];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    [self setNav];
//     self.tabBarController.tabBar.hidden = NO ;
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
//    self.tabBarController.tabBar.hidden = YES ;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)dealloc{
    NSLog(@"%@ free",self);
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
