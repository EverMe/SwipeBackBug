//
//  TestAVPlayerViewController.m
//  TestAVPlayer
//
//  Created by 鲍业伟 on 16/11/3.
//  Copyright © 2016年 鲍业伟. All rights reserved.
//

#import "TestAVPlayerViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <UIImageView+WebCache.h>

@interface TestAVPlayerViewController ()

@property (strong, nonatomic) AVPlayer *player; 
@property (strong, nonatomic) AVPlayerItem *playerItem;
@property (strong, nonatomic) AVPlayerLayer * playerLayer;

@end

@implementation TestAVPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
    
}

- (void)initUI{
    
    //prove : in UITrackingRunLoopMode , AVPlayer work well
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.contentSize = CGSizeMake(self.width, self.height * 3);
    scrollView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:scrollView];
    
    
    //AVPlayer
    NSString *playURL = @"http://v.jxvdy.com/sendfile/w5bgP3A8JgiQQo5l0hvoNGE2H16WbN09X-ONHPq3P3C1BISgf7C-qVs6_c8oaw3zKScO78I--b0BGFBRxlpw13sf2e54QA";
    AVAsset *asset = [AVURLAsset URLAssetWithURL:[NSURL URLWithString:playURL] options:nil];
    _playerItem = [AVPlayerItem playerItemWithAsset:asset];
    _player = [[AVPlayer alloc]initWithPlayerItem:self.playerItem];
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    
    _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    _playerLayer.frame = CGRectMake(0, 150, 300, 300);
    _playerLayer.backgroundColor = [UIColor blackColor].CGColor;
    [scrollView.layer insertSublayer:_playerLayer atIndex:1];
    
    //delay 5s status==AVPlayerStatusReadyToPlay
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_player play];
    });
    
    
    //GIF
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 500, 200, 200)];
    imgView.backgroundColor = [UIColor purpleColor];
    [imgView sd_setImageWithURL:[NSURL URLWithString:@"https://d13yacurqjgara.cloudfront.net/users/288987/screenshots/1913272/depressed-slurp-cycle.gif"]];
    [scrollView addSubview:imgView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)width{
    return self.view.bounds.size.width;
}

- (CGFloat)height{
    return self.view.bounds.size.height;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
