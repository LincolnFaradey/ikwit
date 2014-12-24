//
//  ANVConnectVCViewController.h
//  ikwit
//
//  Created by Andrei Nechaev on 11/19/14.
//  Copyright (c) 2014 Andrei Nechaev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANVAdditionalMethods.h"

static NSString *TCP_NOTIFICATION_SUCCESS = @"Success";

@interface ANVConnectVCViewController : UIViewController <ANVAdditionalMethods>

@property (strong, nonatomic)UIView *mainView;
@property (retain, nonatomic)UIActivityIndicatorView *indicatorView;
@property (assign, nonatomic)BOOL didGetResponse;
@property (nonatomic, weak)NSTimer *timer;

- (void)showIndicator;
- (void)enableAllFields:(BOOL)response;
- (void)interruptAttempt:(NSNotification *)notification;


@end
