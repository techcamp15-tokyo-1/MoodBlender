//
//  ShakingViewController.h
//  MoodBlender_noStoryBoard
//
//  Created by altofwe on 13/08/23.
//  Copyright (c) 2013年 neko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShakingViewController : UIViewController <UIAccelerometerDelegate>
{
    int _count, shake;
    CGPoint before_point;
    UIImageView *background;
    int ran;
    int half_ran;
}
@property (nonatomic, weak) UIButton *shaker;
@end
