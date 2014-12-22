//
//  User.m
//  ikwitMVC
//
//  Created by Andrei Nechaev on 7/8/14.
//  Copyright (c) 2014 Andrei Nechaev. All rights reserved.
//

#import "User.h"

@interface User ()

@end

@implementation User

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.login = @"LOGIN";
        self.avatar = [UIImage new];
    }
    
    return self;
}

- (void)decodeAvatar:(NSString *)encodedString
{
    
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"User with name - %@", _login];
}

@end
