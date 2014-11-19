//
//  ANVLoginViewController.m
//  ikwitMVC
//
//  Created by Andrei Nechaev on 7/7/14.
//  Copyright (c) 2014 Andrei Nechaev. All rights reserved.
//

#import "ANVLoginViewController.h"
#import "GCDAsyncSocket.h"
#import "DDIndicator.h"

@interface ANVLoginViewController ()

@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UITextField *loginTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;
@property (strong, nonatomic)GCDAsyncSocket *socket;
@property (nonatomic)BOOL didGetResponse;

@property (nonatomic)DDIndicator *indicator;
@property (nonatomic, weak)NSTimer *timer;

- (void) keyboardWillShow:(NSNotification *)notification;
- (void) keyboardWillBeHidden:(NSNotification *)notification;
- (void)initTCPConnection;

@end

@implementation ANVLoginViewController

@synthesize socket;

static NSString *TCP_NOTIFICATION_SUCCESS = @"Success";
static NSString *HOST = @"localhost";  //192.168.1.7 for homesharing

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
    
    socket = [[GCDAsyncSocket alloc] initWithDelegate:self
                                        delegateQueue:dispatch_get_main_queue()];
    socket.delegate = self;

    _loginTextField.delegate = self;
    _passwordTextField.delegate = self;
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)unwindToLogin:(UIStoryboardSegue *)segue
{
}

#pragma mark - tcp connection - notifications

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self initTCPConnection];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginSuccess:)
                                                 name:TCP_NOTIFICATION_SUCCESS
                                               object:nil];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:TCP_NOTIFICATION_SUCCESS
                                                  object:nil];
    [socket disconnect];
}



#pragma mark - Login button
- (IBAction)signInPressed:(id)sender {
    NSData *data = [self prepareForServer];
    
    [socket readDataWithTimeout:-1 tag:0]; //if you need to get more than one response
    [socket writeData:data withTimeout:-1 tag:1];
    
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

- (void)showIndicator
{
    _indicator = [[DDIndicator alloc] initWithFrame:CGRectMake(self.view.center.x - 15,
                                                               self.view.center.y - 80,
                                                               30, 30)];
    [self.view addSubview:_indicator];
    [self enableAllFields:NO];
    [_indicator startAnimating];
}

- (void)interruptAttempt:(NSNotification *)notification
{
    [socket disconnect];
    [self enableAllFields:YES];
    [_indicator stopAnimating];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Too Long"
                                                    message:@"That takes too long time"
                                                   delegate:self cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil, nil];
    [socket disconnect];
    [socket connectToHost:HOST onPort:1477 error:nil];
    [alert show];
    
}

#pragma mark - managing TCP connection

- (void)initTCPConnection
{
    NSError *err;
    
    if (![socket connectToHost:HOST onPort:1477 error:&err]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Connection"
                                                        message:@"You don't have a connection"
                                                       delegate:self cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        
        [alert show];
    }
}

- (void)socket:(GCDAsyncSocket *)sender didConnectToHost:(NSString *)host port:(UInt16)port
{
    NSLog(@"connected!");
}

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
    }
}

- (void)loginSuccess:(NSNotification *)note
{
    [self.timer invalidate];
    NSLog(@"NSN here");
    [_indicator stopAnimating];
    if (self.didGetResponse) {
        [self performSegueWithIdentifier:@"MainVC" sender:self];
    }
    [socket disconnect];
}


#pragma mark - Keyboard Control

- (void) keyboardWillShow:(NSNotification *)notification
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2]; // if you want to slide up the view
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    CGRect rect = self.mainView.frame;
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    if (screenSize.height > 480.0f) {
        
    } else {
        rect.origin.y -= 90;
    }
    
    
    self.mainView.frame = rect;
    
    [UIView commitAnimations];
}

- (void) keyboardWillBeHidden:(NSNotification *)notification
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2]; // if you want to slide up the view
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    CGRect rect = self.mainView.frame;
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    if (screenSize.height > 480.0f) {
        
    } else {
        rect.origin.y += 90;
    }
    
    self.mainView.frame = rect;
    
    [UIView commitAnimations];
}


-(BOOL)textFieldShouldReturn:(UITextField*)textField;
{
    NSInteger nextTag = textField.tag + 1;
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    if (nextResponder) {
        [nextResponder becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    return NO;
}

#pragma mark - View Control

- (void)enableAllFields:(BOOL)response{
    _signUpButton.enabled = response;
    _signInButton.enabled = response;
    _loginTextField.enabled = response;
    _passwordTextField.enabled = response;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(BOOL)shouldAutorotate
{
    
    return UIInterfaceOrientationMaskPortrait;
    
}

-(NSUInteger)supportedInterfaceOrientations
{
    
    return UIInterfaceOrientationMaskPortrait;
    
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    
    return UIInterfaceOrientationPortrait;
    
}

@end
