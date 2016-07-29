//
//  ZWImagePrefetcher.h
//  ZWImagePrefetcher
//
//  Created by Alex on 16/7/29.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZWImagePrefetcher : NSObject

+ (ZWImagePrefetcher *)sharedImagePrefetcher;

- (void)addBaseModels:(NSArray *)baseModels imageKey:(NSString *)imageKey prefetchImgWithWifi:(BOOL)prefetchImgWithWifi;

- (void)cancelPrefetching;

@end
