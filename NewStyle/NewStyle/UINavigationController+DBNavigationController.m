//
//  UINavigationController+DBNavigationController.m
//  NewStyle
//
//  Created by 段博 on 16/10/1.
//  Copyright © 2016年 DuanBo. All rights reserved.
//

#import "UINavigationController+DBNavigationController.h"

#import "DBGameViewController.h"

#import "DBMedioViewController.h"

@implementation UINavigationController (DBNavigationController)




-(void)setLeftButtonWithViewController:(UIViewController*)controller{
    
    
    if([self.viewControllers[0]isEqual:controller])
    {
        UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        leftButton.frame = CGRectMake( 10 , 5,self.navigationBar.frame.size.height-10, self.navigationBar.frame.size.height-10);
        [leftButton setImage:[UIImage imageNamed:@"userImage"] forState:UIControlStateNormal];
        [leftButton addTarget:self action:@selector(showleftView) forControlEvents:UIControlEventTouchUpInside];
        controller.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    
    }else{
        
        UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        leftButton.frame = CGRectMake( 0 , 5,self.navigationBar.frame.size.height, self.navigationBar.frame.size.height-10);
        [leftButton setTitle:@"返回" forState:UIControlStateNormal];
        [leftButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [leftButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        controller.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];

        controller.navigationItem.leftBarButtonItem.title = @"返回";
    }

}


-(void)setNavigationBarTitle:(NSString*)title withTitleColor:(UIColor*)titleColor withBarTinColor:(UIColor*)tinColor FromViewController:(UIViewController*)controller{
    
    controller.navigationItem.title = title ;
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:titleColor};
    self.navigationBar.barTintColor = tinColor ;
    
    [self setLeftButtonWithViewController:controller];
    
}


- (BOOL)shouldAutorotate
{
    
    return [self.topViewController shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    
    return [self.topViewController supportedInterfaceOrientations];
    
}
-(void)showleftView
{

    [[NSNotificationCenter defaultCenter]postNotificationName:@"showLeftView" object:nil];

}

-(void)setNewFrame:(BOOL)ifShow{
    

    [UIView animateWithDuration:0.5 animations:^{
        
        CGRect newFrame = self.navigationBar.frame ;
        if (ifShow) {
            newFrame.origin.y += self.navigationBar.frame.size.height + 20 ;

        }
        else{
            newFrame.origin.y -= self.navigationBar.frame.size.height + 20;

        }
            self.navigationBar.frame = newFrame ;
    }completion:^(BOOL finished) {
        
    }];
    
    
}

-(void)back{
    
    
    
    if ([self.topViewController isKindOfClass:[DBMedioViewController class]]) {
        
        DBMedioViewController * controller = (DBMedioViewController*)self.topViewController;
        
        [controller judgeUIDeviceOrientation];
        
        

    }

    [self popViewControllerAnimated:YES];
    
}
@end
