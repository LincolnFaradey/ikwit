//
//  ANVKeyboardToolBar.m
//  ikwit
//
//  Created by Andrei Nechaev on 10/29/14.
//  Copyright (c) 2014 Andrei Nechaev. All rights reserved.
//

#import "ANVKeyboardToolBar.h"

@implementation ANVKeyboardToolBar

@synthesize textField;
@synthesize button;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame
{
    CGRect rect = CGRectMake(0, 510, 320, 60);
    self = [super initWithFrame:rect];
    if (self) {
        textField = [[UITextField alloc] initWithFrame:CGRectMake(5, 5, 310, 50)];
        [self addSubview:textField];
        
        textField.backgroundColor = [UIColor grayColor];
        
        [self bringSubviewToFront:textField];
        self.backgroundColor = [UIColor redColor];
    }
    
    return self;
}

- (id)init
{
    CGRect rect = CGRectMake(0, 320, 320, 60);
    self = [super init];
    if (self) {
        self = [self initWithFrame:rect];
    }
    return self;
}

@end
