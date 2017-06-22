//
//  AppDelegate.m
//  Compare
//
//  Created by huangshuimei on 10/3/15.
//  Copyright (c) 2015 huangshuimei. All rights reserved.
//

#import "AppDelegate.h"
#import "GuideViewController.h"
#import "MainViewController.h"
#import "Utility.h"
#import <iAd/iAd.h>
#import "BaseNavViewController.h"
#import <SMS_SDK/SMSSDK+DeprecatedMethods.h>
#import "LeftViewController.h"
#import "LeftNagViewController.h"
#import "RESideMenu.h"
#import "ViewController.h"

#define appKey @"bc8bc5ee6870"
#define appSecret @"4bb6b7f1ed5fd2e9ad4a7e12d77c8d30"



@interface AppDelegate ()<RESideMenuDelegate>
@property (nonatomic, strong)ADBannerView *bannerView;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [SMSSDK registerApp:appKey withSecret:appSecret];
    
    self.window = [[UIWindow alloc] initWithFrame:ScreenFrame];
    
   
    UIViewController *VC = nil;

    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"isGuided"]) {
        VC = [[GuideViewController alloc] init];
        self.window.rootViewController = VC;
    }else {
//       UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil]; 
//        VC = [story instantiateViewControllerWithIdentifier:@"MainTab"];
//        BaseNavViewController *baseNav = [[BaseNavViewController alloc] initWithRootViewController:VC];
//
//        LeftNagViewController *leftNav = [[LeftNagViewController alloc] initWithRootViewController:[[LeftViewController alloc] init]];
//        RESideMenu *sideMenuViewController = [[RESideMenu alloc] initWithContentViewController:baseNav leftMenuViewController:leftNav rightMenuViewController:nil];
//        
//        sideMenuViewController.backgroundImage = [UIImage imageNamed:@"Stars"];
//        sideMenuViewController.menuPreferredStatusBarStyle = 1; // UIStatusBarStyleLightContent
//        sideMenuViewController.delegate = self;
//        sideMenuViewController.contentViewShadowColor = [UIColor blackColor];
//        sideMenuViewController.contentViewShadowOffset = CGSizeMake(0, 0);
//        sideMenuViewController.contentViewShadowOpacity = 0.6;
//        sideMenuViewController.contentViewShadowRadius = 12;
//        sideMenuViewController.contentViewShadowEnabled = YES;
//        self.window.rootViewController = sideMenuViewController;
        
//        UIStoryboard *loginSb = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
//        VC = [loginSb instantiateViewControllerWithIdentifier:@"LoginViewController"];
//        self.window.rootViewController = VC;
        
       
        VC = [[ViewController alloc] init];
        BaseNavViewController *baseNav = [[BaseNavViewController alloc] initWithRootViewController:VC];
        self.window.rootViewController = VC;

    }
    
    [self.window makeKeyAndVisible];
    
  
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark RESideMenu Delegate

- (void)sideMenu:(RESideMenu *)sideMenu willShowMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"willShowMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)sideMenu:(RESideMenu *)sideMenu didShowMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"didShowMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)sideMenu:(RESideMenu *)sideMenu willHideMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"willHideMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)sideMenu:(RESideMenu *)sideMenu didHideMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"didHideMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

@end
