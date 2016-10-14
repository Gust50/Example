//
//  DBMediaView.h
//  NewStyle
//
//  Created by 段博 on 2016/10/11.
//  Copyright © 2016年 DuanBo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AVFoundation/AVFoundation.h>


@protocol VideoSomeDelegate <NSObject>



- (void)fullScreen:(UIButton*)button ;

-(void)showNavigation:(BOOL)ifShow;

@end


@interface DBMediaView : UIView


@property (nonatomic,strong)AVPlayer * player ;
@property (nonatomic,strong)AVPlayerLayer *playerLayer;

@property (nonatomic,strong)AVPlayerItem * playItem ;
@property (nonatomic,strong)NSString * url ;

@property (nonatomic,strong)UIButton * startBt ;

@property (nonatomic,strong)UIButton * fullScreenBt ;

@property (nonatomic,strong)UILabel * timeLebel ;
@property (nonatomic,strong)UIView * topView ;
@property (nonatomic,strong)UIView * bottomView ;
@property (nonatomic,strong)UISlider * slider ;


@property (nonatomic)BOOL isFullScreen ;

@property (nonatomic ,weak) id <VideoSomeDelegate> someDelegate;



-(instancetype)initWithFrame:(CGRect)frame WithUrl:(NSString*)url delegate:(id<VideoSomeDelegate>)delegate;
-(void)setMedia;

-(void)oldFrames;
-(void)newFrames;

@end
