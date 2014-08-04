//
//  AnswerSharedManager.h
//  ikwitMVC
//
//  Created by Andrei Nechaev on 8/3/14.
//  Copyright (c) 2014 Andrei Nechaev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnswerSharedManager : NSObject{
    NSMutableArray *sharedStore;
}

+ (id)sharedManager;

- (void)fillStore;
- (NSArray *)returnAnswers;

@end
