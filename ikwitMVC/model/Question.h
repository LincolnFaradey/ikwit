//
//  Answer.h
//  ikwitMVC
//
//  Created by Andrei Nechaev on 8/3/14.
//  Copyright (c) 2014 Andrei Nechaev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Question : NSObject

@property (strong, nonatomic)NSString *authorName;
@property (strong, nonatomic)NSString *answerText;
@property (assign, nonatomic)NSUInteger likeCounter;
@property (assign, nonatomic)NSUInteger commentsCounter;

- (id)initWithUser:(NSString *)userName
        withAnswer:(NSString *)answer
         withLikes:(NSInteger)likeCounter
      withComments:(NSUInteger)commentsCounter;;
- (void)downloadAnswersFromServer;

@end
