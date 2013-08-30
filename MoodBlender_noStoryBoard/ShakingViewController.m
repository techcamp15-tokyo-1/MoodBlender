//
//  ShakingViewController.m
//  MoodBlender_noStoryBoard
//
//  Created by altofwe on 13/08/23.
//  Copyright (c) 2013年 neko. All rights reserved.
//

#import "ShakingViewController.h"
#import "UIView+UIView_MyExtention.h"

@interface ShakingViewController ()

@end

@implementation ShakingViewController

const int NUMBER_OF_GLASS = 4;

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
    
    //self.title = @"ShakingViewController";
    
    //init variable
    ran = rand() % 5 +5;
    halfRan = (int)(ran / 2);
    count=0;
    shake=false;
    shakeEnd = NO;
    
    //Set background image
    UIImage *backgroundImage3 = [UIImage imageNamed:@"background3.png"];
    CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
    CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
    CGRect correctFrame = CGRectOffset(applicationFrame, 0, -CGRectGetHeight(statusBarFrame));
    background = [[UIImageView alloc] initWithFrame:correctFrame];
    background.contentMode = UIViewContentModeScaleAspectFill;
    background.image = backgroundImage3;
    
    //Create objects
    UIImage *shakerImage = [UIImage imageNamed:@"shaker.png"];
    UIImage *shakeMessageImage = [UIImage imageNamed:@"ShakeIt2.png"];
    UIImage *tapMessageImage = [UIImage imageNamed:@"tapIt.png"];
    shaker = [UIButton buttonWithType:UIButtonTypeCustom];
    shakeMessage = [[UIImageView alloc] initWithImage:shakeMessageImage];
    tapMessage = [[UIImageView alloc] initWithImage:tapMessageImage];
    
    //Set UIImageView aspectMode
    shakeMessage.contentMode = UIViewContentModeScaleAspectFit;
    tapMessage.contentMode = UIViewContentModeScaleAspectFit;
    
    //Set UIButtons text or image
    [shaker setBackgroundImage:shakerImage forState:UIControlStateNormal];
    
    //Set UIButtons background color
    shaker.backgroundColor = [UIColor blackColor];
    
    //Set UIButtons size
    shaker.frame = CGRectMake(0, 0, 150, 240);
    shakeMessage.frame = CGRectMake(0, 0,  370, 370);
    tapMessage.frame = CGRectMake(0, 0,  370, 370);
    
    //Move objects to center
    shaker.center = self.view.center;
    shakeMessage.center = shaker.center;
    tapMessage.center = shaker.center;
    
    //Move UIButton
    shaker.centerY -= 30;
    
    //Set 'Tap!' hidden
    tapMessage.hidden = YES;
    
    //Set objects backgroundColor clearly
    shaker.backgroundColor = [UIColor clearColor];
    shakeMessage.backgroundColor = [UIColor clearColor];
    tapMessage.backgroundColor = [UIColor clearColor];
    
    //Set UIButtons motion
    [shaker addTarget:self action:@selector(shaker:) forControlEvents:UIControlEventTouchUpInside ];
    
    //Show objects
    [self.view addSubview:background];
    [self.view addSubview:shaker];
    [self.view addSubview:tapMessage];
    [self.view addSubview:shakeMessage];
    
    //加速度センサーを感知するクラスを生成
    UIAccelerometer *accelerometer = [UIAccelerometer sharedAccelerometer];
    accelerometer.updateInterval = 0.2;
    accelerometer.delegate = self;
    
    //レシピ表示画面に送るplistのindexPathを生成
    //ベースの指定はself.stateに文字列として保存しており、そのままDictionaryのkeyとして使用することが可能。
    path = [[NSBundle mainBundle] pathForResource:@"cocktail" ofType:@"plist"];
    dictionary = [NSDictionary dictionaryWithContentsOfFile:path];
    keys = [dictionary allKeys];
    int section = [self keyToIndex:self.baseState UseArray:keys];
    NSArray *cocktailbaseArray = [dictionary objectForKey:self.baseState];
    int randamRow = rand() % cocktailbaseArray.count;
    indexPath = [NSIndexPath indexPathForRow:randamRow inSection:section];
    
    //レシピを発見したことをUserDefaultsに登録
    NSString *indexPathString = [NSString stringWithFormat:@"%d:%d", indexPath.section, indexPath.row];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:YES forKey:indexPathString];
    [userDefaults synchronize];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//ShakerButton motion
-(void)shaker:(UIButton*)button{
    
    //まだshakeが終わってなかったら何もしない
    //tmp
    if(!shakeEnd) return ;
    
    tapMessage.hidden = YES;
    shakeEnd = NO;
    
    //Create glass image
    //読み込むファイルの名前はGlass(n).pngに統一されているものとする
    NSMutableArray *glasses = [NSMutableArray array];
    for(int i = 1; i <= NUMBER_OF_GLASS; ++i){
        [glasses addObject:[UIImage imageNamed:[NSString stringWithFormat:@"Glass%d.png", i]]];
    }
    int glassIndex = rand() % glasses.count;
    UIImage *glassImage = [glasses objectAtIndex:glassIndex];
    
    //ちょっと見た目汚いけど、ネストしないとアニメーションがうまく同期しません。見苦しくてごめんね。
    //この下の行のanimateWithDuration ... フェードアウトの秒数
    [UIView animateWithDuration:1.0
                     animations:^{
                         shaker.alpha = 0.0;
                     }
                     completion:^(BOOL finished){
                         [shaker setBackgroundImage:glassImage forState:UIControlStateNormal];
                         
                         //この下の行のanimateWithDuration ... フェードインの秒数
                         [UIView animateWithDuration:2.0
                                          animations:^{
                                              shaker.alpha = 1.0;
                                          }
                                          completion:^(BOOL finished){
                                              
                                              //sleepForTimeInterval ... フェードイン後、グラスが表示される秒数
                                              [NSThread sleepForTimeInterval:0.5];
                                              
                                              //Create and Setting animation pattern
                                              CATransition *transition = [CATransition animation];
                                              transition.duration = 0.2;
                                              transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
                                              transition.type = kCATransitionFade;
                                              [self.navigationController.view.layer addAnimation:transition forKey:nil];
                                              
                                              //Move View
                                              ParentViewController *nextParent = [[ParentViewController alloc] init];
                                              RecipeViewController *nextView = [[RecipeViewController alloc] init];
                                              nextView.recipeIndex = indexPath;
                                              nextParent.viewController = nextView;
                                              nextParent.animationType = kCATransitionFromBottom;
                                              nextParent.hiddenHome = NO;
                                              nextParent.hiddenBack = YES;
                                              nextParent.createNewPage = YES;
                                              [self.navigationController pushViewController:nextParent animated:NO];
                                          }
                          ];
                     }
     ];
    
}

//加速度センサーを感知するクラスがチェックした時に、いつも呼び出される関数
-(void)accelerometer:(UIAccelerometer *)accelerometer
       didAccelerate:(UIAcceleration *)acceleration{
    
    
    //変更される背景画像
    UIImage *backgroundImage2 = [UIImage imageNamed:@"background2.png"];
    UIImage *backgroundImage = [UIImage imageNamed:@"background.png"];
    //background.image = backgroundimage2;
    
    //加速度の絶対値
    UIAccelerationValue x = acceleration.x;  // X軸方向の加速度
    UIAccelerationValue y = acceleration.y;  // Y軸方向の加速度
    UIAccelerationValue z = acceleration.z;  // Z軸方向の加速度
    int AX=abs(x);
    int AY=abs(y);
    int AZ=abs(z);
    
    //加速度の絶対値を利用した判定
    if((AX+AY+AZ)>3&&shake==false){
        
        //tmp
        //NSLog(@"in");
        //NSLog(@"%d回", count);
        
        //3回以上振ったあとの'shake!'はしつこいので、ラベルを非表示
        if (count == 3){
            shakeMessage.hidden = YES;
        }
        
        
        //半月表示
        if(count == halfRan){
            background.image = backgroundImage2;
        }
        //満月表示, shake完了
        else if(count == ran){
            //tmp
            //NSLog(@"end");
            shakeEnd = YES;
            background.image = backgroundImage;
        }
        
        //判定
        shake=true;
        //カウント
        count++;
        
        //カウントによるアクションif分移動
        //CGPointMake(x座標, y座標)の位置に画像を移動させる 上に移動
        [UIView animateWithDuration:0.1 animations:^{
            shaker.center = CGPointMake(shaker.centerX, shaker.frame.size.height/ - (shaker.frame.size.height/2));
        }completion:^(BOOL finished){
            //CGPointMake(x座標, y座標)の位置に画像を移動させる　下に移動
            [UIView animateWithDuration:0.3 animations:^{
                shaker.center = CGPointMake(shaker.centerX, shaker.frame.size.height+(shaker.frame.size.height/2));
            }completion:^(BOOL finished){
                //CGPointMake(x座標, y座標)の位置に画像を移動させる
                [UIView animateWithDuration:0.1 animations:^{
                    shaker.center = CGPointMake(shaker.frame.size.width, shaker.frame.size.height);
                }completion:^(BOOL finished){
                    
                    if(count == halfRan){
                        background.image = backgroundImage2;
                    } else if(count == ran){
                        background.image = backgroundImage;
                        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                        tapMessage.hidden = NO;
                        
                    }
                }];
            }];
        }];
        
    }else if(shake==true){
        shake=false;
    }
    
    beforePoint.y = acceleration.y;
}

- (int)keyToIndex:(NSString *)arrayKey
         UseArray:(NSArray *)array{
    for (int i = 0; i < array.count; ++i){
        if([array objectAtIndex:i] == arrayKey){
            return i;
        }
    }
    return 0;
}

@end
