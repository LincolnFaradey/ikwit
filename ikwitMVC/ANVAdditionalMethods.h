//
//  ANVAdditionalMethods.h
//  ikwit
//
//  Created by Andrey on 24.12.14.
//  Copyright (c) 2014 Andrei Nechaev. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ANVAdditionalMethods <NSObject>
@optional
- (void)keyboardWillShow:(NSNotification *)notification;
- (void)keyboardWillBeHidden:(NSNotification *)notification;

@end
