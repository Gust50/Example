//
//  DBMediaView.m
//  NewStyle
//
//  Created by 段博 on 2016/10/11.
//  Copyright © 2016年 DuanBo. All rights reserved.
//

#import "DBMediaView.h"
#import "DBTimeChange.h"
@interface DBMediaView()


@property (nonatomic ,assign) float videoLength;

@property (nonatomic ,assign)id timeObser ;
@property (nonatomic ,assign) CMTime changedTime ;
@end


@implementation DBMediaView


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(instancetype)initWithFrame:(CGRect)frame WithUrl:(NSString*)url delegate:(id<VideoSomeDelegate>)delegate{
    if (self = [super initWithFrame:frame]) {
        
         _url = url ;
        _someDelegate = delegate ;
        
      
    }
    return self ;
}

-(void)setMedia{
    

    [self.layer addSublayer:self.playerLayer];
    [self addSubview:self.bottomView];
    
    [self addVideoKVO];
    [self addVideoTimerObserver];
   
    self.isFullScreen = NO ;
}


-(void)oldFrames{
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    _playerLayer.frame = CGRectMake(0, height / 5, width, 300) ;
    _startBt.frame = CGRectMake(_playerLayer.frame.size.height/2 -15 , 50, 30, 30);
    _bottomView.frame =CGRectMake(0, height - 100, _playerLayer.frame.size.height, 100);
    _fullScreenBt.frame = CGRectMake(_playerLayer.frame.size.height - 40, 60, 20, 20);
    _slider.frame=CGRectMake(0,  20, _playerLayer.frame.size.height, 10);
    _timeLebel.frame=CGRectMake(10, 60, 70, 20);

}

-(void)newFrames{
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;

    _playerLayer.frame = CGRectMake(0, 0,width, height) ;
    _bottomView.frame =CGRectMake(0, _playerLayer.frame.size.height - 100, _playerLayer.frame.size.width, 100);
    _startBt.frame = CGRectMake( _playerLayer.frame.size.width/2 -15 , 50, 30, 30);
    _fullScreenBt.frame = CGRectMake(_playerLayer.frame.size.width - 40, 60, 20, 20);
    _slider.frame=CGRectMake(0,  20, _playerLayer.frame.size.width, 10);
    _timeLebel.frame=CGRectMake(10, 60, 70, 20);
    
}

#pragma mark - KVO
- (void)addVideoKVO
{
    //KVO
    [_playItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    [_playItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    [_playItem addObserver:self forKeyPath:@"playbackBufferEmpty" options:NSKeyValueObservingOptionNew context:nil];
}
- (void)removeVideoKVO {
    [_playItem removeObserver:self forKeyPath:@"status"];
    [_playItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    [_playItem removeObserver:self forKeyPath:@"playbackBufferEmpty"];
}
- (void)observeValueForKeyPath:(nullable NSString *)keyPath ofObject:(nullable id)object change:(nullable NSDictionary<NSString*, id> *)change context:(nullable void *)context {
    
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerItemStatus status = _playItem.status;
        switch (status) {
            case AVPlayerItemStatusReadyToPlay:
            {
                _videoLength = floor(_playItem.asset.duration.value * 1.0/ _playItem.asset.duration.timescale);

                [_player play];
                [_startBt setImage:[UIImage imageNamed:@"Media_stop"] forState:UIControlStateNormal];
                NSLog(@"AVPlayerItemStatusReadyToPlay  视频长度-%f",_videoLength);

            }
                break;
            case AVPlayerItemStatusUnknown:
            {
                NSLog(@"AVPlayerItemStatusUnknown");
            }
                break;
            case AVPlayerItemStatusFailed:
            {
                NSLog(@"AVPlayerItemStatusFailed");
                NSLog(@"%@",_playItem.error);
            }
                break;
                
            default:
                break;
        }
    } else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        
    } else if ([keyPath isEqualToString:@"playbackBufferEmpty"]) {
        
    }
}

#pragma mark - TimerObserver
- (void)addVideoTimerObserver {
    __weak typeof (self)weak_self = self;
    _timeObser = [_player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:NULL usingBlock:^(CMTime time) {

        
        weak_self.changedTime = time ;
        float currentTimeValue = time.value*1.0/time.timescale/weak_self.videoLength;
        NSString *currentString = [DBTimeChange getStringFromCMTime:time];
        NSString * totalTiemString = [DBTimeChange getVideoLengthFromTimeLength:weak_self.videoLength];

        weak_self.slider.value = currentTimeValue ;
        weak_self.timeLebel.text = [NSString stringWithFormat:@"%@/%@",currentString,totalTiemString];
        NSLog(@"currentTimeValue  %f--- currentString  %lld %d",currentTimeValue ,time.value,time.timescale);
  
    }];
}

- (void)removeVideoTimerObserver {
    NSLog(@"%@",NSStringFromSelector(_cmd));
    [_player removeTimeObserver:_timeObser];
}

#pragma mark 点击事件

-(void)showBottomView:(UITapGestureRecognizer*)tap{
    
    [self.someDelegate showNavigation:_bottomView.hidden];
    
    if (_bottomView.hidden == YES)
    {
        _bottomView.hidden = NO ;
        [UIView animateWithDuration:0.5 animations:^{
            CGRect newFrame = _bottomView.frame ;
            newFrame.origin.y -= 100 ;
            _bottomView.frame = newFrame ;
        }];
    }
    else{
        [UIView animateWithDuration:0.5 animations:^{
            CGRect newFrame = _bottomView.frame ;
            newFrame.origin.y += 100 ;
            _bottomView.frame = newFrame ;
            
            } completion:^(BOOL finished) {
            
            _bottomView.hidden  = YES ;
        }];
    }
    NSLog(@"屏幕点击了");
    
}

-(void)fullScreenBtClick:(UIButton*)button{
    
    if ([self.someDelegate respondsToSelector:@selector(fullScreen:)]) {
        [self.someDelegate fullScreen:button];
    }
}





#pragma mark 滑动条事件

//结束拖动进度条
-(void)sliderDragUp{
    
    NSLog(@"滑动了");

    [_playItem seekToTime:_changedTime completionHandler:^(BOOL finished) {
    
        [_player play];
        
        // 跳转完成后
    }];
}

//拖动进度条
-(void)sliderValueChanged:(UISlider*)slider{

    _changedTime =CMTimeMake(_changedTime.timescale * self.videoLength * self.slider.value,_changedTime.timescale);
    NSString *currentString = [DBTimeChange getStringFromCMTime:_changedTime];
    NSString * totalTiemString = [DBTimeChange getVideoLengthFromTimeLength:self.videoLength];
    _timeLebel.text = [NSString stringWithFormat:@"%@/%@",currentString,totalTiemString];
}


//开始拖动进度条
-(void)sliderTouchDown{
    [_player pause];
     NSLog(@"按下了");
}

#pragma mark 控件初始化
-(AVPlayer*)player{
    if (!_player) {
        _player = [AVPlayer playerWithPlayerItem:self.playItem];
    }
    return _player;
}

-(AVPlayerItem*)playItem{
    if (!_playItem) {
        _playItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:_url]];
    }
    return _playItem ;
}

-(AVPlayerLayer*)playerLayer{
    if (!_playerLayer) {
        _playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        _playerLayer.frame = CGRectMake(0, self.frame.size.height / 5, self.frame.size.width, 300) ;        
        UIView * clearView = [[UIView alloc]initWithFrame:_playerLayer.frame];
        clearView.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBottomView:)];
        [clearView addGestureRecognizer:tap];
        [self addSubview:clearView];
    }
    return _playerLayer ;
}

-(UIView*)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 100, self.frame.size.width, 100)];
        self.bottomView.backgroundColor = [UIColor darkGrayColor];

        [_bottomView addSubview:self.startBt];
        [_bottomView addSubview:self.slider];
        [_bottomView addSubview:self.timeLebel];
        [_bottomView addSubview:self.fullScreenBt];
    }
    return  _bottomView;
}

-(UIButton*)startBt{
    if(!_startBt){
        _startBt = [UIButton buttonWithType:UIButtonTypeCustom];
        _startBt.frame = CGRectMake( self.frame.size.width/2 -15 , 50, 30, 30);
        [_startBt setImage:[UIImage imageNamed:@"Media_start"] forState:UIControlStateNormal];
        [_startBt addTarget:self action:@selector(Play:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startBt ;
}
-(UIButton*)fullScreenBt{
    if (!_fullScreenBt) {
        _fullScreenBt  = [UIButton buttonWithType:UIButtonTypeCustom];
        _fullScreenBt.frame = CGRectMake(self.frame.size.width - 40, 60, 20, 20);
        [_fullScreenBt setImage:[UIImage imageNamed:@"FullScreen"] forState:UIControlStateNormal];
        [_fullScreenBt addTarget:self action:@selector(fullScreenBtClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return  _fullScreenBt;
}
-(UISlider*)slider{
    if (!_slider) {
        _slider = [[UISlider alloc]initWithFrame:CGRectMake(0,  20, self.frame.size.width, 10)];
        [_slider addTarget:self action:@selector(sliderDragUp) forControlEvents:UIControlEventTouchUpInside];
        [_slider addTarget:self action:@selector(sliderTouchDown) forControlEvents:UIControlEventTouchDown];
        [_slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];// 针对值变化添加响应方法
    }
    
    return _slider ;
}
-(UILabel*)timeLebel{
    if (!_timeLebel) {
        _timeLebel = [[UILabel alloc]initWithFrame:CGRectMake(10, 60, 70, 20)];
        _timeLebel.textColor = [UIColor whiteColor];
        _timeLebel.font = [UIFont systemFontOfSize:14];
        
    }
    return _timeLebel ;
}
-(void)Play:(UIButton*)button{
    
    if (button.selected == NO) {
        [_player pause];
        [_startBt setImage:[UIImage imageNamed:@"Media_start"] forState:UIControlStateNormal];
    }
    else if (button.selected == YES){
        [_player play];
        [_startBt setImage:[UIImage imageNamed:@"Media_stop"] forState:UIControlStateNormal];
    }
    button.selected = !button.selected ;
}

#pragma mark - release
- (void)dealloc {
    NSLog(@"%@",NSStringFromSelector(_cmd));
    [self removeVideoTimerObserver];
    [self removeVideoKVO];
}

@end
