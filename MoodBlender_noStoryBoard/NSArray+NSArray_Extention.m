//
//  NSArray+NSArray_Extention.m
//  MoodBlender_noStoryBoard
//
//  Created by altofwe on 13/08/28.
//  Copyright (c) 2013年 neko. All rights reserved.
//

#import "NSArray+NSArray_Extention.h"

@implementation NSArray (NSArray_Extention)
- (int)setKeyToIndex:(NSString *)key{
    for(int i = 0; i < self.count; ++i){
        if ([self objectAtIndex:i] == key){
            return i;
        }
    }
    return 0;
}
@end
