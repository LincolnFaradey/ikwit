//
//  ANVCustomCellTableViewCell.h
//  ikwitMVC
//
//  Created by Andrei Nechaev on 7/23/14.
//  Copyright (c) 2014 Andrei Nechaev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ANVCustomCell : UITableViewCell

@property (nonatomic, strong) UIButton *userIcon;
@property (nonatomic, strong) UILabel *userName;

@property (nonatomic, strong) UIButton *moreButton;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *likeCounter;
@property (nonatomic, strong) UIButton *likeButton;
@property (nonatomic, strong) UIButton *favoriteButton;
@property (nonatomic, strong) UIButton *commentsButton;
@property (nonatomic, strong) UILabel *commentsCounter;

@end
