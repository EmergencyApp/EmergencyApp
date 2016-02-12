//
//  SKAudioManager.m
//  Emergency
//
//  Created by 孙恺 on 16/2/12.
//  Copyright © 2016年 sunkai. All rights reserved.
//

#import "SKAudioManager.h"
#import <UIKit/UIKit.h>

@interface SKAudioManager ()

@property (nonatomic, strong) NSMutableDictionary *musicPlayers;
@property (nonatomic, strong) NSMutableDictionary *soundIDs;

@end

static SKAudioManager *_instance = nil;

@implementation SKAudioManager

+ (instancetype)shareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (instancetype)init
{
    __block SKAudioManager *temp = self;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ((temp = [super init]) != nil) {
            _musicPlayers = [NSMutableDictionary dictionary];
            _soundIDs = [NSMutableDictionary dictionary];
        }
    });
    self = temp;
    return self;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

//播放音乐
- (AVAudioPlayer *)playingMusic:(NSString *)filename
{
    if (filename == nil || filename.length == 0)  return nil;
    
    AVAudioPlayer *player = self.musicPlayers[filename];      //先查询对象是否缓存了
    
    if (!player) {
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setActive:YES error:nil];
        [session setCategory:AVAudioSessionCategoryPlayback error:nil];
        
        [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
        
        NSString *string = [[NSBundle mainBundle] pathForResource:filename ofType:@"m4a"];
        NSURL *url = [NSURL URLWithString:string];

        if (!url)  return nil;
        
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        
        [player setVolume:1];
        [player setNumberOfLoops:-1];
        
        if (![player prepareToPlay]) return nil;
        
        self.musicPlayers[filename] = player;            //对象是最新创建的，那么对它进行一次缓存
    }

    if (![player isPlaying]) {                 //如果没有正在播放，那么开始播放，如果正在播放，那么不需要改变什么
        [player play];
    }
    return nil;
}

- (void)pauseMusic:(NSString *)filename
{
    if (filename == nil || filename.length == 0)  return;
    
    AVAudioPlayer *player = self.musicPlayers[filename];
    
    if ([player isPlaying]) {
        [player pause];
    }
}
- (void)stopMusic:(NSString *)filename
{
    if (filename == nil || filename.length == 0)  return;
    
    AVAudioPlayer *player = self.musicPlayers[filename];
    
    [player stop];
}

//播放音效
- (void)playSound:(NSString *)filename
{
    if (!filename) return;
    
    //取出对应的音效ID
    SystemSoundID soundID = (int)[self.soundIDs[filename] unsignedLongValue];
    
    if (!soundID) {
        NSURL *url = [[NSBundle mainBundle] URLForResource:filename withExtension:nil];
        if (!url) return;
        
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)(url), &soundID);
        
        self.soundIDs[filename] = @(soundID);
    }
    
    // 播放
    AudioServicesPlaySystemSound(soundID);
}

//摧毁音效
- (void)disposeSound:(NSString *)filename
{
    if (!filename) return;
    
    
    SystemSoundID soundID = (int)[self.soundIDs[filename] unsignedLongValue];
    
    if (soundID) {
        AudioServicesDisposeSystemSoundID(soundID);
        
        [self.soundIDs removeObjectForKey:filename];    //音效被摧毁，那么对应的对象应该从缓存中移除
    }
}

@end
