//
//  ANVLoginToMain.m
//  ikwitMVC
//
//  Created by Andrei Nechaev on 10/5/14.
//  Copyright (c) 2014 Andrei Nechaev. All rights reserved.
//

#import "ANVLoginToMain.h"

@implementation ANVLoginToMain

- (void)perform
{
    UIView *sv = ((UIViewController *)self.sourceViewController).view;
    UIView *dv = ((UIViewController *)self.destinationViewController).view;
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    dv.center = CGPointMake(sv.center.x + sv.frame.size.width,
                            dv.center.y);
    [window insertSubview:dv aboveSubview:sv];
    
    [UIView animateWithDuration:0.4
                     animations:^{
                         dv.center = CGPointMake(sv.center.x,
                                                 dv.center.y);
                         sv.center = CGPointMake(0 - sv.center.x,
                                                 dv.center.y);
                     }
                     completion:^(BOOL finished){
                         [[self sourceViewController] presentViewController:
                          [self destinationViewController] animated:NO completion:nil];
                     }];
}

@end
