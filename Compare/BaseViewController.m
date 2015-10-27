//
//  BaseViewController.m
//  Compare
//
//  Created by huangshuimei on 10/22/15.
//  Copyright © 2015 huangshuimei. All rights reserved.
//

#import "BaseViewController.h"
#import <iAd/iAd.h>

@interface BaseViewController ()<ADBannerViewDelegate>
@property (nonatomic, strong) ADBannerView *bannerView;
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)initBandView {
    self.bannerView = [[ADBannerView alloc] init];
    self.bannerView.delegate = self;
    self.bannerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view insertSubview:self.bannerView aboveSubview:self.view];
    
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:_bannerView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:_bannerView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:64.0];
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:_bannerView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:_bannerView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:50.0];
    
    [self.view addConstraint:left];
    [self.view addConstraint:top];
    [self.view addConstraint:right];
    [self.view addConstraint:height];
    
}
- (void)bannerViewAnimation {
    
    //动画设定
    [UIView beginAnimations:@"BannerViewAnimation" context:NULL];
    
    //以userInteractionEnabled状态排判断bannerView是否在画面内
    if (_bannerView.userInteractionEnabled) {
        _bannerView.frame = CGRectOffset(_bannerView.frame, 0, 80);
    }else {
        _bannerView.frame = CGRectOffset(_bannerView.frame, 0, -80);
    }
    //开始动画
    [UIView commitAnimations];
    
    //将userInteractionEnabled做反向设定
    _bannerView.userInteractionEnabled = !_bannerView.userInteractionEnabled;
}

#pragma mark - ADBannerViewDelegate
- (void)bannerViewDidLoadAd:(ADBannerView *)banner {
    NSLog(@"load iad success");
}
- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    NSLog(@"load iad error : %@",error);
//        _bannerView.frame = CGRectOffset(_bannerView.frame, 0, 50);
    _bannerView.hidden = YES;
}
- (void)bannerViewActionDidFinish:(ADBannerView *)banner {
    NSLog(@"finish load");
}

@end
