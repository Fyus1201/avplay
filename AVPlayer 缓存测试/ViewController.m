//
//  ViewController.m
//  AVPlayer 缓存测试
//
//  Created by 寿煜宇 on 16/9/1.
//  Copyright © 2016年 Fyus. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>


@interface ViewController ()

@property (nonatomic,strong)AVPlayer *player;//使用时设置为单例
@property (nonatomic, strong) AVPlayerItem * currentItem;

@property (nonatomic, strong) FYResourceLoader * resourceLoader;

@end

@implementation ViewController

- (void)viewDidLoad {
 [super viewDidLoad];
 // Do any additional setup after loading the view, typically from a nib.
 
 //设置播放的url
 NSString *playString = @"http://grandtour.myswitzerland.com/en/video/150330_Intro_original_handbreak_h264_2000kb.mp4";

 NSURL *url = [NSURL URLWithString:playString];
    
    if ([url.absoluteString hasPrefix:@"http"]) {
        //有缓存播放缓存文件
        NSString * cacheFilePath = [FYFileHandle cacheFileExistsWithURL:url];
        if (cacheFilePath) {
            NSURL * url = [NSURL fileURLWithPath:cacheFilePath];
            self.currentItem = [AVPlayerItem playerItemWithURL:url];
            NSLog(@"有缓存，播放缓存文件");
        }else {
            //没有缓存播放网络文件
            self.resourceLoader = [[FYResourceLoader alloc]init];
            self.resourceLoader.delegate = self;

            //NSURL 和 NSURLComponents 的不同之处在于，URL component属性是 readwrite 的。它提供了安全直接的方法来修改URL的各个部分：
            NSURLComponents * components = [[NSURLComponents alloc] initWithURL:url resolvingAgainstBaseURL:NO];
            components.scheme = @"scheming";//通过自定义scheme来创建avplayer  不用http   在资源的 URL 不能被系统识别时可以自定义视频加载
    
            AVURLAsset * asset = [AVURLAsset URLAssetWithURL:[components URL] options:nil];
            [asset.resourceLoader setDelegate:self.resourceLoader queue:dispatch_get_main_queue()];
            self.currentItem = [AVPlayerItem playerItemWithAsset:asset];
            //self.currentItem = [AVPlayerItem playerItemWithURL:url];
            NSLog(@"无缓存，播放网络文件");
        }
    }else {
        self.currentItem = [AVPlayerItem playerItemWithURL:url];
        NSLog(@"播放本地文件");
    }


    //初始化player对象
 self.player = [[AVPlayer alloc] initWithPlayerItem:self.currentItem];
 
     //设置播放页面
 AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:_player];
 //设置播放页面的大小
 layer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 300);
 layer.backgroundColor = [UIColor cyanColor].CGColor;
 //设置播放窗口和当前视图之间的比例显示内容
 layer.videoGravity = AVLayerVideoGravityResizeAspect;
 //添加播放视图到self.view
 [self.view.layer addSublayer:layer];
 
     //设置播放的默认音量值
 self.player.volume = 1.0f;
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 开始按钮响应方法
- (IBAction)startPlayer:(id)sender {
    [self.player play];
}
#pragma mark - 暂停按钮响应方法
- (IBAction)stopPlayer:(id)sender {
    [self.player pause];
}


- (IBAction)or:(id)sender {
    NSString *playString = @"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4";
    NSURL *url = [NSURL URLWithString:playString];
    if ([FYFileHandle cacheFileExistsWithURL:url]) {
        
        NSLog(@"缓存＝＝＝＝＝%@",[NSString stringWithFormat:@"%@/%@", [[NSHomeDirectory( ) stringByAppendingPathComponent:@"Library"] stringByAppendingPathComponent:@"MusicCaches"], [[url.path componentsSeparatedByString:@"/"] lastObject]]);

    }else {
        NSLog(@"无缓存");
    }
}
- (IBAction)bel:(id)sender {
    [FYFileHandle clearCache];
}
- (IBAction)bit:(id)sender {
   
}


#pragma mark - SULoaderDelegate
- (void)loader:(FYResourceLoader *)loader cacheProgress:(CGFloat)progress {
   
    //NSLog(@"缓存＝＝＝ %f",progress);
}

@end
