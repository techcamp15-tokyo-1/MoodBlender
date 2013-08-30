//
//  RecipeViewController.h
//  MoodBlender_noStoryBoard
//
//  Created by altofwe on 13/08/22.
//  Copyright (c) 2013年 neko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMessageComposeViewController.h>
#import "StartViewController.h"

@interface RecipeViewController : UIViewController <MFMailComposeViewControllerDelegate, UINavigationBarDelegate, UITextFieldDelegate>
{
    NSString *path;
    NSDictionary *dictionary;
    NSArray *keys;
    NSString *str;
}

@property (nonatomic, retain) NSIndexPath *recipeIndex;
- (UILabel *)createRecipeLabel:(NSString *)text;
@end

@interface MailView : UIViewController <UITextFieldDelegate, MFMailComposeViewControllerDelegate>

@end
