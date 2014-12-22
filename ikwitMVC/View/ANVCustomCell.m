//
//  ANVCustomCellTableViewCell.m
//  ikwitMVC
//
//  Created by Andrei Nechaev on 7/23/14.
//  Copyright (c) 2014 Andrei Nechaev. All rights reserved.
//

#import "ANVCustomCell.h"
//@class ANVCustomViewController;

@interface ANVCustomCell ()

@end

@implementation ANVCustomCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:@"ANVCustomCell"];
    if (self) {
        CGRect frame = CGRectMake(240, 170, 30, 30);
        _likeButton = [[UIButton alloc] initWithFrame:frame];
        _likeButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Like"]];
        [self addSubview:_likeButton];
        
        frame = CGRectMake(60, 50, 230, 120);
        _contentLabel = [[UILabel alloc] initWithFrame:frame];
        _contentLabel.layer.cornerRadius = 8.0;
        _contentLabel.layer.masksToBounds = YES;
        _contentLabel.backgroundColor = [UIColor colorWithHue:0.130 saturation:0.680 brightness:0.980 alpha:1];
        [self addSubview:_contentLabel];
        
        frame = CGRectMake(290, 170, 30, 30);
        _likeCounter = [[UILabel alloc] initWithFrame:frame];
        _likeCounter.text = @"0";
        [self addSubview:_likeCounter];
        
        frame = CGRectMake(280, 10, 30, 30);
        _moreButton = [[UIButton alloc] initWithFrame:frame];
        _moreButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"more"]];
        [self addSubview:_moreButton];
        
        frame = CGRectMake(200, 170, 30, 30);
        _favoriteButton = [[UIButton alloc] initWithFrame:frame];
        _favoriteButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Favorite"]];
        [self addSubview:_favoriteButton];
        
        frame = CGRectMake(10, 170, 30, 30);
        _commentsButton = [[UIButton alloc] initWithFrame:frame];
        _commentsButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"answers"]];
        [self addSubview:_commentsButton];
        
        frame = CGRectMake(50, 170, 30, 30);
        _commentsCounter = [[UILabel alloc] initWithFrame:frame];
        _commentsCounter.text = @"0";
        [self addSubview:_commentsCounter];
        
        frame = CGRectMake(70, 10, 160, 35);
        _userName = [[UILabel alloc] initWithFrame:frame];
        _userName.text = @"User";
        [self addSubview:_userName];
        
        frame = CGRectMake(5, 5, 60, 60);
        _userIcon = [[UIButton alloc] initWithFrame:frame];
        _userIcon.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ava"]];
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
