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
//@property (nonatomic)CDActivityIndicatorView *aiv;
@property (nonatomic)DDIndicator *indicator;
@property (nonatomic, weak)NSTimer *timer;

- (void) keyboardWillShow:(NSNotification *)notification;
- (void) keyboardWillBeHidden:(NSNotification *)notification;
- (void)initTCPConnection;

@end

@implementation ANVLoginViewController

@synthesize socket;
//@synthesize aiv;

static NSString *TCP_NOTIFICATION_SUCCESS = @"Success";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.loginTextField.tag = 1;
        self.passwordTextField.tag = 2;
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
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)unwindToLogin:(UIStoryboardSegue *)segue
{
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - keyboard moving, tcp connection - notifications

- (void)viewWillAppear:(BOOL)animated
{
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

#pragma mark - Login button
- (IBAction)signInPressed:(id)sender {
    NSString *login = [_loginTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *password = [_passwordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSDictionary *loginInformation = @{@"login" : login, @"password" : password};

    NSData *data = [NSJSONSerialization dataWithJSONObject:loginInformation
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:nil];
    [socket readDataWithTimeout:-1 tag:0]; //if you need to get more than one response
    [socket writeData:data withTimeout:-1 tag:1];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(interruptAttempt:) userInfo:nil repeats:NO];

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
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Too Long" message:@"That takes too long time" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

#pragma mark - help methods creaing underlayer

- (void)enableAllFields:(BOOL)resp{
    _signUpButton.enabled = resp;
    _signInButton.enabled = resp;
    _loginTextField.enabled = resp;
    _passwordTextField.enabled = resp;
}

#pragma mark - managing TCP connection

- (void)initTCPConnection
{
    NSError *err;
    
    if (![socket connectToHost:@"192.168.1.7" onPort:1477 error:&err]) { //192.168.1.7 for homesharing
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Connection" message:@"You don't connect to Web" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
    }
}

- (void)socket:(GCDAsyncSocket *)sender didConnectToHost:(NSString *)host port:(UInt16)port
{
    NSLog(@"connected!");
    //[socket readDataWithTimeout:-1 tag:0]; //read just once
}

-(void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    
    NSString *msg = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    self.didGetResponse = [msg isEqualToString:@"ok"] ? YES : NO;
    
    if (self.didGetResponse) [[NSNotificationCenter defaultCenter] postNotificationName:TCP_NOTIFICATION_SUCCESS object:nil];
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

#pragma mark - orintation
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
