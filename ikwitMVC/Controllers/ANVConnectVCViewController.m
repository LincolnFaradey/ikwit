//
//  ANVConnectVCViewController.m
//  ikwit
//
//  Created by Andrei Nechaev on 11/19/14.
//  Copyright (c) 2014 Andrei Nechaev. All rights reserved.
//

#import "ANVConnectVCViewController.h"

static const UInt16 PORT = 1477;

@interface ANVConnectVCViewController ()

@end

@implementation ANVConnectVCViewController

@synthesize socket;
@synthesize indicatorView;

- (void)viewDidLoad {
    [super viewDidLoad];
    _mainView = self.view;
    socket = [[GCDAsyncSocket alloc] initWithDelegate:self
                                        delegateQueue:dispatch_get_main_queue()];
    socket.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initTCPConnectionOnPort:(UInt16)port
{
    NSError *err;
    
    if (![socket connectToHost:HOST onPort:port error:&err]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Connection"
                                                        message:@"You don't have a connection"
                                                       delegate:self cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        
        [alert show];
    }
}


- (void)showIndicator
{
    indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicatorView.hidesWhenStopped = YES;
    indicatorView.color = [UIColor blueColor];
    indicatorView.center = self.view.center;
    
    [self.view addSubview:indicatorView];
    [self enableAllFields:NO];
    [indicatorView startAnimating];
}

- (void)interruptAttempt:(NSNotification *)notification
{
    [socket disconnect];
    [self enableAllFields:YES];
    [indicatorView stopAnimating];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Too Long"
                                                    message:@"That takes too long time"
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    
    [socket disconnect];
    [self initTCPConnectionOnPort:PORT];
    [alert show];
    
}

- (void)socket:(GCDAsyncSocket *)sender didConnectToHost:(NSString *)host port:(UInt16)port
{
    NSLog(@"connected!");
}

- (void)loginSuccess:(NSNotification *)note
{
}


#pragma mark - Keyboard Control

- (void) keyboardWillShow:(NSNotification *)notification
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2]; // if you want to slide up the view
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    CGRect rect = self.mainView.frame;
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    if (screenSize.height < 480.0f) {
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
    if (screenSize.height < 480.0f) {
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



- (void)enableAllFields:(BOOL)response{
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self initTCPConnectionOnPort:PORT];
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



@end
