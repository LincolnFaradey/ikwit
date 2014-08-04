//
//  ANVFavorite.m
//  ikwitMVC
//
//  Created by Andrei Nechaev on 7/23/14.
//  Copyright (c) 2014 Andrei Nechaev. All rights reserved.
//

#import "ANVCustomViewController.h"
#import "ANVDetailViewController.h"
#import "AnswerSharedManager.h"
#import "Answer.h"

@interface ANVCustomViewController ()

@property (weak, nonatomic)ANVCustomCell *cell;

@end

@implementation ANVCustomViewController
@synthesize cell;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        [AnswerSharedManager sharedManager];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self.tableView setContentInset:UIEdgeInsetsMake(30,0,0,0)];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    AnswerSharedManager *answSM = [AnswerSharedManager sharedManager];
    [answSM fillStore];
    NSArray *arr = [answSM returnAnswers];
    NSLog(@"%lu", (unsigned long)[arr count]);
    Answer *an = arr[0];
    NSLog(@"%@", an.answerText);
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect rect = CGRectMake(100, 100, 100, 100);
    UIButton *but = [[UIButton alloc] initWithFrame:rect];
    but.backgroundColor = [UIColor blackColor];
    
    [cell.contentView addSubview:but];
    
    static NSString *customCellID = @"ANVCustomCell";
    
    cell = (ANVCustomCell *)[tableView dequeueReusableCellWithIdentifier:customCellID];
    cell.userName.text = @"User Name";
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    [cell.likeButton addTarget:self action:@selector(moreButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
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
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ANVDetailViewController *VC = [[ANVDetailViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
   
}

- (IBAction)moreButtonPressed:(id)sender {
    NSLog(@"Pressed");
}

- (void)likeButtonPressed:(id)sender {
    NSLog(@"like pressed");
}

@end
