//
//  AppDelegate.h
//  Compare
//
//  Created by huangshuimei on 10/3/15.
//  Copyright (c) 2015 huangshuimei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) NSMutableArray *tuanImageArrays;
@property (nonatomic, strong) NSMutableArray *wangImageArrays;
@property (nonatomic, assign) BOOL isTuanFlag;


@end

