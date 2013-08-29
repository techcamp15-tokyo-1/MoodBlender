//
//  ParentRecipeViewController.m
//  MoodBlender_noStoryBoard
//
//  Created by altofwe on 13/08/30.
//  Copyright (c) 2013年 neko. All rights reserved.
//

#import "ParentRecipeViewController.h"
#import "UIView+UIView_MyExtention.h"

@interface ParentRecipeViewController ()

@end

@implementation ParentRecipeViewController

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
    
    //Create objects
    RecipeTableViewController *recipeTable = [[RecipeTableViewController alloc] init];
    UIViewController *headerController = [[UIViewController alloc] init];
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, HEADER_HEIGHT)];
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
    CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
    recipeTable.view.frame = CGRectMake(0, -CGRectGetHeight(statusBarFrame) + 10, self.view.frame.size.width, self.view.frame.size.height);
    
    //Set header background image
    header.backgroundColor = [UIColor blackColor];
    
    //Set UIButtons motion
    [home addTarget:self action:@selector(home:) forControlEvents:UIControlEventTouchUpInside];
    [back addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    //Add childViews to parent controller
    [self addChildViewController:recipeTable];
    [self addChildViewController:headerController];
    
    //Show objects
    [self.view addSubview:recipeTable.view];
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
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)back:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
