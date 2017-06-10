//
//  NSDictionary+DeepMutableCopy.h
//  Compare
//
//  Created by huangshuimei on 11/1/15.
//  Copyright © 2015 huangshuimei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (DeepMutableCopy)
-(NSMutableDictionary *)mutableDeepCopy;
@end
