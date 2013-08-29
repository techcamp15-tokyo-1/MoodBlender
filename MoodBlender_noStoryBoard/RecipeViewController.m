//
//  RecipeViewController.m
//  MoodBlender_noStoryBoard
//
//  Created by altofwe on 13/08/22.
//  Copyright (c) 2013年 neko. All rights reserved.
//

#import "RecipeViewController.h"
#import "UIView+UIView_MyExtention.h"

@interface RecipeViewController ()

@end

@implementation RecipeViewController

const int MARGIN = 20;
const int LABEL_HEIGHT = MARGIN;
const int FIXED = 2;
int total_label_height = MARGIN;

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
    
    self.title = @"RecipeViewController";
    
    //tmp
    NSString *indexPathString = [NSString stringWithFormat:@"%@", self.recipe_index];
    NSLog(@"index = %@", indexPathString);
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"state = %d", [userDefaults boolForKey:indexPathString]);
    
    // Do any additional setup after loading the view.
    
    //init total_label_height
    total_label_height = (MARGIN * FIXED);
    
    //Init Dictionarys
    path = [[NSBundle mainBundle] pathForResource:@"cocktail" ofType:@"plist"];
    dictionary = [NSDictionary dictionaryWithContentsOfFile:path];
    keys = [dictionary allKeys];
    
    //Create recipe
    NSString *key = [keys objectAtIndex:self.recipe_index.section];
    NSArray *cocktailbaseArray = [dictionary objectForKey:key];
    NSDictionary *recipe = [cocktailbaseArray objectAtIndex:self.recipe_index.row];
    
    //Set background image
    UIImage *background_image = [UIImage imageNamed:@"background_white.png"];
    CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
    CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
    CGRect correctFrame = CGRectOffset(applicationFrame, 0, -CGRectGetHeight(statusBarFrame));
    UIImageView *background = [[UIImageView alloc] initWithFrame:correctFrame];
    background.contentMode = UIViewContentModeScaleAspectFill;
    background.image = background_image;
    background.alpha = 0.6;
    
    //Get Recipe array data
    NSArray *materials = [recipe objectForKey:@"materials"];
    NSArray *amounts = [recipe objectForKey:@"amounts"];
    NSArray *processes = [recipe objectForKey:@"processes"];
    
    //ここからUILabel生成
    //heightを相対的に指定しているため、表示順に生成しないとずれる
    
    //Create and Setting recipe name text, size, font and position
    UILabel *name = [self createRecipeLabel:[recipe objectForKey:@"name"]];
    name.sizeW += 50;
    name.font = [UIFont boldSystemFontOfSize:[UIFont labelFontSize]];
    name.backgroundColor = [UIColor clearColor];
    name.textColor = [UIColor whiteColor];
    
    total_label_height += (LABEL_HEIGHT * FIXED);
    
    //Create materials and amounts UILabel
    //materialとamountが、対応しつつ交互に入る
    //materials.count == amounts.countが前提であるため、そうでない場合に配列外参照が起こる
    //とりあえずtrycatchで、アプリが落ちることだけ回避しておく
    NSMutableArray *materialAndAmount_labels = [NSMutableArray array];
    @try{
        for(int i = 0; i < materials.count; ++i){
            //Create UILabels text
            NSString *material =[materials objectAtIndex:i];
            NSString *amount =[amounts objectAtIndex:i];
            
            //Create UILabel
            UILabel *material_label = [self createRecipeLabel:material];
            UILabel *amount_label = [self createRecipeLabel:amount];
            //[amount_label setOriginX:CGFloat(self.view.frame.size.width - amount_label.frame.size.width + MARGIN)];
            [amount_label setOriginX:(self.view.frame.size.width - amount_label.frame.size.width - MARGIN)];
            
            //Set UILabels backgroundColor clearly
            material_label.backgroundColor = [UIColor clearColor];
            amount_label.backgroundColor = [UIColor clearColor];
            
            //Set UILabels textColor
            material_label.textColor = [UIColor whiteColor];
            amount_label.textColor = [UIColor whiteColor];
            
            //Add to NSMutableArray
            [materialAndAmount_labels addObject:material_label];
            [materialAndAmount_labels addObject:amount_label];
            
        }
    }
    @catch (NSException *exception) {
        NSLog(@"materialとamountの数が合っていないデータが存在します");
    }
    
    total_label_height += (LABEL_HEIGHT * FIXED);
    
    //Create ans Setting processes TextView
    UITextView *process_textView = [[UITextView alloc] initWithFrame:CGRectMake(MARGIN, total_label_height, self.view.frame.size.width - (MARGIN * 2), self .view.frame.size.height - total_label_height - MARGIN)];
    process_textView.editable = NO;
    process_textView.font = [UIFont fontWithName:@"Helvetica" size:14];
    process_textView.backgroundColor = [UIColor whiteColor];
    [process_textView setOrigin:CGPointMake(0, 0)];
    [process_textView setOrigin:CGPointMake(MARGIN, total_label_height)];
    process_textView.backgroundColor = [UIColor clearColor];
    process_textView.textColor = [UIColor whiteColor];
    process_textView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    
    process_textView.text = @"";
    for(int i = 0; i < processes.count; ++i) {
        
        //Create UILabel text and UILabel
        NSString *process = [NSString stringWithFormat:@"%d. %@", i + 1, [processes objectAtIndex:i]];
        process_textView.text = [process_textView.text stringByAppendingFormat:@"%@\n", process];
    }
    
    //Show objects
    [self.view addSubview:background];
    [self.view addSubview:name];
    for(int i = 0; i < materialAndAmount_labels.count; ++i){
        [self.view addSubview:[materialAndAmount_labels objectAtIndex:i]];
    }
    [self.view addSubview:process_textView];
    
    //Flash scroll bar
    [process_textView flashScrollIndicators];
    
    //Create swipeRecognizer(up) and set motion
    UISwipeGestureRecognizer *swipeUpGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(selSwipeUpGesture:)];
    swipeUpGesture.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:swipeUpGesture];
    
    //Create swipeRecognizer(right) and set motion
    UISwipeGestureRecognizer *swipeRightGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(selSwipeRightGesture:)];
    swipeRightGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRightGesture];
    
    //tmp
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(10, 10, 100, 30);
    [btn setTitle:@"押してね" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(hoge:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:btn];
}

//tmp
// ボタンがタッチダウンされた時にhogeメソッドを呼び出す
-(void)hoge:(UIButton*)button{
    StartViewController *nextView = [[StartViewController alloc] init];
    nextView.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:nextView animated:YES completion:^{}];
}

//Swipe(right) motion
- (void)selSwipeRightGesture:(UISwipeGestureRecognizer *)sender {
    if ([self.prevView isEqual:@"RecipeTableViewController"])
        [self.navigationController popViewControllerAnimated:YES];
}

//Swipe(up) motion
- (void)selSwipeUpGesture:(UISwipeGestureRecognizer *)sender {
    RecipeMenuViewController *next = [[RecipeMenuViewController alloc] init];
    next.modalTransitionStyle = UIModalTransitionStylePartialCurl;
    [self presentViewController:next animated:YES completion:^ {}];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

//Create UILabel and Setting test, position and font
- (UILabel*)createRecipeLabel:(NSString*)text{
    UILabel *label= [[UILabel alloc] init];
    label.text = text;
    label.frame = CGRectMake(MARGIN, total_label_height, self.view.frame.size.width - (MARGIN * 2), 50);
    label.font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 0;
    [label sizeToFit];
    total_label_height += label.frame.size.height;
    
    return label;
}

@end
