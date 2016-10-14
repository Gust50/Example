//
//  UINavigationController+DBNavigationController.h
//  NewStyle
//
//  Created by 段博 on 16/10/1.
//  Copyright © 2016年 DuanBo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (DBNavigationController)






-(void)setLeftButtonWithViewController:(UIViewController*)controller ;

-(void)setNavigationBarTitle:(NSString*)title withTitleColor:(UIColor*)titleColor withBarTinColor:(UIColor*)tinColor FromViewController:(UIViewController*)controller ;
-(void)setNewFrame:(BOOL)ifShow;
-(void)back;
@end
