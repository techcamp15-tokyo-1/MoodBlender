//
//  ViewController.m
//  MoodBlender_noStoryBoard
//
//  Created by altofwe on 13/08/22.
//  Copyright (c) 2013年 neko. All rights reserved.
//

#import "StartViewController.h"
#import "UIView+UIView_MyExtention.h"

@interface StartViewController ()

@end

@implementation StartViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"StartViewController";
    
    //tmp
    //NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //NSMutableDictionary *defaults = [NSMutableDictionary dictionary];
    //[defaults setObject:@"YES" forKey:@"hoge"];
    //[userDefaults registerDefaults:defaults];
    //[userDefaults setBool:YES forKey:@"hoge"];
    //[userDefaults synchronize];
    //NSLog(@"%d", [userDefaults boolForKey:@"hoge"]);
    
    //Set background image
    UIImage *background_image = [UIImage imageNamed:@"background_1.png"];
    CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
    CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
    CGRect correctFrame = CGRectOffset(applicationFrame, 0, -CGRectGetHeight(statusBarFrame));
    UIImageView *background = [[UIImageView alloc] initWithFrame:correctFrame];
    background.contentMode = UIViewContentModeScaleAspectFill;
    background.image = background_image;
    
    //Create objects
    UIImage *recipe_image = [UIImage imageNamed:@"menu2.png"];
    UIImage *shake_image = [UIImage imageNamed:@"shaker.png"];
    UILabel *welcome = [[UILabel alloc] init];
    UIButton *recipe = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
    UIButton *shaker = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 100)];
    
    //Set UILabel text
    welcome.text = @"Enjoy your cocktail!";
    [welcome sizeToFit];
    
    //Set UILabel background color
    welcome.backgroundColor = [UIColor blackColor];
    
    //Set UILabel font color
    welcome.textColor = [UIColor whiteColor];
    
    //Set UIButtons image
    [recipe setImage:recipe_image forState:UIControlStateNormal];
    [shaker setImage:shake_image forState:UIControlStateNormal];
    
    //Move objects to center
    welcome.center = self.view.center;
    recipe.center = self.view.center;
    shaker.center = self.view.center;
    
    //Move objects
    welcome.centerY -= 120;
    recipe.centerY += 20;
    shaker.centerY += 20;
    recipe.centerX += 70;
    shaker.centerX -= 70;
    
    //Set UIImage backgroundColor clearly
    welcome.backgroundColor = [UIColor clearColor];
    recipe.backgroundColor = [UIColor clearColor];
    shaker.backgroundColor = [UIColor clearColor];
    
    //Set UIButtons motion
    [recipe addTarget:self action:@selector(recipe:) forControlEvents:UIControlEventTouchUpInside ];
    [shaker addTarget:self action:@selector(shaker:) forControlEvents:UIControlEventTouchUpInside ];
    
    //Show objects
    background.origin = CGPointZero;
    [self.view addSubview:background];
    [self.view addSubview:welcome];
    [self.view addSubview:recipe];
    [self.view addSubview:shaker];
    
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackOpaque];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//recipeButton motion
-(void)recipe:(UIButton*)recipe{
    RecipeTableViewController *nextView = [[RecipeTableViewController alloc] init];
    nextView.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    NavigationViewController *nextNavi = [[NavigationViewController alloc] initWithRootViewController:nextView];
    
    //MEMO:NavigationControllerの表示ON/OFF管理, 開発・デバッグ時以外はOFFの予定
    [nextView.navigationController setNavigationBarHidden:YES animated:YES];
    
    [self presentViewController:nextNavi animated:YES completion:^{}];
}

//shakerButton motion
-(void)shaker:(UIButton*)shaker{
    ShakeViewController *nextView = [[ShakeViewController alloc] init];
    nextView.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    NavigationViewController *nextNavi = [[NavigationViewController alloc] initWithRootViewController:nextView];
    
    //MEMO:NavigationControllerの表示ON/OFF管理, 開発・デバッグ時以外はOFFの予定
    [nextView.navigationController setNavigationBarHidden:YES animated:YES];
    
    [self presentViewController:nextNavi animated:YES completion:^{}];
    
}

@end
