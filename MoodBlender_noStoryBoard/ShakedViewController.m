//
//  ShakedViewController.m
//  MoodBlender_noStoryBoard
//
//  Created by altofwe on 13/08/23.
//  Copyright (c) 2013年 neko. All rights reserved.
//

#import "ShakedViewController.h"
#import "StartViewController.h"
#import "UIView+UIView_MyExtention.h"

@interface ShakedViewController ()

@end

@implementation ShakedViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //Set background image
    UIImage *background_image = [UIImage imageNamed:@"background_white.png"];
    CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
    CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
    CGRect correctFrame = CGRectOffset(applicationFrame, 0, -CGRectGetHeight(statusBarFrame));
    UIImageView *background = [[UIImageView alloc] initWithFrame:correctFrame];
    background.contentMode = UIViewContentModeScaleAspectFill;
    background.image = background_image;
    
    //Create objects
    UILabel *tmpRecipeBig = [[UILabel alloc] init];
    UILabel *tmpRecipeNormal = [[UILabel alloc] init];
    
    //Set UILabels text
    tmpRecipeBig.text = @"Sake";
    tmpRecipeNormal.text = @"salmon ... 1\nsalt ... 1";
    
    //Set UILabels size and number of row
    [tmpRecipeBig sizeToFit];
    tmpRecipeBig.sizeW += 20;
    tmpRecipeNormal.numberOfLines = 2;
    [tmpRecipeNormal sizeToFit];
    
    //Set UILabels font
    tmpRecipeBig.font = [UIFont boldSystemFontOfSize:[UIFont buttonFontSize]];
    tmpRecipeNormal.font = [UIFont systemFontOfSize:[UIFont labelFontSize]];
    
    //Set UILabels background color
    tmpRecipeBig.backgroundColor = [UIColor blackColor];
    tmpRecipeNormal.backgroundColor = [UIColor blackColor];
    
    //Set UILabels font color
    tmpRecipeBig.textColor = [UIColor whiteColor];
    tmpRecipeNormal.textColor = [UIColor whiteColor];
    
    //Move UILabels
    [tmpRecipeBig setOrigin:CGPointMake(30, 20)];
    [tmpRecipeNormal setOrigin:CGPointMake(30, 60)];
    
    //(!!!tmp!!!) Create restart button and setting
    UIButton *restart = [UIButton buttonWithType:UIButtonTypeCustom];
    restart.frame = CGRectMake(self.view.frame.size.width - 110, 10, 100, 100);
    restart.backgroundColor = [UIColor clearColor];
    [restart addTarget:self action:@selector(restart:) forControlEvents:UIControlEventTouchUpInside ];
    
    //Show objects
    [self.view addSubview:background];
    [self.view addSubview:tmpRecipeBig];
    [self.view addSubview:tmpRecipeNormal];
    [self.view addSubview:restart];
    
    //Create swipeRecognizer(up) and set motion
    UISwipeGestureRecognizer* swipeUpGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(selSwipeUpGesture:)];
    swipeUpGesture.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:swipeUpGesture];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Swipe(up) motion
- (void)selSwipeUpGesture:(UISwipeGestureRecognizer *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//ginButton motion
-(void)restart:(UIButton*)restart{
    StartViewController *nextView = [[StartViewController alloc] init];
    nextView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:nextView animated:YES completion:^{}];
}

@end
