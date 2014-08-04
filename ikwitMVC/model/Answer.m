//
//  Answer.m
//  ikwitMVC
//
//  Created by Andrei Nechaev on 8/3/14.
//  Copyright (c) 2014 Andrei Nechaev. All rights reserved.
//

#import "Answer.h"


@implementation Answer

- (id) init
{
    self = [self initWithUser:@"undef" withAnswer:@"empty"];
    
    return self;
}

- (id)initWithUser:(NSString *)userName withAnswer:(NSString *)answer
{
    if (self = [super init]) {
        self.authorName = userName;
        self.answerText = answer;
    }
    
    return self;
}

- (void)downloadAnswersFromServer
{

}

@end
