//
//  ANVLoginViewController.m
//  ikwitMVC
//
//  Created by Andrei Nechaev on 7/7/14.
//  Copyright (c) 2014 Andrei Nechaev. All rights reserved.
//

#import "ANVLoginViewController.h"
#import "GCDAsyncSocket.h"

@interface ANVLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *loginTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;

@end

@implementation ANVLoginViewController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    _loginTextField.delegate = self;
    _passwordTextField.delegate = self;
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)unwindToLogin:(UIStoryboardSegue *)segue
{
    
}

#pragma mark - tcp connection - notifications

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}



#pragma mark - Login button
- (IBAction)signInPressed:(id)sender {
    NSData *data = [self prepareForServer];
    [self.socket readDataWithTimeout:-1 tag:0]; //if you need to get more than one response
    [self.socket writeData:data withTimeout:-1 tag:1];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:6.0 target:self selector:@selector(interruptAttempt:) userInfo:nil repeats:NO];

    [self showIndicator];
}

- (NSData*)prepareForServer
{
    NSString *login = [_loginTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *password = [_passwordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSDictionary *loginInformation = @{@"login" : login, @"password" : password};
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:loginInformation
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:nil];
    
    return data;
}



#pragma mark - managing TCP connection

-(void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    
    NSString *msg = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@", msg);
    self.didGetResponse = ([msg length] >= 40) ? YES : NO;
    
    if (self.didGetResponse)
    {
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        
        [userDefault setObject:msg forKey:@"Token"];
        if ([userDefault synchronize]){
            [[NSNotificationCenter defaultCenter] postNotificationName:TCP_NOTIFICATION_SUCCESS object:nil];
        }
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Incorrect user data"
                                                            message:@"Wrong login/password"
                                                           delegate:self
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"Ok", nil];
        [self.timer invalidate];
        [self enableAllFields:YES];
        [self.indicatorView stopAnimating];
        [alertView show];
    }
}

- (void)loginSuccess:(NSNotification *)note
{
    [self.timer invalidate];
    [self.indicatorView stopAnimating];
    if (self.didGetResponse) {
        [self performSegueWithIdentifier:@"MainVC" sender:self];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:_loginTextField.text forKey:@"User"];
        [userDefaults synchronize];
    }
    [self.socket disconnect];
}

#pragma mark - View Control

- (void)enableAllFields:(BOOL)response{
//    _signUpButton.enabled = response;
    _signInButton.enabled = response;
    _loginTextField.enabled = response;
    _passwordTextField.enabled = response;
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary* info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    [UIView animateWithDuration:1.0f animations:^{
        if ([[UIScreen mainScreen] bounds].size.height < 500.0f) {
            CGRect rect = self.mainView.frame;
            rect.origin.y -= kbSize.height - 60;
            self.mainView.frame = rect;
        }
    }];
}

- (void)keyboardWillBeHidden:(NSNotification *)notification
{
    NSDictionary* info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    [UIView animateWithDuration:1.0f animations:^{
        if ([[UIScreen mainScreen] bounds].size.height < 500.0f) {
            CGRect rect = self.mainView.frame;
            rect.origin.y += kbSize.height - 60;
            self.mainView.frame = rect;
        }
    }];
}


@end
