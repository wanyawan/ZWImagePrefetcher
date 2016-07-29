//
//  DemoTableViewCell.m
//  ZWImagePrefetcher
//
//  Created by Alex on 16/7/29.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import "DemoTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface DemoTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *testImageView;

@end

@implementation DemoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTestDemoModel:(TestDemoModel *)testDemoModel{
    _testDemoModel = testDemoModel;
    NSURL *imageUrl = [NSURL URLWithString:_testDemoModel.image.imageUrl];
    [self.testImageView sd_setImageWithURL:imageUrl];
}
@end
