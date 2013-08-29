//
//  ParentViewController.h
//  MoodBlender_noStoryBoard
//
//  Created by altofwe on 13/08/30.
//  Copyright (c) 2013年 neko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "StartViewController.h"

@interface ParentViewController : UIViewController
@property (nonatomic, retain) id viewController;
@property (nonatomic, retain) NSString *animationType;
@property BOOL hiddenHome;
@property BOOL hiddenBack;
@property BOOL createNewPage;
@end
