//
//  ANVSignUpViewController.m
//  ikwitMVC
//
//  Created by Andrei Nechaev on 7/7/14.
//  Copyright (c) 2014 Andrei Nechaev. All rights reserved.
//

#import "ANVSignUpViewController.h"
#import "ANVSocketConnectionSingleton.h"
#import "User.h"

@interface ANVSignUpViewController () {
    ANVSocketConnectionSingleton *connection;
}


@property (strong, nonatomic) IBOutlet UIView *mainView;

@property (weak, nonatomic) IBOutlet UITextField *loginTF;
@property (weak, nonatomic) IBOutlet UITextField *emailTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UITextField *conf_passwordTF;

@property (weak, nonatomic) IBOutlet UIButton *sign_up_button;

- (void) keyboardWillShow:(NSNotification *)notification;
- (void) keyboardWillBeHidden:(NSNotification *)notification;

@end

@implementation ANVSignUpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    connection = [ANVSocketConnectionSingleton sharedManager];
    _loginTF.delegate = self;
    _emailTF.delegate = self;
    _passwordTF.delegate = self;
    _conf_passwordTF.delegate = self;
    
    [_sign_up_button addTarget:self
                        action:@selector(signUpPressed:)
              forControlEvents:UIControlEventTouchDown];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2"]];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)signUpPressed:(id)sender
{
    NSData *data = [self prepareForServer];
    if (data) {
        [connection readAndWriteDataToSocket:data];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:6.0 target:self selector:@selector(interruptAttempt:) userInfo:nil repeats:NO];
        
        [self showIndicator];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Incorrect data"
                                                        message:@"Check all fields"
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"ok", nil];
        [alert show];
    }
}

- (NSData*)prepareForServer
{
    NSString *login = [_loginTF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *email = [_emailTF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *password = [_passwordTF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *c_password = [_conf_passwordTF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if ([self validateEmail:email]) {
        if ([password isEqualToString:c_password]) {
            NSDictionary *loginInformation = @{
                                               @"login" : login,
                                               @"email" : email,
                                               @"password" : password
                                               };
            
            NSData *data = [NSJSONSerialization dataWithJSONObject:loginInformation
                                                           options:NSJSONWritingPrettyPrinted
                                                             error:nil];
            return data;
        }
    }
    
    
    return nil;
}

-(void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSString *msg = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@", msg);
    if ([msg  isEqual: @"ok"]) {
        self.didGetResponse = YES;
        [[NSNotificationCenter defaultCenter] postNotificationName:TCP_NOTIFICATION_SUCCESS object:nil];
    }
}

- (void)loginSuccess:(NSNotification *)note
{
    [self.timer invalidate];
    [self.indicatorView stopAnimating];
    if (self.didGetResponse) {
        [self performSegueWithIdentifier:@"UnwindToLogin" sender:self];
    }
}

- (BOOL) validateEmail: (NSString *)candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:candidate];
}

#pragma mark - keyboard moving
- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary* info = [notification userInfo];
    CGSize kbSize = [info[UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    [UIView animateWithDuration:1.0f animations:^{
        CGRect rect = self.mainView.frame;
        rect.origin.y -= kbSize.height - 20;
        self.mainView.frame = rect;
    }];
}

- (void)keyboardWillBeHidden:(NSNotification *)notification
{
    NSDictionary* info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    [UIView animateWithDuration:1.0f animations:^{
        CGRect rect = self.mainView.frame;
        rect.origin.y += kbSize.height - 20;
        self.mainView.frame = rect;
    }];
}


@end
