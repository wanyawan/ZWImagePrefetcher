//
//  DemoModel.h
//  ZWImagePrefetcher
//
//  Created by Alex on 16/7/29.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DemoBaseModel : NSObject

- (NSArray *)propertyKeys;

@end

@interface TestImageModel : DemoBaseModel

@property (nonatomic, copy) NSString *imageId;
@property (nonatomic, copy) NSString *imageUrl;

@end


@interface TestDemoModel : DemoBaseModel

@property (nonatomic ,copy) NSString *test;
@property (nonatomic, strong) TestImageModel *image;

@end