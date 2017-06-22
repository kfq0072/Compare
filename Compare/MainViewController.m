//
//  MainViewController.m
//  Compare
//
//  Created by huangshuimei on 10/3/15.
//  Copyright (c) 2015 huangshuimei. All rights reserved.
//

#import "MainViewController.h"
#import "Utility.h"
#import "LeftViewController.h"
#import "RightViewController.h"
#import "LoginViewController.h"
#import "LeftNagViewController.h"
#import "RESideMenu.h"

@interface MainViewController (){
    BOOL _isShowingLeft;
}
@property (nonatomic, strong)LeftViewController *leftController;
@property (nonatomic, strong)RightViewController *rightController;
@property (nonatomic, strong) NSMutableIndexSet *optionIndices;


@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTabItem];
    [self setLeftBarBoutton];
    //add swipe gesture
//    UISwipeGestureRecognizer *swipeGestureRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
//    [swipeGestureRight setDirection:UISwipeGestureRecognizerDirectionRight];
//    [self.view addGestureRecognizer:swipeGestureRight];
//    
//    UISwipeGestureRecognizer *swipeGestureLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
//    [swipeGestureLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
//    [self.view addGestureRecognizer:swipeGestureLeft];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.view.hidden = NO;
//    [self.view addSubview:self.leftController.view];
//    [self.view addSubview:self.rightController.view];

}

- (void)setTabItem {
    UITabBarItem *item1 = [self.tabBar.items objectAtIndex:0];
    item1.image = [[UIImage imageNamed:@"tuan"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item1.selectedImage = [[UIImage imageNamed:@"tuan_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *item2 = [self.tabBar.items objectAtIndex:1];
    
    item2.image = [[UIImage imageNamed:@"wang"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item2.selectedImage = [[UIImage imageNamed:@"wang_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *item3 = [self.tabBar.items objectAtIndex:2];
    
    item3.image = [[UIImage imageNamed:@"me"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item3.selectedImage = [[UIImage imageNamed:@"me"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIColor *bottomColor = [UIColor colorWithRed:220.0f/255.0f green:191.0/255.0 blue:192.0f/255.0f alpha:1.0];
    UIImage *imagebottom= [Utility createImageWithColor:bottomColor];
    [self.tabBar setBackgroundImage:imagebottom];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    NSLog(@"%@",item);
}

- (void)setLeftBarBoutton {
    UIImage *image = [[UIImage imageNamed:@"me"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithImage:image  style:UIBarButtonItemStylePlain target:self action:@selector(presentLeftMenuViewController:)];
    self.navigationItem.leftBarButtonItem = leftBar;
}

-(LeftViewController *)leftController {
    if (_leftController == nil) {
        LeftViewController *leftVC = [[LeftViewController alloc] init];
        _leftController = leftVC;
                CGFloat leftWidth =  self.view.frame.size.width-100;
        _leftController.view.frame = CGRectMake(self.view.frame.origin.x - leftWidth, 0,leftWidth, self.view.frame.size.height);
        _leftController.view.hidden = YES;
    }
    return _leftController;
}

-(RightViewController *)rightController {
    if (_rightController == nil) {
        _rightController = [[RightViewController alloc] init];
        _rightController.view.frame = CGRectMake(CGRectGetMaxX(self.view.frame), 0, self.view.frame.size.width, self.view.frame.size.height);
        _rightController.view.hidden = YES;
    }
    return _rightController;
}

-(void)swipeGesture:(UISwipeGestureRecognizer *)swipeGestureRecognizer {
    CALayer *layer = [self.view layer];
    layer.shadowColor = [UIColor blackColor].CGColor;
    layer.shadowOffset = CGSizeMake(1, 1);
    layer.shadowOpacity = 1;
    layer.shadowRadius = 20.0;
    if (swipeGestureRecognizer.direction == UISwipeGestureRecognizerDirectionRight) {
        if (_rightController.view.hidden == NO) {
            [self hideRightController];
        }else if (_leftController.view.hidden == YES) {
            [self showLeftController];
            _isShowingLeft = YES;
        }
    }
    if (swipeGestureRecognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
        if (_isShowingLeft == YES) {
            [self hideLeftController];
            _isShowingLeft = NO;
            return;
        }
        
        if (_rightController.view.hidden == YES) {
            [self showRightController];
        }
    }
}

- (void)hideRightController {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    _rightController.view.frame =  CGRectMake(CGRectGetMaxX(self.view.frame), 0, self.view.frame.size.width, self.view.frame.size.height);
     [UIView commitAnimations];
      [_rightController.view setHidden:YES];
}

- (void)showRightController {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
     [_rightController.view setFrame:CGRectMake(self.view.frame.origin.x + 100, 0, self.view.frame.size.width-100, self.view.frame.size.height)];
     [UIView commitAnimations];
     [_rightController.view setHidden:NO];
}

- (void)hideLeftController {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    CGFloat leftWidth =  self.view.frame.size.width-100;
    _leftController.view.frame = CGRectMake(self.view.frame.origin.x - leftWidth, 0,leftWidth, self.view.frame.size.height);
    [UIView commitAnimations];
    [_leftController.view setHidden:YES];
}

- (void)showLeftController {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [_leftController.view setFrame:CGRectMake(self.view.frame.origin.x, 0, self.view.frame.size.width-100, self.view.frame.size.height)];
    [UIView commitAnimations];
     [_leftController.view setHidden:NO];
}
@end
