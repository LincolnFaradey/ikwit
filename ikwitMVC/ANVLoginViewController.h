//
//  ANVLoginViewController.h
//  ikwitMVC
//
//  Created by Andrei Nechaev on 7/7/14.
//  Copyright (c) 2014 Andrei Nechaev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANVConnectVCViewController.h"
#import "ANVSocketConnectionSingleton.h"

@interface ANVLoginViewController : ANVConnectVCViewController <UITextFieldDelegate, ANVSocketConnectionSingletonDelegate>

- (IBAction)unwindToLogin:(UIStoryboardSegue *)segue;
@end
