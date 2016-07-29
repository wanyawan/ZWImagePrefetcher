//
//  ZWImagePrefetcher.m
//  ZWImagePrefetcher
//
//  Created by Alex on 16/7/29.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import "ZWImagePrefetcher.h"
#import "NSArray+Image.h"
#import "AFNetworkReachabilityManager.h"
#import "SDWebImagePrefetcher.h"

@interface ZWImagePrefetcher ()

@property (nonatomic, strong) NSMutableArray *prefetchUrls;
@property (nonatomic, strong) SDWebImagePrefetcher *imagePrefetcher;
@property (nonatomic, assign) NSInteger finishNum;
@end

@implementation ZWImagePrefetcher

+ (ZWImagePrefetcher *)sharedImagePrefetcher{
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [[self alloc]init];
    });
    return instance;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.prefetchUrls = [[NSMutableArray alloc]init];
        self.imagePrefetcher = [SDWebImagePrefetcher sharedImagePrefetcher];
    }
    return self;
}

- (void)addBaseModels:(NSArray *)baseModels imageKey:(NSString *)imageKey prefetchImgWithWifi:(BOOL)prefetchImgWithWifi{
    if (!(baseModels.count > 0)) {
        return;
    }
    if (prefetchImgWithWifi && [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus != AFNetworkReachabilityStatusReachableViaWiFi) {
        return;
    }
    NSArray *imageUrls = [baseModels getImageUrlsWithMostImportantKey:imageKey];
    [self addImageUrls:imageUrls];
}


- (void)addImageUrls:(NSArray *)imageUrls{
    if (_finishNum > 0 && self.prefetchUrls.count > _finishNum) {
        [self.prefetchUrls removeObjectsInRange:NSMakeRange(0, _finishNum)];
    }
    [self.prefetchUrls addObjectsFromArray:imageUrls];
    [self.imagePrefetcher prefetchURLs:self.prefetchUrls progress:^(NSUInteger noOfFinishedUrls, NSUInteger noOfTotalUrls) {
        _finishNum = noOfFinishedUrls;
    } completed:^(NSUInteger noOfFinishedUrls, NSUInteger noOfSkippedUrls) {
        
    }];
}

- (void)cancelPrefetching{
    [self.prefetchUrls removeAllObjects];
    _finishNum = 0;
    [self.imagePrefetcher cancelPrefetching];
}
@end