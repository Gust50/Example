//
//  DBTencentController.m
//  NewStyle
//
//  Created by 段博 on 16/9/23.
//  Copyright © 2016年 DuanBo. All rights reserved.
//

#import "DBTencentController.h"

@interface DBTencentController ()

@end

@implementation DBTencentController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];
}

-(void)setNav{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController setNavigationBarTitle:@"QQ" withTitleColor:[UIColor whiteColor] withBarTinColor:[UIColor colorWithRed:0.07 green:0.72 blue:0.96 alpha:1] FromViewController:self];
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)shouldAutorotate
{
    return YES;
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
