//
//  ShakeViewController.m
//  MoodBlender_noStoryBoard
//
//  Created by altofwe on 13/08/22.
//  Copyright (c) 2013年 neko. All rights reserved.
//

#import "ShakeViewController.h"
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
    
    self.title = @"ShakeViewController";
    
    //initialize baseState
    baseState = nil;
    
    //Set background image
    UIImage *background_image = [UIImage imageNamed:@"background_1.png"];
    CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
    CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
    CGRect correctFrame = CGRectOffset(applicationFrame, 0, -CGRectGetHeight(statusBarFrame));
    UIImageView *background = [[UIImageView alloc] initWithFrame:correctFrame];
    background.contentMode = UIViewContentModeScaleAspectFill;
    background.image = background_image;
    
    //Create objects
    UIImage *shaker_image = [UIImage imageNamed:@"shaker.png"];
    UIImage *tap_message_image = [UIImage imageNamed:@"tap_it.png"];
    UIButton *shaker = [UIButton buttonWithType:UIButtonTypeCustom];
    gin = [UIButton buttonWithType:UIButtonTypeCustom];
    vodka = [UIButton buttonWithType:UIButtonTypeCustom];
    tap_message = [[UIImageView alloc] initWithImage:tap_message_image];
    
    //Set UIImageView aspectMode and Hidden
    tap_message.contentMode = UIViewContentModeScaleAspectFit;
    tap_message.hidden = YES;
    
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
    
    //Set UIButtons and UIImageView size
    shaker.frame = CGRectMake(0, 0, 150, 240);
    [gin sizeToFit];
    [vodka sizeToFit];
    gin.sizeH += 50;
    gin.sizeW += 50;
    vodka.sizeH += 50;
    vodka.sizeW += 50;
    tap_message.frame = CGRectMake(0, 0,  370, 370);
    
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
    
    //UIImageView 'shake!' move to chaker center
    tap_message.center = shaker.center;
    
    //Set objects backgroundColor clearly
    shaker.backgroundColor = [UIColor clearColor];
    gin.backgroundColor = [UIColor clearColor];
    vodka.backgroundColor = [UIColor clearColor];
    tap_message.backgroundColor = [UIColor clearColor];
    
    //Set UIButtons motion
    [shaker addTarget:self action:@selector(shaker:) forControlEvents:UIControlEventTouchUpInside ];
    [gin addTarget:self action:@selector(gin:) forControlEvents:UIControlEventTouchUpInside ];
    [vodka addTarget:self action:@selector(vodka:) forControlEvents:UIControlEventTouchUpInside ];
    
    //Show objects
    [self.view addSubview:background];
    [self.view addSubview:shaker];
    [self.view addSubview:gin];
    [self.view addSubview:vodka];
    [self.view addSubview:tap_message];
    
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
    
    //まだどのボタンも選択してなければ何もしない
    if (baseState == nil) return ;
    
    //Create and Setting animation pattern
    //MEMO:動きちょっとおかしくて前のようにしたいので、余裕があったら変更
    CATransition *transition = [CATransition animation];
    transition.duration = 0.4;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    transition.type = kCATransitionFade;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    ShakingViewController *next = [[ShakingViewController alloc] init];
    next.baseState = baseState;
    [self.navigationController pushViewController:next animated:YES];
}

//ginButton motion
-(void)gin:(UIButton*)tmp{
    baseState = @"gin";
    [gin setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [vodka setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    if (tap_message.hidden == YES){
        tap_message.hidden = NO;
    }
}

//vodkaButton motion
-(void)vodka:(UIButton*)tmp{
    baseState = @"vodka";
    [gin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [vodka setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    if (tap_message.hidden == YES){
        tap_message.hidden = NO;
    }
}

@end
