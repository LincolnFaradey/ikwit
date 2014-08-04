//
//  Answer.h
//  ikwitMVC
//
//  Created by Andrei Nechaev on 8/3/14.
//  Copyright (c) 2014 Andrei Nechaev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Answer : NSObject

@property (strong, nonatomic)NSString *authorName;
@property (strong, nonatomic)NSString *answerText;

- (id)initWithUser:(NSString *)userName withAnswer:(NSString *)answer;
- (void)downloadAnswersFromServer;

@end
