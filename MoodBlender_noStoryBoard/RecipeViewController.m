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

const int RECIPE_MARGIN = 20;
const int LABEL_HEIGHT = RECIPE_MARGIN;
const int FIXED = 1;
int totalLabelHeight = RECIPE_MARGIN;
const NSInteger TagAlert1 = 1;
const NSInteger TagAlert2 = 2;
BOOL isFreeText =  NO;

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
    
    //self.title = @"RecipeViewController";
    
    //tmp
    //NSString *indexPathString = [NSString stringWithFormat:@"%d:%d", self.recipeIndex.section, self.recipeIndex.row];
    //NSLog(@"index = %@", indexPathString);
    //NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //NSLog(@"state = %d", [userDefaults boolForKey:indexPathString]);
    
    // Do any additional setup after loading the view.
    
    //init totalLabelHeight
    totalLabelHeight = (RECIPE_MARGIN * FIXED);
    
    //Init Dictionarys
    path = [[NSBundle mainBundle] pathForResource:@"cocktail" ofType:@"plist"];
    dictionary = [NSDictionary dictionaryWithContentsOfFile:path];
    keys = [dictionary allKeys];
    
    //Create recipe
    NSString *key = [keys objectAtIndex:self.recipeIndex.section];
    NSArray *cocktailbaseArray = [dictionary objectForKey:key];
    NSDictionary *recipe = [cocktailbaseArray objectAtIndex:self.recipeIndex.row];
    
    //Set background image
    UIImage *backgroundImage = [UIImage imageNamed:@"backgroundWhite.png"];
    CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
    CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
    CGRect correctFrame = CGRectOffset(applicationFrame, 0, -CGRectGetHeight(statusBarFrame));
    UIImageView *background = [[UIImageView alloc] initWithFrame:correctFrame];
    background.contentMode = UIViewContentModeScaleAspectFill;
    background.image = backgroundImage;
    background.alpha = 0.6;
    
    //Create and Setting UIButton
    UIImage *mailImage = [UIImage imageNamed:@"mail.png"];
    UIButton *mail = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 50, self.view.frame.size.height - 90, 50, 50)];
    [mail setImage:mailImage forState:UIControlStateNormal];
    [mail addTarget:self action:@selector(mail:) forControlEvents:UIControlEventTouchUpInside ];
    
    //Get Recipe array data
    NSArray *materials = [recipe objectForKey:@"materials"];
    NSArray *amounts = [recipe objectForKey:@"amounts"];
    NSArray *processes = [recipe objectForKey:@"processes"];
    
    //ここからUILabel生成
    //heightを相対的に指定しているため、表示順に生成しないとずれる
    
    //Create and Setting recipe name text, size, font and position
    UILabel *name = [self createRecipeLabel:[recipe objectForKey:@"name"]];
    [name setOrigin:CGPointMake(LABEL_HEIGHT, LABEL_HEIGHT)];
    name.sizeW += 50;
    name.font = [UIFont boldSystemFontOfSize:[UIFont labelFontSize]];
    name.backgroundColor = [UIColor clearColor];
    name.textColor = [UIColor whiteColor];
    
    totalLabelHeight += (LABEL_HEIGHT * FIXED);
    
    //Create materials and amounts UILabel
    //materialとamountが、対応しつつ交互に入る
    //materials.count == amounts.countが前提であるため、そうでない場合に配列外参照が起こる
    //とりあえずtrycatchで、アプリが落ちることだけ回避しておく
    NSMutableArray *materialAndAmountLabels = [NSMutableArray array];
    @try{
        for(int i = 0; i < materials.count; ++i){
            //Create UILabels text
            NSString *material =[materials objectAtIndex:i];
            NSString *amount =[amounts objectAtIndex:i];
            
            //Create UILabel
            UILabel *materialLabel = [self createRecipeLabel:material];
            UILabel *amountLabel = [self createRecipeLabel:amount];
            [amountLabel setOriginX:(self.view.frame.size.width - amountLabel.frame.size.width - RECIPE_MARGIN)];
            
            //Set UILabels backgroundColor clearly
            materialLabel.backgroundColor = [UIColor clearColor];
            amountLabel.backgroundColor = [UIColor clearColor];
            
            //Set UILabels textColor
            materialLabel.textColor = [UIColor whiteColor];
            amountLabel.textColor = [UIColor whiteColor];
            
            //Add to NSMutableArray
            [materialAndAmountLabels addObject:materialLabel];
            [materialAndAmountLabels addObject:amountLabel];
            
        }
    }
    @catch (NSException *exception) {
        NSLog(@"materialとamountの数が合っていないデータが存在します");
    }
    
    totalLabelHeight += (LABEL_HEIGHT * FIXED);
    
    //Create ans Setting processes TextView
    UITextView *processTextView = [[UITextView alloc] initWithFrame:CGRectMake(RECIPE_MARGIN, totalLabelHeight - (RECIPE_MARGIN * 5), self.view.frame.size.width - (RECIPE_MARGIN * 2), self .view.frame.size.height - totalLabelHeight - (RECIPE_MARGIN * 5))];
    processTextView.editable = NO;
    processTextView.font = [UIFont fontWithName:@"Helvetica" size:14];
    processTextView.backgroundColor = [UIColor whiteColor];
    [processTextView setOrigin:CGPointMake(0, 0)];
    [processTextView setOrigin:CGPointMake(RECIPE_MARGIN, totalLabelHeight)];
    processTextView.backgroundColor = [UIColor clearColor];
    processTextView.textColor = [UIColor whiteColor];
    processTextView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    
    processTextView.text = @"";
    for(int i = 0; i < processes.count; ++i) {
        
        //Create UILabel text and UILabel
        NSString *process = [NSString stringWithFormat:@"%d. %@", i + 1, [processes objectAtIndex:i]];
        processTextView.text = [processTextView.text stringByAppendingFormat:@"%@\n", process];
    }
    
    //Show objects
    [self.view addSubview:background];
    [self.view addSubview:name];
    for(int i = 0; i < materialAndAmountLabels.count; ++i){
        [self.view addSubview:[materialAndAmountLabels objectAtIndex:i]];
    }
    [self.view addSubview:processTextView];
    [self.view addSubview:mail];
    
    //Flash scroll bar
    [processTextView flashScrollIndicators];
    
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
    label.frame = CGRectMake(RECIPE_MARGIN, totalLabelHeight, self.view.frame.size.width - (RECIPE_MARGIN * 2), 50);
    label.font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 0;
    [label sizeToFit];
    totalLabelHeight += label.frame.size.height;
    
    return label;
}

- (void)mail:(UIButton*)button{
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:@"今の気持ちを入力しよう♡"
                              message:@" "
                              delegate:self
                              cancelButtonTitle:@"何も言いたくない"
                              otherButtonTitles:@"酔いたいの♡",@"作ってるとこかっこいいね",@"その他に言いたい！",nil
                              
                              ];
    alertView.tag=TagAlert1;
    [alertView show];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag==TagAlert1) {
        switch (buttonIndex) {
            case 1: // Button1が押されたとき
                NSLog(@"Button1");
                str=@"酔いたいの♡";
                break;
                
                
            case 2: // Button2が押されたとき
                NSLog(@"Button2");
                str=@"作ってるところかっこいいね";
                break;
                
            case 3: // Button2が押されたとき
                NSLog(@"Button3");
                
                break;
                
            default: // キャンセルが押されたとき
                NSLog(@"Cancel");
                break;
        }
        UIAlertView *alertView2;
        NSString *aStr = [NSString stringWithFormat:@"選択したのは「%@」でいいでしょうか？",str];
        if(buttonIndex==1||buttonIndex==2){
            alertView2 = [[UIAlertView alloc]
                          initWithTitle:@"確認"
                          message:aStr delegate:self
                          cancelButtonTitle:@"やっぱりなし！"
                          otherButtonTitles:@"OK！",nil
                          ];
            alertView2.tag=TagAlert2;
            isFreeText=YES;
            [alertView2 show];
        }else if (buttonIndex==3){
            alertView2 = [[UIAlertView alloc]
                          initWithTitle:@"すきなことを書いてね"
                          message:@" " delegate:self
                          cancelButtonTitle:@"やっぱりなし！"
                          otherButtonTitles:@"OK！",nil
                          ];
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(12, 45, 260, 25)];
            textField.borderStyle = UITextBorderStyleRoundedRect;
            textField.font = [UIFont fontWithName:@"Arial-BoldMT" size:18];
            textField.textColor = [UIColor grayColor];
            textField.minimumFontSize = 8;
            textField.placeholder = @"自由に入力できるよ";
            textField.adjustsFontSizeToFitWidth = YES;
            textField.clearButtonMode = UITextFieldViewModeWhileEditing;
            [alertView2 addSubview:textField];
            alertView2.tag=TagAlert2;
            [alertView2 show];
            
        }
    }else if (alertView.tag==TagAlert2){
        switch (buttonIndex) {
            case 1: { // Button1が押されたとき
                UITextField *textField = nil;
                for(UIView *view in alertView.subviews) {
                    if(![view isKindOfClass:[UITextField class]])
                        continue;
                    textField = (UITextField *)view;
                    break;
                }
                if (isFreeText==NO) {
                    
                    str=textField.text;
                }
                
                [self CreateMail:str];
                break;
            }
        }
    }
}

//メールの作成
-(void) CreateMail:(NSString *) sendStr{
    
    MFMailComposeViewController *mailcompose = [[MFMailComposeViewController alloc] init];
    //mailcompose.delegate = [self.childViewControllers objectAtIndex:0];
    mailcompose.delegate = self.parentViewController.navigationController.delegate;
    
    //tmp
    //NSLog(@"%@", self.parentViewController.navigationController.delegate);
    //NSLog(@"%@", sendStr);
    
    //各設定（設定しない場合空欄となるだけです）
    //メール本文の設定
    [mailcompose setMessageBody:str isHTML:NO];
    
    //題名の設定
    [mailcompose setSubject:@"Bar:MoodBlender"];
    
    //宛先の設定
    [mailcompose setToRecipients:[NSArray arrayWithObjects:@"aaa@yyy.zzz", nil]];
    
    //メール送信用のモーダルビューの表示
    [self presentViewController:mailcompose animated:YES completion:nil];
    
}


//メール送信処理完了時の処理（あった方が無難）
- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error {
    
    switch (result){
        case MFMailComposeResultCancelled:  //キャンセル
            break;
        case MFMailComposeResultSaved:      //保存
            break;
        case MFMailComposeResultSent:       //送信成功
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"送信しました"
                                                           delegate:nil
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"OK", nil];
            [alert show];
            break;
        }
        case MFMailComposeResultFailed:     //送信失敗
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"送信が失敗しました"
                                                           delegate:nil
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"OK", nil];
            [alert show];
            break;
        }
        default:
            break;
    }
    
    [self dismissModalViewControllerAnimated:YES];
}


@end
