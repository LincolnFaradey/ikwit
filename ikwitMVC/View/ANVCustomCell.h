//
//  ANVCustomCellTableViewCell.h
//  ikwitMVC
//
//  Created by Andrei Nechaev on 7/23/14.
//  Copyright (c) 2014 Andrei Nechaev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ANVCustomCell : UITableViewCell

@property (nonatomic) UIButton *userIcon;
@property (nonatomic) UILabel *userName;

@property (nonatomic) UIButton *moreButton;
@property (nonatomic) UILabel *contentLabel;
@property (nonatomic) UILabel *likeCounter;
@property (nonatomic) UIButton *likeButton;
@property (nonatomic) UIButton *favoriteButton;
@property (nonatomic) UIButton *commentsButton;
@property (nonatomic) UILabel *commentsCounter;

@end
