//
//  CompareViewController.m
//  Compare
//
//  Created by huangshuimei on 10/4/15.
//  Copyright (c) 2015 huangshuimei. All rights reserved.
//

#import "CompareViewController.h"
#import "Utility.h"
#import "AppDelegate.h"

@interface CompareViewController ()<UIScrollViewDelegate,UIAlertViewDelegate>
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIAlertView *alertView;
@end

@implementation CompareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:246.0/255.0 green:246.0/255.0 blue:246.0/255.0 alpha:1];
    [self initUI];
    [self homeButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dispLayAlertView {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"wraming" message:@"Do you want to clear your save?" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"NO", nil];
    alert.delegate = self;
    _alertView = alert;
    [_alertView show];
}

- (void)homeButton {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 49, 49)];
    btn.center = CGPointMake(ScreenSize.width/2, ScreenSize.height-24);
    [btn setBackgroundImage:[UIImage imageNamed:@"home.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(gotoHome) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.cornerRadius = 24.0;
    [self.view addSubview:btn];
}
- (void)gotoHome {
    [self dispLayAlertView];
}

- (void)initUI {
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, ScreenSize.height-49)];
    _scrollView.contentSize = CGSizeMake(ScreenSize.width*[_imageArray count], ScreenSize.height-49);
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
    _pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(0, ScreenSize.height-60, ScreenSize.width, 10)];
    _pageControl.currentPageIndicatorTintColor=[UIColor colorWithRed:0.153 green:0.533 blue:0.796 alpha:1.0];
    [self.view addSubview:_pageControl];
    _pageControl.numberOfPages= [_imageArray count];
    

    UIImage *image;
    for (int i = (int)[_imageArray count] -1; i>=0; i--) {
        image = _imageArray[i];
        [self createViewOne:image andIndex:i];
    }
}

-(void)createViewOne: (UIImage *)image andIndex :(NSInteger)index{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenSize.width*index, 0, ScreenSize.width, ScreenSize.height-49)];
    imageView.image = image;
//    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_scrollView addSubview:imageView];
    
}

- (void)tapClick:(NSInteger)index {
    NSLog(@"%ld",index);
}
#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    _pageControl.currentPage = scrollView.contentOffset.x/ScreenSize.width;
}

#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (0 == buttonIndex) {
        if (_isCompareTuan) {
            [((AppDelegate *)appDelegate).tuanImageArrays removeAllObjects];
        }else {
            [((AppDelegate *)appDelegate).wangImageArrays removeAllObjects];
        }
    }
    UIStoryboard *stroy = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *mainVC = [stroy instantiateViewControllerWithIdentifier:@"MainTab"];
    [self presentViewController:mainVC animated:YES completion:nil];

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
