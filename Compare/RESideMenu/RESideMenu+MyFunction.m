//
//  RESideMenu+MyFunction.m
//  Compare
//
//  Created by hsm on 2017/6/22.
//  Copyright © 2017年 huangshuimei. All rights reserved.
//

#import "RESideMenu+MyFunction.h"

@implementation RESideMenu (MyFunction)
- (void)hideContentViewContainer
{
    self.contentViewController.view.hidden = YES;
    self.contentButton.hidden = YES;
}


@end
