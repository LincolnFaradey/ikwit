//
//  AnswerSharedManager.m
//  ikwitMVC
//
//  Created by Andrei Nechaev on 8/3/14.
//  Copyright (c) 2014 Andrei Nechaev. All rights reserved.
//

#import "QuestionSharedManager.h"
#import "Question.h"

@implementation QuestionSharedManager

#pragma mark - singleton method
+ (id)sharedManager
{
    static QuestionSharedManager *sharedManager = nil;
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

- (NSUInteger)length
{
    return sharedStore.count;
}

- (void)fillStore
{
    Question *answ = [[Question alloc] initWithUser:@"Andrei Nechaev" withAnswer:@"My First Answer" withLikes:arc4random() % 44 withComments:arc4random() % 100];
    [sharedStore addObject:answ];
}

- (NSArray *)returnAnswers
{
    NSArray *arr = [NSArray arrayWithArray:sharedStore];
    
    return arr;
}

@end
