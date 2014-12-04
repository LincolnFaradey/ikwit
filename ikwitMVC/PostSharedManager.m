//
//  AnswerSharedManager.m
//  ikwitMVC
//
//  Created by Andrei Nechaev on 8/3/14.
//  Copyright (c) 2014 Andrei Nechaev. All rights reserved.
//

#import "PostSharedManager.h"
#import "Post.h"

@implementation PostSharedManager

#pragma mark - singleton method
+ (id)sharedManager
{
    static PostSharedManager *sharedManager = nil;
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

- (void)addPost:(Post *)post
{
    [sharedStore addObject:post];
}

- (NSUInteger)length
{
    return sharedStore.count;
}

- (NSArray *)returnAnswers
{
    return sharedStore;
}




@end
