//
//  RecipeMenuViewController.m
//  MoodBlender_noStoryBoard
//
//  Created by altofwe on 13/08/29.
//  Copyright (c) 2013年 neko. All rights reserved.
//

#import "RecipeMenuViewController.h"
#import "UIView+UIView_MyExtention.h"

@interface RecipeMenuViewController ()

@end

@implementation RecipeMenuViewController

const int WIDTH_MARGIN = 30;
const int HEIGHT_MARGIN = 30;

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
    
    //self.title = @ "RecipeMenuViewController";
    
    //tmp
    UIButton *amazon = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIButton *mail = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIButton *twitter = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIButton *camera = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIButton *top = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    //Set UIButtons title
    [amazon setTitle:@"amazon" forState:UIControlStateNormal];
    [mail setTitle:@"mail" forState:UIControlStateNormal];
    [twitter setTitle:@"twitter" forState:UIControlStateNormal];
    [camera setTitle:@"camera" forState:UIControlStateNormal];
    [top setTitle:@"back to top" forState:UIControlStateNormal];
    
    //Set UIButtons size
    [amazon sizeToFit];
    [mail sizeToFit];
    [twitter sizeToFit];
    [camera sizeToFit];
    [top sizeToFit];
    
    //Set UIButtons potision
    const int LINE_HEIGHT = amazon.frame.size.height;
    int totalLabelWidth = WIDTH_MARGIN;
    int totalLabelHeight = self.view.frame.size.height - HEIGHT_MARGIN - LINE_HEIGHT;
    
    //line 2
    [camera setOrigin:CGPointMake(totalLabelWidth, totalLabelHeight)];
    totalLabelWidth += (camera.frame.size.width + WIDTH_MARGIN);
    [top setOrigin:CGPointMake(totalLabelWidth, totalLabelHeight)];
    totalLabelWidth = WIDTH_MARGIN;
    totalLabelHeight -= (HEIGHT_MARGIN + LINE_HEIGHT);
    
    //line 1
    [amazon setOrigin:CGPointMake(totalLabelWidth, totalLabelHeight)];
    totalLabelWidth += (amazon.frame.size.width + WIDTH_MARGIN);
    [mail setOrigin:CGPointMake(totalLabelWidth, totalLabelHeight)];
    totalLabelWidth += (mail.frame.size.width + WIDTH_MARGIN);
    [twitter setOrigin:CGPointMake(totalLabelWidth, totalLabelHeight)];
    totalLabelWidth += (twitter.frame.size.width + WIDTH_MARGIN);
    
    //Set UIButtons method
    [amazon addTarget:self action:@selector(amazon:) forControlEvents:UIControlEventTouchUpInside];
    [mail addTarget:self action:@selector(mail:) forControlEvents:UIControlEventTouchUpInside];
    [twitter addTarget:self action:@selector(twitter:) forControlEvents:UIControlEventTouchUpInside];
    [camera addTarget:self action:@selector(camera:) forControlEvents:UIControlEventTouchUpInside];
    [top addTarget:self action:@selector(top:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //Show UIButtons
    [self.view addSubview:amazon];
    [self.view addSubview:mail];
    [self.view addSubview:twitter];
    [self.view addSubview:camera];
    [self.view addSubview:top];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)amazon:(UIButton*)button{
    
}
- (void)mail:(UIButton*)button{
    
}
- (void)twitter:(UIButton*)button{
    
}
- (void)camera:(UIButton*)button{
    
}
- (void)top:(UIButton*)button{
    //tmp
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end
