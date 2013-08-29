//
//  SettingUserInformationViewController.m
//  MoodBlender_noStoryBoard
//
//  Created by altofwe on 13/08/29.
//  Copyright (c) 2013年 neko. All rights reserved.
//

#import "SettingUserInformationViewController.h"

@interface SettingUserInformationViewController ()

@end

@implementation SettingUserInformationViewController

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
    
    //Set background image
    self.view.backgroundColor = [UIColor blackColor];
    UIImage *background_image = [UIImage imageNamed:@"background_1.png"];
    UIImageView *background = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    background.contentMode = UIViewContentModeScaleAspectFit;
    background.image = background_image;
    
    // UITextViewのインスタンス化
    CGRect rect = self.view.bounds;
    UITextView *textView = [[UITextView alloc]initWithFrame:rect];
    // テキストの編集を不可にする
    textView.editable = NO;
    // テキストのフォントを設定
    textView.font = [UIFont fontWithName:@"Helvetica" size:14];
    //　テキストfontclor
    textView.textColor=[UIColor whiteColor];
    //背景色透過許可
    textView.opaque=NO;
    // テキストの背景色を設定
    textView.backgroundColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:0.3f];
    textView.text = @"\nメールアドレスの入力をしてください。\nカクテル完成時にメッセージの送信やまめ知識などをお届けします。";
    // UITextFieldのインスタンスを生成
    CGRect rectbox = CGRectMake(10, 100, 200, 25);
    UITextField *textField = [[UITextField alloc]initWithFrame:rectbox];
    // 枠線のスタイルを設定
    textField.borderStyle = UITextBorderStyleRoundedRect;
    // ラベルのテキストのフォントを設定
    textField.font = [UIFont fontWithName:@"Helvetica" size:14];
    // プレースホルダ
    textField.placeholder = @"メールアドレスを入力してください";
    // キーボードの種類を設定
    textField.keyboardType = UIKeyboardTypeDefault;
    // リターンキーの種類を設定
    textField.returnKeyType = UIReturnKeyDefault;
    // 編集中にテキスト消去ボタンを表示
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    // ボタンを作成
    UIButton *button =
    [UIButton buttonWithType:UIButtonTypeRoundedRect];
    // ボタンの位置を設定
    button.center = CGPointMake(100, 150);
    // キャプションを設定
    [button setTitle:@"アドレス登録"
            forState:UIControlStateNormal];
    // キャプションに合わせてサイズを設定
    [button sizeToFit];
    // ボタンがタップされたときに呼ばれるメソッドを設定
    [button addTarget:self
               action:@selector(button_Tapped:)
     forControlEvents:UIControlEventTouchUpInside];
    
    // 背景のインスタンスをビューに追加
    [self.view addSubview:background];
    // UITextViewのインスタンスをビューに追加
    [self.view addSubview:textView];
    // UITextFieldのインスタンスをビューに追加
    [self.view addSubview:textField];
    // ボタンをビューに追加
    [self.view addSubview:button];
    
}

- (void)button_Tapped:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
