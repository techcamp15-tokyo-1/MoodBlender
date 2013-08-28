//
//  ShakeViewController.m
//  MoodBlender_noStoryBoard
//
//  Created by altofwe on 13/08/22.
//  Copyright (c) 2013年 neko. All rights reserved.
//

#import "ShakeViewController.h"
#import "ShakingViewController.h"
#import "StartViewController.h"
#import "UIView+UIView_MyExtention.h"

@interface ShakeViewController ()

@end

@implementation ShakeViewController

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
    
    //initialize state
    state = nil;
    
    //Set background image
    self.view.backgroundColor = [UIColor blackColor];
    UIImage *background_image = [UIImage imageNamed:@"background_1.png"];
    UIImageView *background = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    background.contentMode = UIViewContentModeScaleAspectFit;
    background.image = background_image;
    
    //Create objects
    UIImage *shaker_image = [UIImage imageNamed:@"shaker.png"];
    UIButton *shaker = [UIButton buttonWithType:UIButtonTypeCustom];
    gin = [UIButton buttonWithType:UIButtonTypeCustom];
    vodka = [UIButton buttonWithType:UIButtonTypeCustom];
    
    //Set UIButtons text or image
    [gin setTitle:@"gin" forState:UIControlStateNormal];
    [vodka setTitle:@"vodka" forState:UIControlStateNormal];
    [shaker setBackgroundImage:shaker_image forState:UIControlStateNormal];
    
    //Set UIButtons font
    gin.titleLabel.font = [UIFont fontWithName:@"DBLCDTempBlack" size:15];
    vodka.titleLabel.font = [UIFont fontWithName:@"DBLCDTempBlack" size:15];
    
    //Set UIButtons color
    [gin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [vodka setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    //Set UIButtons background color
    shaker.backgroundColor = [UIColor blackColor];
    gin.backgroundColor = [UIColor blackColor];
    vodka.backgroundColor = [UIColor blackColor];
    
    //Set UIButtons shadow
    gin.titleLabel.shadowOffset = CGSizeMake(1, 1);
    vodka.titleLabel.shadowOffset = CGSizeMake(1, 1);
    
    //Set UIButtons size
    shaker.frame = CGRectMake(0, 0, 150, 240);
    [gin sizeToFit];
    [vodka sizeToFit];
    gin.sizeH += 50;
    gin.sizeW += 50;
    vodka.sizeH += 50;
    vodka.sizeW += 50;
    
    //Move objects to center
    shaker.center = self.view.center;
    gin.center = self.view.center;
    vodka.center = self.view.center;
    
    //Move UIImageViews
    shaker.centerY -= 30;
    gin.centerY += 150;
    gin.centerX += 50;
    vodka.centerY += 150;
    vodka.centerX -= 50;
    
    //Set UIImage backgroundColor clearly
    shaker.backgroundColor = [UIColor clearColor];
    gin.backgroundColor = [UIColor clearColor];
    vodka.backgroundColor = [UIColor clearColor];
    
    //Set UIButtons motion
    [shaker addTarget:self action:@selector(shaker:) forControlEvents:UIControlEventTouchUpInside ];
    [gin addTarget:self action:@selector(gin:) forControlEvents:UIControlEventTouchUpInside ];
    [vodka addTarget:self action:@selector(vodka:) forControlEvents:UIControlEventTouchUpInside ];
    
    //Show objects
    [self.view addSubview:background];
    [self.view addSubview:shaker];
    [self.view addSubview:gin];
    [self.view addSubview:vodka];
    
    //Create swipeRecognizer(left) and set motion
    UISwipeGestureRecognizer* swipeLeftGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(selSwipeLeftGesture:)];
    swipeLeftGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeftGesture];
}

- (void)selSwipeLeftGesture:(UISwipeGestureRecognizer *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//Swipe(left) motion
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//ginButton motion
-(void)shaker:(UIButton*)shaker{
    if (state != nil) {
        ShakingViewController *nextView = [[ShakingViewController alloc] init];
        nextView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:nextView animated:YES completion:^{}];
    }
}

//ginButton motion
-(void)gin:(UIButton*)tmp{
    state = @"gin";
    [gin setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [vodka setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

//vodkaButton motion
-(void)vodka:(UIButton*)tmp{
    state = @"vodka";
    [gin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [vodka setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
}

@end
