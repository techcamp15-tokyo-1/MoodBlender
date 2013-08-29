//
//  ShakeViewController.h
//  MoodBlender_noStoryBoard
//
//  Created by altofwe on 13/08/22.
//  Copyright (c) 2013年 neko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ShakingViewController.h"
#import "StartViewController.h"

@interface ShakeViewController : UIViewController
{
    UIButton *gin;
    UIButton *vodka;
    NSString *baseState;
    UIImageView *tap_message;
}
@end
