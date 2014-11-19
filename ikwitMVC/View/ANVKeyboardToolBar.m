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
        textField = [[UITextField alloc] initWithFrame:CGRectMake(5, 5, 260, 50)];
        button = [[UIButton alloc] initWithFrame:CGRectMake(265, 5, 50, 50)];
        
        [textField addSubview:button];

        [self addSubview:textField];
        [self addSubview:button];
        
        textField.backgroundColor = [UIColor colorWithHue:0.075 saturation:0.761 brightness:0.969 alpha:0.5];
        button.backgroundColor = [UIColor colorWithHue:0.130 saturation:0.680 brightness:0.980 alpha:0.8];
        
        //[self bringSubviewToFront:textField];
        self.backgroundColor = [UIColor colorWithHue:0.036 saturation:0.838 brightness:0.922 alpha:0.2];
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
