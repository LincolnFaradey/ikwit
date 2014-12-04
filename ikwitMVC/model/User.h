//
//  User.h
//  ikwitMVC
//
//  Created by Andrei Nechaev on 7/8/14.
//  Copyright (c) 2014 Andrei Nechaev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (strong, nonatomic)NSString *login;
@property (strong, nonatomic)UIImage *avatar;

- (void)decodeAvatar:(NSString *)encodedString;

@end
