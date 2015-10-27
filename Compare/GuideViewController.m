//
//  GuideViewController.m
//  Compare
//
//  Created by huangshuimei on 10/4/15.
//  Copyright (c) 2015 huangshuimei. All rights reserved.
//

#import "GuideViewController.h"
#import "Utility.h"
#import "MainViewController.h"

@interface GuideViewController (){
    UIImageView *imageViewOne;
    UIImageView *imageViewTwo;
    UIImageView *imageViewThree;
}
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI {
    self.scrollView = [[UIScrollView alloc] initWithFrame:ScreenFrame];
    _scrollView.pagingEnabled = YES;
    _scrollView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:_scrollView];
    
    _pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(0, ScreenSize.height-50, ScreenSize.width, 10)];
    _pageControl.currentPageIndicatorTintColor=[UIColor colorWithRed:0.153 green:0.533 blue:0.796 alpha:1.0];
    [self.view addSubview:_pageControl];
    _pageControl.numberOfPages=3;
    
    [self createViewOne];
    [self createViewTwo];
    [self createViewThree];
}


-(void)createViewOne{
    
    UIView *view = [[UIView alloc] initWithFrame:ScreenFrame];
    
    imageViewOne = [[UIImageView alloc] initWithFrame:ScreenFrame];
    imageViewOne.contentMode = UIViewContentModeScaleAspectFit;
    imageViewOne.image = [UIImage imageNamed:@"L1"];
    [view addSubview:imageViewOne];
    
    
    UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonpress1:)];
    imageViewOne.userInteractionEnabled = YES;
    [imageViewOne addGestureRecognizer:singleTap1];
    
    
    [_scrollView addSubview:view];
    
}
-(void)createViewTwo{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(ScreenSize.width, 0, ScreenSize.width, ScreenSize.height)];
    imageViewTwo = [[UIImageView alloc] initWithFrame:ScreenFrame];
    imageViewTwo.contentMode = UIViewContentModeScaleAspectFit;
    imageViewTwo.image = [UIImage imageNamed:@"L2"];
    [view addSubview:imageViewTwo];
    UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonpress2:)];
    imageViewTwo.userInteractionEnabled = YES;
    [imageViewTwo addGestureRecognizer:singleTap1];
    
    [_scrollView addSubview:view];
    
}


-(void)createViewThree{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(ScreenSize.width*2, 0, ScreenSize.width, ScreenSize.height)];
    imageViewThree = [[UIImageView alloc] initWithFrame:ScreenFrame];
    imageViewThree.contentMode = UIViewContentModeScaleAspectFit;
    imageViewThree.image = [UIImage imageNamed:@"L3"];
    [view addSubview:imageViewThree];
    
    UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonpress3:)];
    imageViewThree.userInteractionEnabled = YES;
    [imageViewThree addGestureRecognizer:singleTap1];
    
    [_scrollView addSubview:view];
}
#pragma mark -- tap image
-(void)buttonpress1:(id)sender
{
    CGFloat pageWidth = CGRectGetWidth(self.view.bounds);
    CGPoint scrollPoint = CGPointMake(pageWidth, 0);
    [_scrollView setContentOffset:scrollPoint animated:YES];
    _pageControl.currentPage = 1;
    
}

-(void)buttonpress2:(id)sender
{
    CGFloat pageWidth = CGRectGetWidth(self.view.bounds);
    CGPoint scrollPoint = CGPointMake(pageWidth*2, 0);
    [_scrollView setContentOffset:scrollPoint animated:YES];
    
    _pageControl.currentPage = 2;
    
}

-(void)buttonpress3:(id)sender
{
    NSLog(@"引导页完成");
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MainViewController *mainVC = [story instantiateViewControllerWithIdentifier:@"MainTab"];
    [self presentViewController:mainVC animated:YES completion:nil];

    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES] forKey:@"isGuided"];
}


-(void)createViewOne: (UIImage *)image andIndex :(NSInteger)index{
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:ScreenFrame];
    imageView.image = image;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    UITapGestureRecognizer *singTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:singTap];
    [_scrollView addSubview:imageView];
    
    
}

- (void)tapClick:(NSInteger)index {
    NSLog(@"%ld",index);
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
