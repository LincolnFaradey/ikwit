//
//  ANVCustomCellTableViewCell.m
//  ikwitMVC
//
//  Created by Andrei Nechaev on 7/23/14.
//  Copyright (c) 2014 Andrei Nechaev. All rights reserved.
//

#import "ANVCustomCell.h"
@class ANVCustomViewController;

@interface ANVCustomCell (){
    ANVCustomViewController *vc;
}

@end

@implementation ANVCustomCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:@"ANVCustomCell"];
    if (self) {
        self.userName.text = @"Andrey";
        CGRect frame = CGRectMake(240, 170, 30, 30);
        self.likeButton = [[UIButton alloc] initWithFrame:frame];
        _likeButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Like"]];
        [_likeButton addTarget:vc action:@selector(likeButtonBeenPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_likeButton];
        
        
        frame = CGRectMake(290, 170, 30, 30);
        self.likeCounter = [[UILabel alloc] initWithFrame:frame];
        _likeCounter.text = @"0";
        [self addSubview:_likeCounter];
        
        frame = CGRectMake(280, 10, 30, 30);
        self.moreButton = [[UIButton alloc] initWithFrame:frame];
        _moreButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"more"]];
        [_moreButton addTarget:vc action:@selector(moreButtonBeenPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_moreButton];
        
        frame = CGRectMake(200, 170, 30, 30);
        self.favoriteButton = [[UIButton alloc] initWithFrame:frame];
        _favoriteButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Favorite"]];
        [_favoriteButton addTarget:vc action:@selector(favoriteButtonBeenPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_favoriteButton];
        
        frame = CGRectMake(10, 170, 30, 30);
        self.commentsButton = [[UIButton alloc] initWithFrame:frame];
        _commentsButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"answers"]];
        [_commentsButton addTarget:vc action:@selector(commentsButtonBeenPressed:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:_commentsButton];
        
        frame = CGRectMake(50, 170, 30, 30);
        self.commentsCounter = [[UILabel alloc] initWithFrame:frame];
        _commentsCounter.text = @"0";
        [self addSubview:_commentsCounter];
        
        frame = CGRectMake(70, 10, 160, 35);
        self.userName = [[UILabel alloc] initWithFrame:frame];
        _userName.text = @"User";
        [self addSubview:_userName];
        
        frame = CGRectMake(5, 5, 60, 60);
        self.userIcon = [[UIButton alloc] initWithFrame:frame];
        _userIcon.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ava"]];
        [_userIcon addTarget:vc action:@selector(userIconBeenPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_userIcon];
    }
    return self;
}


- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Configure the view for the selected state
}


@end
