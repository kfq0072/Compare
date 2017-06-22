//
//  LeftViewController.h
//  LeftRightSlider
//
//  Created by Zhao Yiqi on 13-11-27.
//  Copyright (c) 2013年 Zhao Yiqi. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol didSelectRowInLeftControllerDelegate<NSObject>
- (void)didSelectRowInLeft;
@end
@interface LeftViewController : UIViewController
@property(nonatomic, weak)id<didSelectRowInLeftControllerDelegate>delegate;
@end
