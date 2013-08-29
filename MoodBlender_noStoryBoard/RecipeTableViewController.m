//
//  RecipeTableViewController.m
//  MoodBlender_noStoryBoard
//
//  Created by altofwe on 13/08/26.
//  Copyright (c) 2013年 neko. All rights reserved.
//

#import "RecipeTableViewController.h"
#import "UIView+UIView_MyExtention.h"

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
    
    //self.title = @"RecipeTableViewController";
    
    //init Dictionarys
    path = [[NSBundle mainBundle] pathForResource:@"cocktail" ofType:@"plist"];
    dictionary = [NSDictionary dictionaryWithContentsOfFile:path];
    keys = [dictionary allKeys];
    
    //Set background color and separate
    self.tableView.separatorColor = [UIColor darkGrayColor];
    [self.tableView setBackgroundColor:[UIColor blackColor]];
    
    //Set contentInset
    //self.tableView.contentInset = UIEdgeInsetsMake(50.0, 0, 0, 0);
    //[self.view setOriginY:100];
    
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
    return cocktailbaseArray.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyIdentifier"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyIdentifier"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.textColor = [UIColor whiteColor];
    }
    
    //init userDefaults
    
    NSString *indexPathString = [NSString stringWithFormat:@"%d:%d", indexPath.section, indexPath.row];
    userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *userDefaultsDefault = [NSMutableDictionary dictionary];
    [userDefaultsDefault setObject:@"NO" forKey:indexPathString];
    [userDefaults registerDefaults:userDefaultsDefault];
    
    NSString *key = [keys objectAtIndex:(NSUInteger)(indexPath.section)];
    NSArray *cocktailbaseArray = [dictionary objectForKey:key];
    int maxRow = cocktailbaseArray.count;
    
    cell.textLabel.text = @"";
    BOOL isFinded = [userDefaults boolForKey:indexPathString];
    if(isFinded == YES){
        NSString *key = [keys objectAtIndex:indexPath.section];
        NSArray *cocktailbaseArray = [dictionary objectForKey:key];
        NSDictionary *cocktailRecipe = [cocktailbaseArray objectAtIndex:indexPath.row];
        
        cell.textLabel.text = [cocktailRecipe objectForKey:@"name"];
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        
    } else if(indexPath.row < maxRow){
        cell.textLabel.text = @"?";
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else{
        cell.accessoryType = UITableViewCellAccessoryNone;
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
    // Navigation logic may go here. Create and push another view controller.
    
    //Create animation
    CATransition* transition = [CATransition animation];
    transition.duration = 0.3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    //Get Recipe data
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RecipeViewController *nextView = [[RecipeViewController alloc] init];
    nextView.recipeIndex = indexPath;
    
    //Move View
    ParentViewController *nextParent = [[ParentViewController alloc] init];
    nextParent.viewController = nextView;
    nextParent.animationType = kCATransitionFromLeft;
    nextParent.hiddenHome = NO;
    nextParent.hiddenBack = NO;
    [self.navigationController pushViewController:nextParent animated:NO];
    
}

-(NSIndexPath *)tableView:(UITableView *)tableView
 willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *indexPathString = [NSString stringWithFormat:@"%d:%d", indexPath.section, indexPath.row];
    BOOL isFinded = [userDefaults boolForKey:indexPathString];
    if (isFinded){
        return indexPath;
    } else{
        return nil;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [keys objectAtIndex:section];
}

@end
