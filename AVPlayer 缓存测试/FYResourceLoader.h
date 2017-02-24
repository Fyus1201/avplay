//
//  FYResourceLoader.h
//  AVPlayer 缓存测试
//
//  Created by 寿煜宇 on 16/9/3.
//  Copyright © 2016年 Fyus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "FYRequestTask.h"

#define MimeType @"video/mp4"

@class FYResourceLoader;
@protocol FYLoaderDelegate <NSObject>

@required
- (void)loader:(FYResourceLoader *)loader cacheProgress:(CGFloat)progress;

@optional
- (void)loader:(FYResourceLoader *)loader failLoadingWithError:(NSError *)error;

@end

@interface FYResourceLoader : NSObject<AVAssetResourceLoaderDelegate,FYRequestTaskDelegate>

@property (nonatomic, weak) id<FYLoaderDelegate> delegate;
@property (atomic, assign) BOOL seekRequired; //Seek标识
@property (nonatomic, assign) BOOL cacheFinished;

- (void)stopLoading;

@end
