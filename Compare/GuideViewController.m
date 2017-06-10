//
//  GuideViewController.m
//  Compare
//
//  Created by huangshuimei on 10/4/15.
//  Copyright (c) 2015 huangshuimei. All rights reserved.
//

#import "GuideViewController.h"
#import "Utility.h"
#import "MainRegViewController.h"
#import "RegViewController.h"



@interface GuideViewController ()<UIScrollViewDelegate>{
    UIImageView *imageViewOne;
    UIImageView *imageViewTwo;
    UIImageView *imageViewThree;
    UIButton    *_forwardBtn;
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
    [self createForwardBtn];
    [self setForwardBtnAnmiation];
    
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

- (void)createForwardBtn{
    if (_forwardBtn == nil) {
        _forwardBtn = [UIButton new];
        _forwardBtn.frame = CGRectMake(ScreenSize.width - 100, ScreenSize.height/2 -50, 100, 100);
        [_forwardBtn setImage:[UIImage imageNamed:@"forward.png"] forState:UIControlStateNormal];
        _forwardBtn.userInteractionEnabled = NO;
        [self.view addSubview:_forwardBtn];
    }
}

- (void)setForwardBtnAnmiation{
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    scaleAnimation.toValue = [NSNumber numberWithFloat:2.0];
    scaleAnimation.autoreverses = YES;
    scaleAnimation.fillMode = kCAFillModeForwards;
    scaleAnimation.removedOnCompletion = NO;
    scaleAnimation.repeatCount = MAXFLOAT;
    scaleAnimation.duration = 1.5;
    [_forwardBtn.layer addAnimation:scaleAnimation forKey:@"scaleAnimation"];
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
    NSLog(@"引导页完成,调到注册页面");
    //到注册界面
    
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    MainRegViewController *mainVC = [story instantiateViewControllerWithIdentifier:@"MainReg"];
//    [self presentViewController:mainVC animated:YES completion:nil];
    
    RegViewController* reg=[[RegViewController alloc] init];
    [self presentViewController:reg animated:YES completion:^{
           [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES] forKey:@"isGuided"];
    }];

 
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

#pragma mark - 
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
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
