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
const int FIXED = 1;
int total_label_height = MARGIN;
//const int LABEL_HEIGHT = 21;

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
    
    //init total_label_height
    total_label_height = MARGIN;
    
    //Set background image
    //UIImage *background_image = [UIImage imageNamed:@"background.png"];
    //UIImageView *background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    //background.image = background_image;
    
    
    ////(!!!!!!!!!!tmp!!!!!!!!!)
    self.view.backgroundColor = [UIColor whiteColor];
    
    //Get Recipe array data
    NSArray *materials = [self.recipe objectForKey:@"materials"];
    NSArray *amounts = [self.recipe objectForKey:@"amounts"];
    NSArray *processes = [self.recipe objectForKey:@"processes"];
    
    //ここからUILabel生成
    //heightを相対的に指定しているため、表示順に生成しないとずれる
    
    //Create and Setting recipe name text, size, font and position
    UILabel *name = [self createRecipeLabel:[self.recipe objectForKey:@"name"]];
    name.sizeW += 50;
    name.font = [UIFont boldSystemFontOfSize:[UIFont labelFontSize]];
    
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
    process_textView.text = @"";
    for(int i = 0; i < processes.count; ++i) {
        
        //Create UILabel text and UILabel
        NSString *process = [NSString stringWithFormat:@"%d. %@", i + 1, [processes objectAtIndex:i]];
        process_textView.text = [process_textView.text stringByAppendingFormat:@"%@\n", process];
    }
    
    //Show objects
    //[self.view addSubview:background];
    [self.view addSubview:name];
    for(int i = 0; i < materialAndAmount_labels.count; ++i){
        [self.view addSubview:[materialAndAmount_labels objectAtIndex:i]];
    }
    [self.view addSubview:process_textView];
    
    //Flash scroll bar
    [process_textView flashScrollIndicators];
    
    //Create swipeRecognizer(right) and set motion
    UISwipeGestureRecognizer* swipeRightGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(selSwipeRightGesture:)];
    swipeRightGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRightGesture];
    
}

//Swipe(right) motion
- (void)selSwipeRightGesture:(UISwipeGestureRecognizer *)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
    
    //tmp
    label.textColor = [UIColor blackColor];
    
    return label;
}

@end
