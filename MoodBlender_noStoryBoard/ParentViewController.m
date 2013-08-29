//
//  ParentViewController.m
//  MoodBlender_noStoryBoard
//
//  Created by altofwe on 13/08/30.
//  Copyright (c) 2013年 neko. All rights reserved.
//

#import "ParentViewController.h"

@interface ParentViewController ()

@end

@implementation ParentViewController

const int HEADER_HEIGHT = 40;

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
    
    //tmp
    NSLog(@"back = %d", self.hiddenBack);
    NSLog(@"home = %d", self.hiddenHome);
    
    //Create objects
    UIViewController *headerController = [[UIViewController alloc] init];
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, HEADER_HEIGHT)];
    StartViewController *rootView = self.viewController;
    
    UIImage *homeImage = [UIImage imageNamed:@"home.png"];
    UIImage *backImage = [UIImage imageNamed:@"back.png"];
    UIButton *home = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - HEADER_HEIGHT, 0, HEADER_HEIGHT, HEADER_HEIGHT)];
    UIButton *back = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, HEADER_HEIGHT, HEADER_HEIGHT)];
    
    //Set UIImageViews image
    [home setImage:homeImage forState:UIControlStateNormal];
    [back setImage:backImage forState:UIControlStateNormal];
    
    //Set header view
    headerController.view = header;
    
    //Set viewControllers height
    //CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
    rootView.view.frame = CGRectMake(0, HEADER_HEIGHT, self.view.frame.size.width, self.view.frame.size.height);
    
    //Set header background image
    header.backgroundColor = [UIColor blackColor];
    
    //Set UIButtons motion
    [home addTarget:self action:@selector(home:) forControlEvents:UIControlEventTouchUpInside];
    [back addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    //Add childViews to parent controller
    [self addChildViewController:rootView];
    [self addChildViewController:headerController];
    
    //tmp
    back.hidden = self.hiddenBack;
    home.hidden = self.hiddenHome;
    
    //Show objects
    [self.view addSubview:rootView.view];
    [self.view addSubview:headerController.view];
    [headerController.view addSubview:home];
    [headerController.view addSubview:back];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)home:(UIButton *)button{
    
    //Create animation
    CATransition* transition = [CATransition animation];
    transition.duration = 0.3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    transition.type = kCATransitionPush;
    transition.subtype = self.animationType;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    if(self.createNewPage){
        ParentViewController *rootViewController = [[ParentViewController alloc] init];
        StartViewController *firstViewController = [[StartViewController alloc] init];
        rootViewController.viewController = firstViewController;
        rootViewController.hiddenBack = YES;
        rootViewController.hiddenHome = YES;
        [self.navigationController pushViewController:rootViewController animated:NO];
    } else{
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
}

- (void)back:(UIButton *)button{
    
    //Create animation
    CATransition* transition = [CATransition animation];
    transition.duration = 0.3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    transition.type = kCATransitionPush;
    transition.subtype = self.animationType;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    [self.navigationController popViewControllerAnimated:NO];
}

@end
