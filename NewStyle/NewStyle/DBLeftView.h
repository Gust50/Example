//
//  DBLeftView.h
//  NewStyle
//
//  Created by 段博 on 16/9/26.
//  Copyright © 2016年 DuanBo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DBLeftView : UIView

@property(nonatomic,assign)CGRect newFrame ;
@property(nonatomic,strong)UIImageView  * userImage ;
@property(nonatomic,strong)UILabel      * userName ;
@property(nonatomic,strong)UILabel      * userDiscripe ;
@property(nonatomic,strong)UIScrollView * baseScrollView ;
@property(nonatomic,strong)UIButton     * userInfoBt ;

@property(nonatomic,strong)UIImageView  * leftTopImage ;
@property(nonatomic,strong)UIImageView  * leftBackImage ;


@property(nonatomic,strong)NSTimer * timer ;

-(instancetype)initWithFrame:(CGRect)frame ;

-(void)startMoveBubble;
-(void)stopMoveBubble;




@end
