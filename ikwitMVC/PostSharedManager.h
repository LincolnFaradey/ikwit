//
//  AnswerSharedManager.h
//  ikwitMVC
//
//  Created by Andrei Nechaev on 8/3/14.
//  Copyright (c) 2014 Andrei Nechaev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Post;

@interface PostSharedManager : NSObject{
    NSMutableArray *sharedStore;
}

+ (id)sharedManager;

- (void)addPost:(Post *)post;
- (NSUInteger)length;
- (NSArray *)returnAnswers;

@end
