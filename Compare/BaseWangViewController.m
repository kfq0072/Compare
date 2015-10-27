//
//  BaseWangViewController.m
//  Compare
//
//  Created by huangshuimei on 10/3/15.
//  Copyright (c) 2015 huangshuimei. All rights reserved.
//

#import "BaseWangViewController.h"

@interface BaseWangViewController ()

@end

@implementation BaseWangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSString*)getUrlString:(webViewUrl)type {
    NSString *urlStr;
    switch (type) {
        case 0:
            urlStr = @"https://m.taobao.com/#index";
            break;
        case 1:
            urlStr = @"http://m.jd.com";
            break;
        case 2:
            urlStr = @"http://www.suning.com";
            break;
        case 3:
            urlStr = @"https://mobile.tmall.com/index.shtml";
            break;
        case 4:
            urlStr = @"http://m.yixun.com";
            break;
        default:
            urlStr = @"http://m.vip.com";
            break;
    }
    return urlStr;

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
