//
//  ANVDetailedController.m
//  ikwitMVC
//
//  Created by Andrei Nechaev on 9/23/14.
//  Copyright (c) 2014 Andrei Nechaev. All rights reserved.
//

#import "ANVDetailedController.h"
#import "QuestionSharedManager.h"
#import "Question.h"
#import "ANVCustomCell.h"

@interface ANVDetailedController (){
    QuestionSharedManager *questionSM;
}

@end

@implementation ANVDetailedController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    questionSM = [QuestionSharedManager sharedManager];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.hidesBarsOnSwipe = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (section == 0) {
        return 1;
    }else{
        return [[questionSM returnAnswers] count];
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        CGFloat height = 200;
        return height;
    }else{
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                                   reuseIdentifier:@"DetailedId"];
    
    ANVCustomCell *mainCell = (ANVCustomCell *)[tableView dequeueReusableCellWithIdentifier:@"ANVCustomCell"];
    if (mainCell == nil) {
        mainCell = [[ANVCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ANVCustomCell"];
    }
    if (indexPath.section == 0) {
        mainCell.userName.text = self.question.authorName;
        mainCell.likeCounter.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.question.likeCounter];
        mainCell.commentsCounter.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.question.commentsCounter];
        return mainCell;
    }else{
        Question *answer = [[questionSM returnAnswers] objectAtIndex:indexPath.row];
        cell.textLabel.text = answer.authorName;
        cell.detailTextLabel.text = answer.answerText;
        return cell;
    }
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    }else{
        return @"Comments:";
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
