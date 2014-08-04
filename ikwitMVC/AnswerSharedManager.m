//
//  AnswerSharedManager.m
//  ikwitMVC
//
//  Created by Andrei Nechaev on 8/3/14.
//  Copyright (c) 2014 Andrei Nechaev. All rights reserved.
//

#import "AnswerSharedManager.h"
#import "Answer.h"

@implementation AnswerSharedManager

#pragma mark - singleton method
+ (id)sharedManager
{
    static AnswerSharedManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    
    return sharedManager;
}

-(id)init{
    if (self = [super init]) {
        sharedStore = [NSMutableArray new];
    }
    return self;
}

- (void)fillStore
{
    Answer *answ = [[Answer alloc] initWithUser:@"Andrei" withAnswer:@"My First Answer"];
    [sharedStore addObject:answ];
}

- (NSArray *)returnAnswers
{
    NSArray *arr = [NSArray arrayWithArray:sharedStore];
    
    return arr;
}

@end
