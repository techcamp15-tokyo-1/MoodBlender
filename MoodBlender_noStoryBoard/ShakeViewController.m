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
    
    //self.title = @"ShakeViewController";
    
    //initialize baseState
    baseState = nil;
    
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
    
    //Create objects
    UIImage *shakerImage = [UIImage imageNamed:@"shaker.png"];
    UIImage *tapMessageImage = [UIImage imageNamed:@"tapIt.png"];
    UIButton *shaker = [UIButton buttonWithType:UIButtonTypeCustom];
    gin = [UIButton buttonWithType:UIButtonTypeCustom];
    vodka = [UIButton buttonWithType:UIButtonTypeCustom];
    tapMessage = [[UIImageView alloc] initWithImage:tapMessageImage];
    
    //Set UIImageView aspectMode and Hidden
    tapMessage.contentMode = UIViewContentModeScaleAspectFit;
    tapMessage.hidden = YES;
    
    //Set UIButtons text or image
    [gin setTitle:@"gin" forState:UIControlStateNormal];
    [vodka setTitle:@"vodka" forState:UIControlStateNormal];
    [shaker setBackgroundImage:shakerImage forState:UIControlStateNormal];
    
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
    tapMessage.frame = CGRectMake(0, 0,  370, 370);
    
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
    tapMessage.center = shaker.center;
    
    //Set objects backgroundColor clearly
    shaker.backgroundColor = [UIColor clearColor];
    gin.backgroundColor = [UIColor clearColor];
    vodka.backgroundColor = [UIColor clearColor];
    tapMessage.backgroundColor = [UIColor clearColor];
    
    //Set UIButtons motion
    [shaker addTarget:self action:@selector(shaker:) forControlEvents:UIControlEventTouchUpInside ];
    [gin addTarget:self action:@selector(gin:) forControlEvents:UIControlEventTouchUpInside ];
    [vodka addTarget:self action:@selector(vodka:) forControlEvents:UIControlEventTouchUpInside ];
    
    //Show objects
    [self.view addSubview:background];
    [self.view addSubview:shaker];
    [self.view addSubview:gin];
    [self.view addSubview:vodka];
    [self.view addSubview:tapMessage];
    
    //Create swipeRecognizer(left) and set motion
    UISwipeGestureRecognizer* swipeLeftGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(selSwipeLeftGesture:)];
    swipeLeftGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeftGesture];
}

//Swipe(left) motion
- (void)selSwipeLeftGesture:(UISwipeGestureRecognizer *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//ginButton motion
-(void)shaker:(UIButton*)button{
    
    //まだどのボタンも選択してなければ何もしない
    if (baseState == nil) return ;
    
    //Create and Setting animation pattern
    CATransition *transition = [CATransition animation];
    transition.duration = 0.2;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    transition.type = kCATransitionFade;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    //Move View
    ParentViewController *nextParent = [[ParentViewController alloc] init];
    ShakingViewController *nextView = [[ShakingViewController alloc] init];
    nextView.baseState = baseState;
    nextParent.viewController = nextView;
    nextParent.animationType = kCATransitionFromTop;
    nextParent.hiddenBack = YES;
    nextParent.hiddenHome = YES;
    nextParent.createNewPage = YES;
    [self.navigationController pushViewController:nextParent animated:NO];
}

//ginButton motion
-(void)gin:(UIButton*)button{
    baseState = @"gin";
    [gin setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [vodka setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    if (tapMessage.hidden == YES){
        tapMessage.hidden = NO;
    }
}

//vodkaButton motion
-(void)vodka:(UIButton*)button{
    baseState = @"vodka";
    [gin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [vodka setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    if (tapMessage.hidden == YES){
        tapMessage.hidden = NO;
    }
}

@end
