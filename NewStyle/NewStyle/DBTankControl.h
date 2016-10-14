//
//  DBTankControl.h
//  NewStyle
//
//  Created by 段博 on 16/10/2.
//  Copyright © 2016年 DuanBo. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol BtnDelegate <NSObject>  //定义一个delegate

- (void)tankMove:(UIButton*)button;//声明一个delegate方法
- (void)tankStop:(UIButton*)button;

@end


@interface DBTankControl : UIView{
    
    id <BtnDelegate> delegate;//声明delegate变量
    
}

@property (nonatomic, strong) id <BtnDelegate> delegate;   //声明delegate属性


@property (nonatomic, strong) UIButton *  upButton;
@property (nonatomic, strong) UIButton *  bottomButton;
@property (nonatomic, strong) UIButton *  leftButton;
@property (nonatomic, strong) UIButton *  rightButton;
@property (nonatomic, strong) UIButton *  fireButton;






-(instancetype)init ;

@end
