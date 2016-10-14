//
//  DBSoundPlay.h
//  NewStyle
//
//  Created by 段博 on 16/9/29.
//  Copyright © 2016年 DuanBo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>


@interface DBSoundPlay : NSObject

@property(nonatomic,assign)float rate;   //语速

@property(nonatomic,assign)float volume; //音量

@property(nonatomic,assign)float pitchMultiplier;  //音调

@property(nonatomic,assign)BOOL  autoPlay;  //自动播放

+(DBSoundPlay*)standardDBSoundPlay;

-(void)play:(NSString *)string ;


@end
