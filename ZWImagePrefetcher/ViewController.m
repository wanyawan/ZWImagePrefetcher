//
//  ViewController.m
//  ZWImagePrefetcher
//
//  Created by Alex on 16/7/29.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import "ViewController.h"
#import "DemoModel.h"
#import "DemoTableViewCell.h"
#import "ZWImagePrefetcher.h"

@interface ViewController () <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *testTableView;

@property (nonatomic, strong) NSArray <TestDemoModel *> * testDemoModels;

@end

@implementation ViewController

- (NSArray *)testDemoModels{
    if (!_testDemoModels) {
        NSArray *imageUrls = @[
                               @"http://s2.cdn.xiachufang.com/339210607e6911e5b4dab82a72e00100.jpg?imageView2/2/w/620/interlace/1/q/90/format/jpg/.jpg",
                               @"http://s2.cdn.xiachufang.com/d596718c7d9f11e5959b81b04c14fdf9.jpg?imageView2/2/w/620/interlace/1/q/90/format/jpg/.jpg",
                               @"http://s2.cdn.xiachufang.com/268f1e9152fa11e6b6ccf33edbfd6b82.jpg?imageView2/2/w/620/interlace/1/q/90/format/jpg/.jpg",
                               @"http://s2.cdn.xiachufang.com/aaf24bb854c211e6ad28f91602d390db.jpg?imageView2/2/interlace/1/q/85",
                               @"http://s2.cdn.xiachufang.com/258d762854db11e6aba5b82a72e00100.jpg?imageView2/2/interlace/1/q/85",
                               @"http://s2.cdn.xiachufang.com/b375a4737da111e5a4c1e599ed1d530b.jpg?imageView2/2/w/620/interlace/1/q/90/format/jpg/.jpg",
                               @"http://s2.cdn.xiachufang.com/7a22a25454da11e6b9c6abf9a8a6fc56.png?imageView2/2/interlace/1/q/85",
                               @"http://s2.cdn.xiachufang.com/546ad58754d811e69b4d2b1f9da99913.jpg?imageView2/2/interlace/1/q/85",
                               @"http://s1.cdn.xiachufang.com/71fb9f7254da11e6aba5b82a72e00100.png@2o_50sh_1pr_1l_85q_1wh",
                               @"http://s2.cdn.xiachufang.com/dd110c1e54dc11e683fbabf9a8a6fc56.jpg?imageView2/2/interlace/1/q/85",
                               @"http://s1.cdn.xiachufang.com/65ca7b757ee611e589a39b98a9b3e752.jpg@2o_50sh_1pr_1l_620w_90q_1wh.jpg",
                               @"http://s2.cdn.xiachufang.com/dae0e1c24e7311e69d817fe386f6ccf1.jpg?imageView2/2/interlace/1/q/85",
                               @"http://s2.cdn.xiachufang.com/dfa5bfbd4cce11e6b8b9273fd0473b1a.jpg?imageView2/2/w/620/interlace/1/q/90/format/jpg/.jpg",
                               @"http://s2.cdn.xiachufang.com/406170234e6b11e68e4973f3ecbbd47e.png?imageView2/2/interlace/1/q/85",
                               @"http://s1.cdn.xiachufang.com/41754cdc236a11e6b84a51b7427b45f2.jpg@2o_50sh_1pr_1l_620w_90q_1wh.jpg",
                               @"http://s2.cdn.xiachufang.com/5e454399369c11e68da23b3ef7283e1b.jpg?imageView2/2/w/620/interlace/1/q/90/format/jpg/.jpg",
                               @"http://s2.cdn.xiachufang.com/f8fe2f17491c11e6bf32af91140364ea.jpg?imageView2/2/w/620/interlace/1/q/90/format/jpg/.jpg",
                               @"http://s2.cdn.xiachufang.com/7617c9ae4ef511e69f3e91b20c921aee.png?imageView2/2/interlace/1/q/85",
                               @"http://s2.cdn.xiachufang.com/def5d6594d8311e6b3999907d2b38b48.jpg?imageView2/2/interlace/1/q/85",
                               @"http://s2.cdn.xiachufang.com/67b91ccf4f2611e68bd52f238d225196.png?imageView2/2/interlace/1/q/85",
                               @"http://s2.cdn.xiachufang.com/65241de34e7511e6a7f20f0ae28139af.jpg?imageView2/2/interlace/1/q/85"
                               ];
        NSMutableArray *tempArray = [NSMutableArray new];
        for (int i = 0; i < imageUrls.count ; i++ ) {
            TestImageModel *imageModel = [[TestImageModel alloc]init];
            imageModel.imageId = [NSString stringWithFormat:@"imageId%d",i];
            imageModel.imageUrl = [imageUrls objectAtIndex:i];
            TestDemoModel *demoModel = [[TestDemoModel alloc]init];
            demoModel.test = @"test";
            demoModel.image = imageModel;
            [tempArray addObject:demoModel];
        }
        _testDemoModels = [tempArray copy];
    }
    return _testDemoModels;
}
/*
 *模拟网络请求imageUrl在第二层model中
 */


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.testTableView registerNib:[UINib nibWithNibName:NSStringFromClass([DemoTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([DemoTableViewCell class])];
    
    [[ZWImagePrefetcher sharedImagePrefetcher]addBaseModels:self.testDemoModels imageKey:nil prefetchImgWithWifi:NO];
    /*
     *可以在真机删除demo 注释这句代码查看预加载和不预加载的效果
     *添加models会自动递归查找image的url 
     *imageKey 可以指定imageurl在model中的Key
     *prefetchImgWithWifi 由于提前下载图片可能浪费流量可以选择性开启
     */
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[ZWImagePrefetcher sharedImagePrefetcher]cancelPrefetching];
    /*
     *下一个页面也可能预加载图片所以清空当前界面的预下载队列
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.testDemoModels.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 240;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DemoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DemoTableViewCell class])];
    [cell setTestDemoModel:[self.testDemoModels objectAtIndex:indexPath.row]];
    return cell;
}

@end
