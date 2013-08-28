//
//  ShakingViewController.m
//  MoodBlender_noStoryBoard
//
//  Created by altofwe on 13/08/23.
//  Copyright (c) 2013年 neko. All rights reserved.
//

#import "ShakingViewController.h"
#import "ShakedViewController.h"
#import "UIView+UIView_MyExtention.h"

@interface ShakingViewController ()

@end

@implementation ShakingViewController

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
    UIImage *background3_image = [UIImage imageNamed:@"background3.png"];
    background = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    background.contentMode = UIViewContentModeScaleAspectFit;
    background.image = background3_image;
    
    //Generate objects
    UIImage *shaker_image = [UIImage imageNamed:@"shaker.png"];
    UIButton *shaker = [UIButton buttonWithType:UIButtonTypeCustom];
    
    //Set UIButtons text or image
    [shaker setBackgroundImage:shaker_image forState:UIControlStateNormal];
    
    //Set UIButtons background color
    shaker.backgroundColor = [UIColor blackColor];
    
    //Set UIButtons size
    shaker.frame = CGRectMake(0, 0, 150, 240);
    
    //Move objects to center
    shaker.center = self.view.center;
    
    //Move UIImageViews
    shaker.centerY -= 30;
    
    //Set UIImage backgroundColor clearly
    shaker.backgroundColor = [UIColor clearColor];
    
    //Set UIButtons motion
    [shaker addTarget:self action:@selector(shaker:) forControlEvents:UIControlEventTouchUpInside ];
    
    self.shaker = shaker;
    
    //Show objects
    [self.view addSubview:background];
    [self.view addSubview:shaker];
    
    
    //シェイクした回数のカウント
    _count=0;
    shake=false;
    
    //self.shaker = [[UIImageView alloc] init];
    //self.shaker.frame = CGRectMake(0, 0, 100, 150);
    //self.shaker.image = [UIImage imageNamed:@"6032827610_ebe95a12b2_o.jpg"];
    //[self.view addSubview:self.shaker];
    
    //加速度センサーを感知するクラスを生成
    UIAccelerometer *accelerometer = [UIAccelerometer sharedAccelerometer];
    accelerometer.updateInterval = 0.2;
    accelerometer.delegate = self;
    
    //乱数生成
    ran = rand()%11+5;
    half_ran = (int)(ran / 2);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//ginButton motion
-(void)shaker:(UIButton*)shaker{
    ShakedViewController *nextView = [[ShakedViewController alloc] init];
    
    nextView.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    [self presentViewController:nextView animated:YES completion:^{}];
}

//加速度センサーを感知するクラスがチェックした時に、いつも呼び出される関数
-(void)accelerometer:(UIAccelerometer *)accelerometer
       didAccelerate:(UIAcceleration *)acceleration{
    
    
    //変更される背景画像
    UIImage *background2_image = [UIImage imageNamed:@"background2.png"];
    UIImage *background_image = [UIImage imageNamed:@"background.png"];
    //background.image = background2_image;
    
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
        NSLog(@"in");
        NSLog(@"%d回", _count);
        
        if(_count == half_ran){
            background.image = background2_image;
        } else if(_count == ran){
            background.image = background_image;
        }
        
        //判定
        shake=true;
        //カウント
        _count++;
        
        //CGPointMake(x座標, y座標)の位置に画像を移動させる
        [UIView animateWithDuration:0.4 animations:^{
            self.shaker.center = CGPointMake(self.shaker.centerX, self.view.frame.size.height - (self.shaker.frame.size.height / 2));
        }];
        //CGPointMake(x座標, y座標)の位置に画像を移動させる
        [UIView animateWithDuration:0.3 animations:^{
            self.shaker.center = CGPointMake(self.shaker.frame.size.width, self.shaker.frame.size.height / 2);
        }];
        
    }else if(shake==true){
        shake=false;
    }
    
    before_point.y = acceleration.y;
}

@end
