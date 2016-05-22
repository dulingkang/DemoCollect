//
//  PlayerViewController.m
//  DemoCollectOC
//
//  Created by dulingkang on 16/5/22.
//  Copyright © 2016年 Shawn.Du. All rights reserved.
//

#import "PlayerViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface PlayerViewController()
@property (nonatomic, strong) UISlider *volumeSlider;
@property (nonatomic, strong) MPVolumeView *volumeView;

@end

@implementation PlayerViewController {
    CGFloat _oldVolume;
    AVAudioPlayer *_audioPlayer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _oldVolume = [[AVAudioSession sharedInstance] outputVolume];
    [self setVolume:0.8];
    [self initAudioPlayer];
}

- (void)dealloc {
    _audioPlayer = nil;
    [self.volumeView removeFromSuperview];
    [self.volumeSlider removeFromSuperview];
    self.volumeView = nil;
    self.volumeSlider = nil;
    [self setVolume:_oldVolume];
}

- (void)initAudioPlayer
{
    NSString *mp3String=[[NSBundle mainBundle]pathForResource:@"beauty_ok" ofType:@"mp3"];
    NSURL *url=[NSURL fileURLWithPath:mp3String];
    NSData *data=[[NSData alloc]initWithContentsOfURL:url];
    _audioPlayer=[[AVAudioPlayer alloc]initWithData:data error:nil];
    [_audioPlayer prepareToPlay];
    [_audioPlayer play];
}

- (UISlider *)volumeSlider {
    if (!_volumeSlider) {
        //find the volumeSlider
        for (UIView *slider in [self.volumeView subviews]){
            if ([slider.class.description isEqualToString:@"MPVolumeSlider"]){
                _volumeSlider = (UISlider*)slider;
                _volumeSlider.continuous = NO;
                break;
            }
        }
    }
    return _volumeSlider;
}

- (MPVolumeView *)volumeView {
    // Prevent Audio-Change Popus
    if (!_volumeView) {
        _volumeView = [[MPVolumeView alloc] initWithFrame:CGRectZero];
        NSArray *windows = [UIApplication sharedApplication].windows;
        
        _volumeView.alpha = 0.1f;
        _volumeView.userInteractionEnabled = NO;
        [windows[0] addSubview:_volumeView];
    }
    return _volumeView;
}

- (void)setVolume:(CGFloat)value {
    [self.volumeSlider setValue:value animated:YES];
    [self.volumeSlider sendActionsForControlEvents:UIControlEventTouchUpInside];
    _volumeView.alpha = 0.1f;
    NSLog(@"volume set to: %f", value);
}

@end
