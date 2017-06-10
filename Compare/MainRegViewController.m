//
//  MainRegViewController.m
//  Compare
//
//  Created by huangshuimei on 11/1/15.
//  Copyright © 2015 huangshuimei. All rights reserved.
//

#import "MainRegViewController.h"
#import "RegViewController.h"

@implementation MainRegViewController
- (IBAction)registerUser:(id)sender {
    RegViewController* reg=[[RegViewController alloc] init];
    [self presentViewController:reg animated:YES completion:^{
        
    }];
}

@end
