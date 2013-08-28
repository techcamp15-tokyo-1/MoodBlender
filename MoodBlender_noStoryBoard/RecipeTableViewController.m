//
//  RecipeTableViewController.m
//  MoodBlender_noStoryBoard
//
//  Created by altofwe on 13/08/26.
//  Copyright (c) 2013年 neko. All rights reserved.
//

#import "RecipeTableViewController.h"

@interface RecipeTableViewController ()

@end

@implementation RecipeTableViewController

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
    
    //init Dictionarys
    path = [[NSBundle mainBundle] pathForResource:@"cocktail" ofType:@"plist"];
    dictionary = [NSDictionary dictionaryWithContentsOfFile:path];
    keys = [dictionary allKeys];
    
    //Generate swipeRecognizer(right) and set motion
    UISwipeGestureRecognizer* swipeRightGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(selSwipeRightGesture:)];
    swipeRightGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRightGesture];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
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
    return dictionary.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    NSString *key = [keys objectAtIndex:(NSUInteger)(section)];
    NSArray *cocktailbaseArray = [dictionary objectForKey:key];
    return cocktailbaseArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyIdentifier"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyIdentifier"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    //init userDefaults
    
    //UserDefaultのkeyはNSStringでのみの指定であるため、indexPathをNSStringに変換
    //MEMO:UserDefault実装したらコメントアウト部分使う
    ///NSString *indexPathString = [NSString stringWithFormat:@"%@", indexPath];
    //NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //NSMutableDictionary *userDefaultsDefault = [NSMutableDictionary dictionary];
    //[userDefaultsDefault setObject:@"NO" forKey:indexPathString];
    //[userDefaults registerDefaults:userDefaultsDefault];
    
    //BOOL isFinded = [userDefaults boolForKey:indexPathString];
    //if(isFinded == YES){
    NSString *key = [keys objectAtIndex:indexPath.section];
    NSArray *cocktailbaseArray = [dictionary objectForKey:key];
    NSDictionary *cocktailRecipe = [cocktailbaseArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [cocktailRecipe objectForKey:@"name"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //} else{
    //    cell.textLabel.text = @"?";
    //}
    
    
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
    // Navigation logic may go here. Create and push another view controller.
    
    //Get Recipe data
    NSString *key = [keys objectAtIndex:indexPath.section];
    NSArray *cocktailbaseArray = [dictionary objectForKey:key];
    NSDictionary *cocktailRecipe = [cocktailbaseArray objectAtIndex:indexPath.row];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RecipeViewController *next = [[RecipeViewController alloc] init];
    next.title = @"しただよ";
    next.recipe = cocktailRecipe;
    [self.navigationController pushViewController:next animated:YES];
    
    
}

//Swipe(right) motion
- (void)selSwipeRightGesture:(UISwipeGestureRecognizer *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
