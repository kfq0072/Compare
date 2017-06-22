//
//  AnimationPauseViewController.m
//  AnimationPause
//
//  Created by gamy on 12-1-5.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "AnimationPauseViewController.h"
#define ScreenSize   [UIScreen mainScreen].bounds.size


@implementation AnimationPauseViewController
@synthesize controlButton;
//添加
@synthesize imgUp;
@synthesize imgDown;

-(void)viewDidLoad {
    [super viewDidLoad];
    UIImage *image = [[UIImage imageNamed:@"me"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(dismissAnimationVC)];
    self.navigationItem.leftBarButtonItem = leftBar;
    
    aiLoad.hidden=YES;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"glass" ofType:@"wav"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &soundID);
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addAnimations) name:@"shake" object:nil];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)dismissAnimationVC {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
  
    // Release any cached data, images, etc that aren't in use.
}

//添加
#pragma mark - 摇一摇动画效果
- (void)addAnimations
{
    
    AudioServicesPlaySystemSound (soundID);
    
    //让imgup上下移动
    CABasicAnimation *translation2 = [CABasicAnimation animationWithKeyPath:@"position"];
    translation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    translation2.fromValue = [NSValue valueWithCGPoint:CGPointMake(ScreenSize.width/2, imgUp.frame.size.height/2)];
//    translation2.toValue = [NSValue valueWithCGPoint:CGPointMake(160, 40)];
        translation2.toValue = [NSValue valueWithCGPoint:CGPointMake(ScreenSize.width/2, 20)];
    translation2.duration = 0.4;
    translation2.repeatCount = 1;
    translation2.autoreverses = YES;
    
    //让imagdown上下移动
    CABasicAnimation *translation = [CABasicAnimation animationWithKeyPath:@"position"];
    translation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    translation.fromValue = [NSValue valueWithCGPoint:CGPointMake(ScreenSize.width/2, imgDown.frame.size.height/2 + 50 +imgUp.frame.size.height)];
//    translation.toValue = [NSValue valueWithCGPoint:CGPointMake(160, 420)];
        translation.toValue = [NSValue valueWithCGPoint:CGPointMake(ScreenSize.width/2, 520)];
    translation.duration = 0.4;
    translation.repeatCount = 1;
    translation.autoreverses = YES;
    
    [imgDown.layer addAnimation:translation forKey:@"translation"];
    [imgUp.layer addAnimation:translation2 forKey:@"translation2"];
    
    [aiLoad stopAnimating];
    aiLoad.hidden=YES;
    
}

#pragma mark - 摇一摇
-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if(motion==UIEventSubtypeMotionShake)
    {
        NSLog(@"shake begin ....");
        aiLoad.hidden=NO;
        [aiLoad startAnimating];
    }
}


-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    if(event.subtype==UIEventSubtypeMotionShake)
    {
    //添加
    [[NSNotificationCenter defaultCenter] postNotificationName:@"shake" object:self];
    //添加
    AudioServicesPlaySystemSound (soundID);	
        
    }
}

#pragma mark - View lifecycle
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)clickControlButton:(id)sender {

    //添加 
    [self addAnimations];
    //添加    
}


@end
