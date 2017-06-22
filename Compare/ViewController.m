//
//  ViewController.m
//  Compare
//
//  Created by huangshuimei on 10/3/15.
//  Copyright (c) 2015 huangshuimei. All rights reserved.
//

#import "ViewController.h"
#import "MainViewController.h"
#import "LeftViewController.h"
#import "RightViewController.h"
#import "LeftNagViewController.h"

@interface ViewController ()<didSelectRowInLeftControllerDelegate>{
    BOOL _isShowingLeftVC;
    BOOL _isShowingRightVC;
}
@property(nonatomic, strong) MainViewController *centerController;
@property(nonatomic, strong) RightViewController *rightController;
//@property(nonatomic, strong) LeftViewController *leftNagController;
@property(nonatomic, strong) LeftNagViewController *leftNagController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    _centerController = (MainViewController *)[storyboard instantiateViewControllerWithIdentifier:@"MainTab"];
    [self.view addSubview:_centerController.view];
    [_centerController.view setTag:1];
    [_centerController.view setFrame:self.view.bounds];
    
    [self.view addSubview:self.leftNagController.view];
    [_leftNagController.view setTag:2];
    [_leftNagController.view setFrame:self.view.bounds];
    
    [self.view addSubview:self.rightController.view];
    [_rightController.view setTag:3];
    [_rightController.view setFrame:self.view.bounds];
    
    [self.view bringSubviewToFront:_centerController.view];
    
    //add swipe gesture
    UISwipeGestureRecognizer *swipeGestureRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
    [swipeGestureRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [_centerController.view addGestureRecognizer:swipeGestureRight];
    
    UISwipeGestureRecognizer *swipeGestureLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
    [swipeGestureLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [_centerController.view addGestureRecognizer:swipeGestureLeft];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(LeftNagViewController *)leftNagController {
    if (_leftNagController == nil) {
        LeftViewController *leftVC = [[LeftViewController alloc] init];
        leftVC.delegate = self;
        CGFloat leftWidth =  self.view.frame.size.width-100;
        _leftNagController.view.frame = CGRectMake(self.view.frame.origin.x - leftWidth, 0,leftWidth, self.view.frame.size.height);
        _leftNagController = [[LeftNagViewController alloc] initWithRootViewController:leftVC];
    }
    return _leftNagController;
}

-(RightViewController *)rightController {
    if (_rightController == nil) {
        _rightController = [[RightViewController alloc] init];
        _rightController.view.frame = CGRectMake(CGRectGetMaxX(self.view.frame), 0, self.view.frame.size.width, self.view.frame.size.height);
        _rightController.view.hidden = YES;
    }
    return _rightController;
}

-(void) swipeGesture:(UISwipeGestureRecognizer *)swipeGestureRecognizer {
    
    CALayer *layer = [_centerController.view layer];
    layer.shadowColor = [UIColor blackColor].CGColor;
    layer.shadowOffset = CGSizeMake(1, 1);
    layer.shadowOpacity = 1;
    layer.shadowRadius = 20.0;
    if (swipeGestureRecognizer.direction == UISwipeGestureRecognizerDirectionRight) {
        [self showLeftVC];
    }
    if (swipeGestureRecognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
        [self showRightVC];
    }
}

- (void)showLeftVC {
    if (_isShowingRightVC) {
        [_rightController.view setHidden:YES];
        _isShowingRightVC = !_isShowingRightVC;
    }else{
        [_leftNagController.view setHidden:NO];
    }
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    if (_centerController.view.frame.origin.x == self.view.frame.origin.x || _centerController.view.frame.origin.x == -200) {
        [_centerController.view setFrame:CGRectMake(_centerController.view.frame.origin.x+200, _centerController.view.frame.origin.y, _centerController.view.frame.size.width, _centerController.view.frame.size.height)];
    }
    
    [UIView commitAnimations];
    
    if (_leftNagController.view.hidden == NO) {
        _isShowingLeftVC = YES;
    }
}

- (void)showRightVC {
    if (_isShowingLeftVC) {
        [_leftNagController.view setHidden:YES];
        _isShowingLeftVC = !_isShowingLeftVC;
    }else{
        [_rightController.view setHidden:NO];
    }
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    if (_centerController.view.frame.origin.x == self.view.frame.origin.x || _centerController.view.frame.origin.x == 200) {
        [_centerController.view setFrame:CGRectMake(_centerController.view.frame.origin.x-200, _centerController.view.frame.origin.y, _centerController.view.frame.size.width, _centerController.view.frame.size.height)];
    }
    
    [UIView commitAnimations];
    
    if (_rightController.view.hidden == NO) {
        _isShowingRightVC = YES;
    }
}
#pragma mark - didSelectRowInLeftControllerDelegate
- (void)didSelectRowInLeft {
    [self showRightVC];
}

@end
