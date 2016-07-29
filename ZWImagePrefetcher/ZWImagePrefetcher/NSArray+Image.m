//
//  NSArray+Image.m
//  ZWImagePrefetcher
//
//  Created by Alex on 16/7/29.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import "NSArray+Image.h"
#import "DemoModel.h"

@implementation NSArray (Image)

- (NSMutableArray *)getImageUrlsWithMostImportantKey:(NSString *)mostImportantKey{
    if (!(self.count > 0)) {
        return nil;
    }
    NSMutableArray *imageUrls = [[NSMutableArray alloc]init];
    for (id obj in self) {
        if ([obj isKindOfClass:[DemoBaseModel class]]) {
            DemoBaseModel *baseModel = obj;
            id obj = [self getImageUrlWithBaseModel:baseModel mostImportantKey:mostImportantKey];
            if (obj != nil && [obj isKindOfClass:[NSString class]]) {
                NSString *imageUrl = obj;
                [imageUrls addObject:imageUrl];
            }
        }
    }
    return imageUrls;
}

- (NSString *)getImageUrlWithBaseModel:(DemoBaseModel *)baseModel mostImportantKey:(NSString *)mostImportantKey{
    NSString *imageKey = [self propertyImageKeysWithBaseModel:baseModel mostImportantKey:mostImportantKey];
    if (imageKey == nil) {
        return nil;
    }
    SEL sel = NSSelectorFromString(imageKey);
    if ([baseModel respondsToSelector:sel]) {
        id value = [baseModel performSelector:sel]; //IMP等等改
        if ([value isKindOfClass:[NSString class]]) {
            return value;
        }else if([value isKindOfClass:[DemoBaseModel class]]){
            return [self getImageUrlWithBaseModel:value mostImportantKey:nil];
        }else{
            return nil;
        }
    }else{
        return nil;
    }
}

- (NSString *)propertyImageKeysWithBaseModel:(DemoBaseModel *)baseModel mostImportantKey:(NSString *)mostImportantKey{
    NSString *imageKey = nil;
    NSArray *propertyKeys = [baseModel propertyKeys];
    NSArray *priorityImageKeys = @[@"url",@"imageUrl",@"image",@"img",@"pic",@"thumbnail"];//优先级从高到低 可以根据自己项目进行修改
    for (NSString *propertyKey in propertyKeys) {
        for(NSString *priorityImageKey in priorityImageKeys){
            if (mostImportantKey != nil && [propertyKeys containsObject:mostImportantKey]) {
                imageKey = mostImportantKey;
                break;
            }else if ([propertyKey rangeOfString:priorityImageKey].location != NSNotFound) {
                imageKey = propertyKey;
                break;
            }
        }
    }
    return imageKey;
}

@end