//
//  ANVConnectVCViewController.m
//  ikwit
//
//  Created by Andrei Nechaev on 11/19/14.
//  Copyright (c) 2014 Andrei Nechaev. All rights reserved.
//

#import "ANVConnectVCViewController.h"

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
    [self enableAllFields:YES];
    [indicatorView stopAnimating];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Too Long"
                                                    message:@"That takes too long time"
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    
    [alert show];
}


#pragma mark - Keyboard Control

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

- (void)enableAllFields:(BOOL)response{
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
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
    [socket disconnect];
}


#pragma mark - Autorotation disabled
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
