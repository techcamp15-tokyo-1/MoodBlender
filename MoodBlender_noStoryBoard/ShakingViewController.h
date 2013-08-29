//
//  ShakingViewController.h
//  MoodBlender_noStoryBoard
//
//  Created by altofwe on 13/08/23.
//  Copyright (c) 2013年 neko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "RecipeViewController.h"


@interface ShakingViewController : UIViewController <UIAccelerometerDelegate>
{
    int _count, shake;
    CGPoint before_point;
    UIImageView *background;
    int ran;
    int half_ran;
    bool shake_end;
    UIButton *shaker;
    UIImageView *shake_message;
    NSString *path;
    NSDictionary *dictionary;
    NSArray *keys;
    NSIndexPath *indexPath;
}
@property (nonatomic, retain) NSString *baseState;
- (int)keyToIndex:(NSString *)arrayKey
         UseArray:(NSArray *)array;
@end
