//
//  NSDictionary+DeepMutableCopy.m
//  Compare
//
//  Created by huangshuimei on 11/1/15.
//  Copyright © 2015 huangshuimei. All rights reserved.
//

#import "NSDictionary+DeepMutableCopy.h"

@implementation NSDictionary (DeepMutableCopy)
-(NSMutableDictionary *)mutableDeepCopy
{
    NSMutableDictionary *ret = [[NSMutableDictionary alloc] initWithCapacity:[self count]];
    NSArray *keys = [self allKeys];
    for (id key in keys)
    {
        id oneValue = [self valueForKey:key];
        id oneCopy = nil;
        
        if ([oneValue respondsToSelector:@selector(mutableDeepCopy)])
            oneCopy = [oneValue mutableDeepCopy];
        else if ([oneValue respondsToSelector:@selector(mutableCopy)])
            oneCopy = [oneValue mutableCopy];
        if (oneCopy == nil)
            oneCopy = [oneValue copy];
        [ret setValue:oneCopy forKey:key];
    }
    return ret;
}
@end
