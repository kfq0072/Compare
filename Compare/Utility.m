//
//  Utility.m
//  Compare
//
//  Created by huangshuimei on 10/3/15.
//  Copyright (c) 2015 huangshuimei. All rights reserved.
//

#import "Utility.h"

@implementation Utility
+ (UIImage*) createImageWithColor:(UIColor*) color{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (CAGradientLayer*)designColor :(CGRect)rect {
    UIColor *topColor = [UIColor colorWithRed:196.0f/255.0f green:166.0/255.0 blue:189.0f/255.0f alpha:1.0];
    UIColor *bottomColor = [UIColor colorWithRed:220.0f/255.0f green:191.0/255.0 blue:192.0f/255.0f alpha:1.0];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = rect;
    UIColor *midColor = [UIColor colorWithRed:220.0f/255.0f green:231.0/255.0 blue:164.0f/255.0f alpha:1.0];
    gradient.colors = [NSArray arrayWithObjects:(id)topColor.CGColor,
                       (id)midColor.CGColor,
                       (id)bottomColor.CGColor,nil];
    return gradient;

}
@end
