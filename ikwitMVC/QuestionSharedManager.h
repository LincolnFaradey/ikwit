//
//  AnswerSharedManager.h
//  ikwitMVC
//
//  Created by Andrei Nechaev on 8/3/14.
//  Copyright (c) 2014 Andrei Nechaev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionSharedManager : NSObject{
    NSMutableArray *sharedStore;
}

+ (id)sharedManager;

- (NSUInteger)length;
- (NSArray *)returnAnswers;

- (void)fillStore;

@end
