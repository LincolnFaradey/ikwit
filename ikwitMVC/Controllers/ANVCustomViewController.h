//
//  ANVFavorite.h
//  ikwitMVC
//
//  Created by Andrei Nechaev on 7/23/14.
//  Copyright (c) 2014 Andrei Nechaev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GHContextMenuView.h"
@class ANVCustomCell;
@class Question;

@interface ANVCustomViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, GHContextOverlayViewDataSource, GHContextOverlayViewDelegate>


- (void)moreButtonBeenPressed:(id)sender;
- (void)likeButtonBeenPressed:(id)sender;
- (void)favoriteButtonBeenPressed:(id)sender;
- (void)commentsButtonBeenPressed:(id)sender;
- (void)userIconBeenPressed:(id)sender;

@end
