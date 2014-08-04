//
//  User.h
//  ikwitMVC
//
//  Created by Andrei Nechaev on 7/8/14.
//  Copyright (c) 2014 Andrei Nechaev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

- (instancetype)initWithLogin:(NSString *)login
                    withEmail:(NSString *)email
                 withPassword:(NSString *)password
           andConfirmPassword:(NSString *)c_password;

- (void)sendUserOnServer;

- (NSDictionary *)dictionary;

@end
