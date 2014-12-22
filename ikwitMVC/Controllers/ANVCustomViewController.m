//
//  ANVFavorite.m
//  ikwitMVC
//
//  Created by Andrei Nechaev on 7/23/14.
//  Copyright (c) 2014 Andrei Nechaev. All rights reserved.
//

#import "ANVCustomViewController.h"
#import "PostSharedManager.h"
#import "ANVDetailedController.h"
#import "ANVCustomCell.h"
#import "Post.h"

@interface ANVCustomViewController ()

@property (weak, nonatomic)ANVCustomCell *cell;
@property (weak, nonatomic)PostSharedManager *sharedStore;

- (void)moreButtonBeenPressed:(id)sender;
- (void)likeButtonBeenPressed:(id)sender;
- (void)favoriteButtonBeenPressed:(id)sender;
- (void)commentsButtonBeenPressed:(id)sender;
- (void)userIconBeenPressed:(id)sender;

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
    
    _sharedStore = [PostSharedManager sharedManager];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //TEST
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    NSLog(@"Token - %@", [userD objectForKey:@"Token"]);
}

- (void)viewWillAppear:(BOOL)animated
{
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
    }
    Post *answer = [[_sharedStore returnAnswers] objectAtIndex:indexPath.row];
    loadedCell.userName.text = answer.authorName;
    loadedCell.likeCounter.text = [NSString stringWithFormat:@"%lu", (unsigned long)answer.likeCounter ];
    loadedCell.commentsCounter.text = [NSString stringWithFormat:@"%lu", (unsigned long)answer.commentsCounter];
    
    [loadedCell.likeButton addTarget:self action:@selector(likeButtonBeenPressed:) forControlEvents:UIControlEventTouchDown];
    loadedCell.likeButton.tag = indexPath.row;
    
    [loadedCell.commentsButton addTarget:self action:@selector(commentsButtonBeenPressed:) forControlEvents:UIControlEventTouchUpInside];
    loadedCell.commentsButton.tag = indexPath.row;
    
    [loadedCell.userIcon addTarget:self action:@selector(userIconBeenPressed:) forControlEvents:UIControlEventTouchUpInside];
    loadedCell.userIcon.tag = indexPath.row;
    
    [loadedCell.moreButton addTarget:self action:@selector(moreButtonBeenPressed:) forControlEvents:UIControlEventTouchUpInside];
    loadedCell.moreButton.tag = indexPath.row;
    
    [loadedCell.favoriteButton addTarget:self action:@selector(favoriteButtonBeenPressed:) forControlEvents:UIControlEventTouchUpInside];
    loadedCell.favoriteButton.tag = indexPath.row;
    
    loadedCell.contentLabel.text = answer.answerText;
    
    return loadedCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ANVDetailedController *dc = [[ANVDetailedController alloc] initWithStyle:UITableViewStylePlain];
    dc.hidesBottomBarWhenPushed = YES;
    
    dc.question = [[[PostSharedManager sharedManager] returnAnswers] objectAtIndex:[indexPath row]];
    
    [self.navigationController pushViewController:dc animated:YES];
}


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


@end
