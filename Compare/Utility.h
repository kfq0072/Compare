//
//  Utility.h
//  Compare
//
//  Created by huangshuimei on 10/3/15.
//  Copyright (c) 2015 huangshuimei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define ScreenSize [UIScreen mainScreen].bounds.size
#define ScreenFrame [UIScreen mainScreen].bounds
#define appDelegate [UIApplication sharedApplication].delegate
typedef enum {
    meiTu,
    dianPing,
    laShou,
    woWo,
    nuoMi,
    soso,
}webViewUrl;

@interface Utility : NSObject
+ (UIImage*) createImageWithColor:(UIColor*) color;
+ (CAGradientLayer*)designColor :(CGRect)rect;
@end
