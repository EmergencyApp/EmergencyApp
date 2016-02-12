//
//  SKAudioManager.h
//  Emergency
//
//  Created by 孙恺 on 16/2/12.
//  Copyright © 2016年 sunkai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface SKAudioManager : NSObject

+ (instancetype)shareManager;

//播放音乐
- (AVAudioPlayer *)playingMusic:(NSString *)filename;
- (void)pauseMusic:(NSString *)filename;
- (void)stopMusic:(NSString *)filename;

//播放音效
- (void)playSound:(NSString *)filename;
- (void)disposeSound:(NSString *)filename;

@end
