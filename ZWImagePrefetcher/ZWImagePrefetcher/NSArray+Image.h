//
//  NSArray+Image.h
//  ZWImagePrefetcher
//
//  Created by Alex on 16/7/29.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Image)

- (NSMutableArray *)getImageUrlsWithMostImportantKey:(NSString *)mostImportantKey;

@end
