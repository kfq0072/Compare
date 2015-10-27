//
//  BaseTuanViewController.m
//  Compare
//
//  Created by huangshuimei on 10/3/15.
//  Copyright (c) 2015 huangshuimei. All rights reserved.
//

#import "BaseWebViewController.h"
#import "CompareViewController.h"
#import "GMDCircleLoader.h"


@interface BaseWebViewController ()<UIWebViewDelegate>{
    AppDelegate *_appDeleage;
}
@property (nonatomic, strong)UIWebView *tWebView;


@end

@implementation BaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _appDeleage = (AppDelegate*)appDelegate;
    NSString *urlStr = [self getUrlString:_urlType];
    self.view.backgroundColor = [UIColor colorWithRed:246.0/255.0 green:246.0/255.0 blue:246.0/255.0 alpha:1];
    [self LoadWebView:urlStr];
    [self compareButton];
    [self homeButton];
    [self captureButton];
}

- (void)viewDidAppear:(BOOL)animated {
    [GMDCircleLoader setOnView:self.view withTitle:@"Loading..." animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)homeButton {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 49, 49)];
    btn.center = CGPointMake(ScreenSize.width/2, ScreenSize.height-24);
    [btn setBackgroundImage:[UIImage imageNamed:@"home.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(gotoHome) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.cornerRadius = 24.0;
    [self.view addSubview:btn];
}

- (void)captureButton {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 49, 49)];
    btn.center = CGPointMake(ScreenSize.width-24-2, ScreenSize.height-24);
    [btn setBackgroundImage:[UIImage imageNamed:@"save.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(captureClick) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:btn];
}

- (void)compareButton {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 49, 49)];
    btn.center = CGPointMake(24+2, ScreenSize.height-24);
    [btn setBackgroundImage:[UIImage imageNamed:@"compare.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(compareClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
- (void)compareClick {
    //TODO: 跳到scrollview and pageControl
    CompareViewController *cVc = [[CompareViewController alloc] init];
    if (_isTuanFlag) {
        cVc.isCompareTuan = YES;
        if ([_appDeleage.tuanImageArrays count]) {
             cVc.imageArray = _appDeleage.tuanImageArrays;
            [self presentViewController:cVc animated:YES completion:nil];
        }else {
            [self showNoImageAlert];
        }
    }else{
        cVc.isCompareTuan = NO;
        if ([_appDeleage.wangImageArrays count]) {
            cVc.imageArray = _appDeleage.wangImageArrays;
            [self presentViewController:cVc animated:YES completion:nil];
        }else {
            [self showNoImageAlert];
        }
    }
}

- (void)showNoImageAlert {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"wraming" message:@"you have not capture to compare" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)captureClick {
   UIImage *cImage = [self imageFromView:_tWebView atFrame:_tWebView.frame];
    if (_isTuanFlag) {
         [_appDeleage.tuanImageArrays addObject:cImage];
    }else {
         [_appDeleage.wangImageArrays addObject:cImage];
    }
}

//获得某个范围内的屏幕图像
- (UIImage *)imageFromView: (UIView *)theView atFrame: (CGRect)r
{
    UIGraphicsBeginImageContext(theView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    UIRectClip(r);
    [theView.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  theImage;//[self getImageAreaFromImage:theImage atFrame:r];
}


- (void)LoadWebView:(NSString*)urlStr {
    self.tWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 20, ScreenSize.width, ScreenSize.height-20-49)];
    _tWebView.delegate = self;
    [self.view addSubview:_tWebView];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlStr]];
    [_tWebView loadRequest:request];
}
- (void)gotoHome {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSString*)getUrlString:(webViewUrl)type {
    NSString *urlStr;
    switch (type) {
        case meiTu:
            urlStr = @"http://i.meituan.com";
            break;
            case dianPing:
            urlStr = @"http://m.dianping.com";
            break;
        case laShou:
            urlStr = @"http://m.lashou.com";
            break;
        case woWo:
            urlStr = @"http://nanchang.55tuan.com";
            break;
        case nuoMi:
            urlStr = @"http://m.nuomi.com";
            break;
        case soso:
            urlStr = @"http://m.tuan800.com";
            break;
        default:
            break;
    }
    return urlStr;
}

#pragma mark - UIWebViewDelegate
-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [GMDCircleLoader hideFromView:self.view animated:YES];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    if (nil != error) {
        [GMDCircleLoader hideFromView:self.view animated:YES];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"wraming" message:@"please check your network" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
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
