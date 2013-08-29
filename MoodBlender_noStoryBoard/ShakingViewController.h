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
    int count, shake;
    CGPoint beforePoint;
    UIImageView *background;
    int ran;
    int halfRan;
    bool shakeEnd;
    UIButton *shaker;
    NSString *path;
    NSDictionary *dictionary;
    NSArray *keys;
    NSIndexPath *indexPath;
    UIImageView *shakeMessage;
    UIImageView *tapMessage;
}
@property (nonatomic, retain) NSString *baseState;
- (int)keyToIndex:(NSString *)arrayKey
         UseArray:(NSArray *)array;
@end
