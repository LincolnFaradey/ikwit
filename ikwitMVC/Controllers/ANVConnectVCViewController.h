//
//  ANVConnectVCViewController.h
//  ikwit
//
//  Created by Andrei Nechaev on 11/19/14.
//  Copyright (c) 2014 Andrei Nechaev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCDAsyncSocket.h"

static NSString *TCP_NOTIFICATION_SUCCESS = @"Success";
static NSString *HOST = @"192.168.1.7";  //192.168.1.7 for homesharing

@interface ANVConnectVCViewController : UIViewController

@property (strong, nonatomic)UIView *mainView;
@property (strong, nonatomic)GCDAsyncSocket *socket;
@property (retain, nonatomic)UIActivityIndicatorView *indicatorView;
@property (assign, nonatomic)BOOL didGetResponse;
@property (nonatomic, weak)NSTimer *timer;

- (void)showIndicator;
- (void)interruptAttempt:(NSNotification *)notification;

@end
