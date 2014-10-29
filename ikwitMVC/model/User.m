//
//  User.m
//  ikwitMVC
//
//  Created by Andrei Nechaev on 7/8/14.
//  Copyright (c) 2014 Andrei Nechaev. All rights reserved.
//

#import "User.h"

@interface User ()

@property (nonatomic)NSString *login;
@property (nonatomic)NSString *email;
@property (nonatomic)NSString *password;
@property (nonatomic)NSString *confirm_password;

- (BOOL) validateEmail: (NSString *)candidate;

@end

@implementation User

- (instancetype)init
{
    self = [self initWithLogin:@"undef"
                     withEmail:@"undef@mail.net"
                  withPassword:@"***undef***"
            andConfirmPassword:@"***undef***"];
    
    return self;
}

- (instancetype)initWithLogin:(NSString *)login
                    withEmail:(NSString *)email
                 withPassword:(NSString *)password
           andConfirmPassword:(NSString *)c_password
{
    self = [super init];
    
    if ([password isEqualToString:c_password]){
        
        
        if (self) {
            self.login = login;
            self.email = email;
            self.password = password;
        }
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"email invalid"
                                                        message:@"Write it again"
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"ok", nil];
        [alert show];
    }
    
    
    return self;
}

- (NSDictionary *)dictionary
{
//    NSDictionary *userD = [NSDictionary dictionaryWithObjectsAndKeys:
//                           self.login, @"login",
//                           self.email, @"email",
//                           self.password, @"password",
//                           nil];
    
    NSDictionary *userD = @{@"login": self.login,
                            @"email": self.email,
                            @"password": self.password};
    
    return userD;
}

- (void)sendUserOnServer
{
    NSError *writeError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self.dictionary options:NSJSONWritingPrettyPrinted error:&writeError];
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"JSON Output: %@", jsonString);
}


- (NSString *)description
{
    return [NSString stringWithFormat:@"\nUser with login: %@;\n email: %@;\n  and password: %@\n",
            self.login, self.email, self.password];
}

#pragma mark - overriden setters

- (void)setEmail:(NSString *)email
{
    if (![self validateEmail:email]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"email invalid"
                                                        message:@"Write it again"
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"ok", nil];
        [alert show];
    }
    _email = email;
}

- (void)setPassword:(NSString *)password
{
    if ([password isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"email invalid"
                                                        message:@"Write it again"
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"ok", nil];
        [alert show];
    }
    _password = password;
}

#pragma mark - data validation

- (BOOL) validateEmail: (NSString *)candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:candidate];
}

@end
