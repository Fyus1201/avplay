//
//  FYRequestTask.h
//  AVPlayer 缓存测试
//
//  Created by 寿煜宇 on 16/9/2.
//  Copyright © 2016年 Fyus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FYFileHandle.h"
//自定义网络请求
#define RequestTimeout 10.0

@class FYRequestTask;
@protocol FYRequestTaskDelegate <NSObject>

@required
- (void)requestTaskDidUpdateCache; //更新缓冲进度代理方法

@optional
- (void)requestTaskDidReceiveResponse;
- (void)requestTaskDidFinishLoadingWithCache:(BOOL)cache;
- (void)requestTaskDidFailWithError:(NSError *)error;

@end

@interface FYRequestTask : NSObject

@property (nonatomic, weak) id<FYRequestTaskDelegate> delegate;
@property (nonatomic, strong) NSURL * requestURL; //请求网址
@property (nonatomic, assign) NSUInteger requestOffset; //请求起始位置
@property (nonatomic, assign) NSUInteger fileLength; //文件长度
@property (nonatomic, assign) NSUInteger cacheLength; //缓冲长度
@property (nonatomic, assign) BOOL cache; //是否缓存文件
@property (nonatomic, assign) BOOL cancel; //是否取消请求

/**
 *  开始请求
 */
- (void)start;

@end
