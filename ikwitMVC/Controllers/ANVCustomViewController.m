//
//  ANVFavorite.m
//  ikwitMVC
//
//  Created by Andrei Nechaev on 7/23/14.
//  Copyright (c) 2014 Andrei Nechaev. All rights reserved.
//

#import "ANVCustomViewController.h"
#import "QuestionSharedManager.h"
#import "ANVDetailedController.h"
#import "ANVCustomCell.h"
#import "Question.h"

@interface ANVCustomViewController ()

@property (weak, nonatomic)ANVCustomCell *cell;
@property (weak, nonatomic)QuestionSharedManager *sharedStore;


@end

@implementation ANVCustomViewController

@synthesize cell;

static NSString *customCellID = @"ANVCustomCell";

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    GHContextMenuView* overlay = [[GHContextMenuView alloc] init];
    overlay.dataSource = self;
    overlay.delegate = self;
    
    UILongPressGestureRecognizer* _longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:overlay action:@selector(longPressDetected:)];
    [self.view addGestureRecognizer:_longPressRecognizer];
    _sharedStore = [QuestionSharedManager sharedManager];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    //[self.tableView setContentInset:UIEdgeInsetsMake(30,0,0,0)];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [_sharedStore fillStore];
    [_sharedStore fillStore];
}

// Implementing data source methods
- (NSInteger) numberOfMenuItems
{
    return 3;
}

-(UIImage*) imageForItemAtIndex:(NSInteger)index
{
    NSString* imageName = nil;
    switch (index) {
        case 0:
            imageName = @"facebook";
            break;
        case 1:
            imageName = @"twitter";
            break;
        case 2:
            imageName = @"google-plus";
            break;
            
        default:
            break;
    }
    return [UIImage imageNamed:imageName];
}

- (void) didSelectItemAtIndex:(NSInteger)selectedIndex forMenuAtPoint:(CGPoint)point
{
    NSString* msg = nil;
    switch (selectedIndex) {
        case 0:
            msg = @"Settings Selected";
            break;
        case 1:
            msg = @"Accaunt Selected";
            break;
        case 2:
            msg = @"Sign Out Selected";
            break;
            
        default:
            break;
    }
    
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
    
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
    return [_sharedStore length];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ANVCustomCell *loadedCell = (ANVCustomCell *)[tableView dequeueReusableCellWithIdentifier:customCellID];
    if (loadedCell == nil) {
        loadedCell = [[ANVCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customCellID];
        [loadedCell.likeButton addTarget:self action:@selector(wow:) forControlEvents:UIControlEventTouchUpInside];
    }
    Question *answer = [[_sharedStore returnAnswers] objectAtIndex:indexPath.row];
    loadedCell.userName.text = answer.authorName;
    loadedCell.likeCounter.text = [NSString stringWithFormat:@"%lu", (unsigned long)answer.likeCounter ];
    loadedCell.commentsCounter.text = [NSString stringWithFormat:@"%lu", (unsigned long)answer.commentsCounter];
    return loadedCell;
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
    ANVDetailedController *dc = [[ANVDetailedController alloc] initWithStyle:UITableViewStylePlain];
    dc.hidesBottomBarWhenPushed = YES;
    
    dc.question = [[[QuestionSharedManager sharedManager] returnAnswers] objectAtIndex:[indexPath row]];
    
    [self.navigationController pushViewController:dc animated:YES];
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//
//}


#pragma mark - Cell button methods

- (void)moreButtonBeenPressed:(id)sender {
    NSLog(@"More Pressed");
}

- (void)likeButtonBeenPressed:(id)sender {
    NSLog(@"Like pressed");
    cell.likeCounter.text = @"1";
    [cell updateConstraints];
}

- (void)favoriteButtonBeenPressed:(id)sender
{
    NSLog(@"Favorite pressed");
}

- (void)userIconBeenPressed:(id)sender
{
    NSLog(@"User Icon pressed");
}

- (void)commentsButtonBeenPressed:(id)sender
{
    NSLog(@"Comments pressed");
}

- (void)wow:(id)sender
{
    NSLog(@"1111111111");
}


@end
