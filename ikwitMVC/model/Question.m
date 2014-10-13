//
//  Answer.m
//  ikwitMVC
//
//  Created by Andrei Nechaev on 8/3/14.
//  Copyright (c) 2014 Andrei Nechaev. All rights reserved.
//

#import "Question.h"


@implementation Question

- (id) init
{
    self = [self initWithUser:@"undefined" withAnswer:@"empty" withLikes:0 withComments:0];
    
    return self;
}

- (id)initWithUser:(NSString *)userName
        withAnswer:(NSString *)answer
         withLikes:(NSInteger)likeCounter
      withComments:(NSUInteger)commentsCounter;
{
    if (self = [super init]) {
        self.authorName = userName;
        self.answerText = answer;
        self.likeCounter = likeCounter;
        self.commentsCounter = commentsCounter;
    }
    
    return self;
}

- (void)downloadAnswersFromServer
{

}

@end
