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
    
    
    if ([password isEqualToString:c_password]){
        
        self = [super init];
        if (self) {
            self.login = login;
            self.email = email;
            self.password = password;
        }
    }else{
        @throw [NSException exceptionWithName:@"PasswordException" reason:@"uncampareble passwords" userInfo:nil];
    }
    
    return self;
}

- (NSDictionary *)dictionary
{
    NSDictionary *userD = [NSDictionary dictionaryWithObjectsAndKeys:
                           self.login, @"login",
                           self.email, @"email",
                           self.password, @"password",
                           nil];
    
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
        @throw [NSException exceptionWithName:@"EmailException" reason:@"not valid email" userInfo:nil];
    }
    _email = email;
}

- (void)setPassword:(NSString *)password
{
    if ([password isEqualToString:@""]) {
        @throw [NSException exceptionWithName:@"PasswordException" reason:@"not valid password" userInfo:nil];
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
