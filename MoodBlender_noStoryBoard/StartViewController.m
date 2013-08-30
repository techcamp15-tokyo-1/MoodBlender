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
    
    //self.title = @"StartViewController";
    
    //Set background image
    UIImage *backgroundImage1 = [UIImage imageNamed:@"background.png"];
    UIImage *backgroundImage2 = [UIImage imageNamed:@"background1.png"];
    NSArray *backgroundImageArray = [NSArray arrayWithObjects:backgroundImage1, backgroundImage2, nil];
    UIImageView *background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    background.contentMode = UIViewContentModeScaleAspectFill;
    background.image = backgroundImage1;
    background.animationImages = backgroundImageArray;
    background.animationDuration = 1.75;
    [background startAnimating];
    //CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
    //CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
    //CGRect correctFrame = CGRectOffset(applicationFrame, 0, -CGRectGetHeight(statusBarFrame));
    
    //Create objects
    UIImage *recipeImage = [UIImage imageNamed:@"menu2.png"];
    UIImage *shakeImage = [UIImage imageNamed:@"shaker.png"];
    UIImage *settingImage = [UIImage imageNamed:@"gear.png"];
    
    UILabel *welcome = [[UILabel alloc] init];
    UIButton *recipe = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    UIButton *shaker = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 100)];
    UIButton *setting = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 50, self.view.frame.size.height - 90, 50, 50)];
    
    //Set UILabel text
    welcome.text = @"Enjoy your cocktail!";
    [welcome sizeToFit];
    
    //Set UILabel background color
    welcome.backgroundColor = [UIColor blackColor];
    
    //Set UILabel font color and style
    welcome.textColor = [UIColor whiteColor];
    welcome.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
    
    //Set UIButtons image
    [recipe setImage:recipeImage forState:UIControlStateNormal];
    [shaker setImage:shakeImage forState:UIControlStateNormal];
    [setting setImage:settingImage forState:UIControlStateNormal];
    
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
    
    //Set UIImages backgroundColor clearly
    welcome.backgroundColor = [UIColor clearColor];
    recipe.backgroundColor = [UIColor clearColor];
    shaker.backgroundColor = [UIColor clearColor];
    
    //Set UIButtons motion
    [recipe addTarget:self action:@selector(recipe:) forControlEvents:UIControlEventTouchUpInside ];
    [shaker addTarget:self action:@selector(shaker:) forControlEvents:UIControlEventTouchUpInside ];
    [setting addTarget:self action:@selector(setting:) forControlEvents:UIControlEventTouchUpInside ];
    
    //Show objects
    background.origin = CGPointZero;
    [self.view addSubview:background];
    [self.view addSubview:welcome];
    [self.view addSubview:recipe];
    [self.view addSubview:shaker];
    [self.view addSubview:setting];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//recipeButton motion
-(void)recipe:(UIButton*)button{
    RecipeTableViewController *nextView = [[RecipeTableViewController alloc] init];
    [self pushView:nextView pushViewstyle:kCATransitionFromRight popViewstyle:kCATransitionFromLeft HiddenHome:NO HiddenBack:NO];
}


//shakerButton motion
-(void)shaker:(UIButton*)button{
    ShakeViewController *nextView = [[ShakeViewController alloc] init];
    [self pushView:nextView pushViewstyle:kCATransitionFromLeft popViewstyle:kCATransitionFromRight HiddenHome:NO HiddenBack:NO];
}

//settingButton motion
-(void)setting:(UIButton*)button{
    SettingTableViewController *nextView = [[SettingTableViewController alloc] init];
    [self pushView:nextView pushViewstyle:kCATransitionFromTop popViewstyle:kCATransitionFromBottom HiddenHome:NO HiddenBack:NO];
}

- (void) pushView:(id)nextView
    pushViewstyle:(NSString *)pushAnimationType
     popViewstyle:(NSString *)popAnimationType
       HiddenHome:(BOOL)isHiddenHome
       HiddenBack:(BOOL)isHiddenBack{
    
    //Create animation
    CATransition* transition = [CATransition animation];
    transition.duration = 0.3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    transition.type = kCATransitionPush;
    transition.subtype = pushAnimationType;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    //Move View
    ParentViewController *nextParent = [[ParentViewController alloc] init];
    nextParent.viewController = nextView;
    nextParent.animationType = popAnimationType;
    nextParent.hiddenBack = isHiddenBack;
    nextParent.hiddenHome = isHiddenHome;
    [self.navigationController pushViewController:nextParent animated:NO];
    
}

@end
