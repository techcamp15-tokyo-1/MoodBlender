//
//  RecipeTableViewController.h
//  MoodBlender_noStoryBoard
//
//  Created by altofwe on 13/08/26.
//  Copyright (c) 2013年 neko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecipeViewController.h"

@interface RecipeTableViewController : UITableViewController
{
    NSString *path;
    NSDictionary *dictionary;
    NSArray *keys;
}
@end
