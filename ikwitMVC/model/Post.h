//
//  Answer.h
//  ikwitMVC
//
//  Created by Andrei Nechaev on 8/3/14.
//  Copyright (c) 2014 Andrei Nechaev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Comment;

@interface Post : NSObject

@property (strong, nonatomic)NSString *authorName;
@property (strong, nonatomic)NSString *answerText;
@property (assign, nonatomic)NSUInteger likeCounter;
@property (assign, nonatomic)NSUInteger commentsCounter;

@property (strong, nonatomic)NSMutableArray *commentStorage;

- (id)initWithUser:(NSString *)userName
        withAnswer:(NSString *)answer;

- (void)addCommentToStorage:(Comment *)comment;
- (NSArray *)returnComments;

@end
