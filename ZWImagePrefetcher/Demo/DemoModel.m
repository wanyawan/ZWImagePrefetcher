//
//  DemoModel.m
//  ZWImagePrefetcher
//
//  Created by Alex on 16/7/29.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import "DemoModel.h"
#import <objc/runtime.h>

@implementation DemoBaseModel

- (NSArray *)propertyKeys{
    unsigned int propertyCount = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &propertyCount);
    NSMutableArray *keys = [[NSMutableArray alloc] initWithCapacity:propertyCount];
    for (int i = 0; i < propertyCount ; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc]initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        [keys addObject:propertyName];
    }
    free(properties);
    return keys;
}



@end


@implementation TestImageModel

@end

@implementation TestDemoModel

@end
