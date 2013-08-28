//
//  RecipeViewController.h
//  MoodBlender_noStoryBoard
//
//  Created by altofwe on 13/08/22.
//  Copyright (c) 2013年 neko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+UIView_MyExtention.h"

@interface RecipeViewController : UIViewController
@property (nonatomic, retain) NSDictionary *recipe;
- (UILabel *)createRecipeLabel:(NSString *)text;
@end
