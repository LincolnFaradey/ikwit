//
//  Answer.m
//  ikwitMVC
//
//  Created by Andrei Nechaev on 8/3/14.
//  Copyright (c) 2014 Andrei Nechaev. All rights reserved.
//

#import "Post.h"
#import "Comment.h"


@implementation Post

- (id) init
{
    self = [self initWithUser:@"undefined" withAnswer:@"empty"];
    
    return self;
}

- (id)initWithUser:(NSString *)userName
        withAnswer:(NSString *)answer;
{
    if (self = [super init]) {
        self.authorName = userName;
        self.answerText = answer;
        self.likeCounter = 0;
        self.commentsCounter = 0;
        self.commentStorage = [NSMutableArray new];
    }
    
    return self;
}

- (void)addCommentToStorage:(Comment *)comment
{
    [self.commentStorage addObject:comment];
}

- (NSArray *)returnComments
{
    return self.commentStorage;
}

@end
