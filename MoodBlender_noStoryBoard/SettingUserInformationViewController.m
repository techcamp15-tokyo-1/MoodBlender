//
//  SettingUserInformationViewController.m
//  MoodBlender_noStoryBoard
//
//  Created by altofwe on 13/08/29.
//  Copyright (c) 2013年 neko. All rights reserved.
//

#import "SettingUserInformationViewController.h"
#import "UIView+UIView_MyExtention.h"

@interface SettingUserInformationViewController ()

@end

@implementation SettingUserInformationViewController

const int SETTING_MARGIN = 20;

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
    
    //self.title = @"SettingUserInformation";
    
    //Set background image
    //self.view.backgroundColor = [UIColor blackColor];
    //UIImage *backgroundImage = [UIImage imageNamed:@"background1.png"];
    //UIImageView *background = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    //background.contentMode = UIViewContentModeScaleAspectFit;
    //background.image = backgroundImage;
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
    UITextView *information = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - (SETTING_MARGIN * 2), self.view.frame.size.height / 3)];
    email = [[UITextField alloc]initWithFrame:CGRectMake(10, 100, 200, 25)];
    UIButton *submit = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    //Set objects text or placeholder
    information.text = @"\nメールアドレスの入力をしてください。\nカクテル完成時にメッセージの送信やまめ知識などをお届けします。";
    email.placeholder = @"メールアドレスを入力してください";
    [submit setTitle:@"アドレス登録" forState:UIControlStateNormal];
    
    //Set objects text font
    information.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
    
    //Set objects background color
    information.backgroundColor = [UIColor clearColor];
    
    //Set objects text color
    information.textColor=[UIColor whiteColor];
    
    //Set objects some style
    information.editable = NO;
    information.opaque = NO;
    email.borderStyle = UITextBorderStyleRoundedRect;
    email.keyboardType = UIKeyboardTypeEmailAddress;
    email.returnKeyType = UIReturnKeyDone;
    email.clearButtonMode = UITextFieldViewModeWhileEditing;
    email.delegate = self;
    
    //Set objects size
    [submit sizeToFit];
    
    //Set objects position center
    information.center = self.view.center;
    email.center = self.view.center;
    submit.center = self.view.center;
    
    //Set object position
    [information setOriginY:information.frame.origin.y - email.frame.size.height - SETTING_MARGIN];
    [submit setOriginY:submit.frame.origin.y + submit.frame.size.height + SETTING_MARGIN];
    
    //set objects motion
    [submit addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    
    //Show objects
    [self.view addSubview:background];
    [self.view addSubview:information];
    [self.view addSubview:email];
    [self.view addSubview:submit];
}

- (BOOL)textFieldShouldReturn:(UITextField*)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)submit:(UIButton*)button{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:email.text forKey:@"emailAdress"];
    [userDefaults synchronize];

    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"設定しました"
                          message:@""
                          delegate:nil
                          cancelButtonTitle:nil
                          otherButtonTitles:@"OK",
                          nil
    ];
    [alert show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
