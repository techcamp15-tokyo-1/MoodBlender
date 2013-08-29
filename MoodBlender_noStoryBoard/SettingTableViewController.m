//
//  SettingTableViewController.m
//  MoodBlender_noStoryBoard
//
//  Created by altofwe on 13/08/29.
//  Copyright (c) 2013年 neko. All rights reserved.
//

#import "SettingTableViewController.h"

@interface SettingTableViewController ()

@end

@implementation SettingTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //Set background color and separate
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView setBackgroundColor:[UIColor blackColor]];
    
}

- (void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0){
        return 3;
    } else if(section == 1){
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyIdentifier"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyIdentifier"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.textColor = [UIColor whiteColor];
    }
    
    //init userDefaults emailAdress
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *defaults = [NSMutableDictionary dictionary];
    [defaults setObject:@"未登録" forKey:@"emailAdress"];
    [userDefaults registerDefaults:defaults];
    NSString *emailAdress = [userDefaults stringForKey:@"emailAdress"];
    
    
    cell.textLabel.text = @"";
    if (indexPath.section == 0){
        if (indexPath.row == 0){
            cell.textLabel.text = @"メールアドレス";
        } else if(indexPath.row == 1){
            cell.textLabel.text = emailAdress;
            cell.textLabel.textAlignment = NSTextAlignmentRight;
            cell.detailTextLabel.text = emailAdress;
        }
    } else if (indexPath.section == 1){
        cell.textLabel.text = @"メールアドレス設定変更";
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    }
    
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1 && indexPath.row == 0){
        
        //Create animation
        CATransition *transition = [CATransition animation];
        transition.duration = 0.3;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        transition.type = kCATransitionMoveIn;
        transition.subtype = kCATransitionFromRight;
        [self.navigationController.view.layer addAnimation:transition forKey:nil];
        
        //Move View
        ParentViewController *nextParent = [[ParentViewController alloc] init];
        SettingUserInformationViewController *nextView = [[SettingUserInformationViewController alloc] init];
        nextParent.viewController = nextView;
        nextParent.animationType = kCATransitionFromLeft;
        nextParent.hiddenBack = NO;
        nextParent.hiddenHome = NO;
        [self.navigationController pushViewController:nextParent animated:NO];
        
    }
}

@end
