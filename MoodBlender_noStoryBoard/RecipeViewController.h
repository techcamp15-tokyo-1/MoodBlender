//
//  RecipeViewController.h
//  MoodBlender_noStoryBoard
//
//  Created by altofwe on 13/08/22.
//  Copyright (c) 2013年 neko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StartViewController.h"
#import "RecipeMenuViewController.h"

@interface RecipeViewController : UIViewController
{
    NSString *path;
    NSDictionary *dictionary;
    NSArray *keys;
}
@property (nonatomic, retain) NSIndexPath *recipe_index;
@property (nonatomic, retain) NSString *prevView;
- (UILabel *)createRecipeLabel:(NSString *)text;
@end
