//
//  ANVAdditionalMethods.h
//  ikwit
//
//  Created by Andrey on 23.12.14.
//  Copyright (c) 2014 Andrei Nechaev. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ANVAdditionalMethods <NSObject>

- (void) keyboardWillShow:(NSNotification *)notification;
- (void) keyboardWillBeHidden:(NSNotification *)notification;

@end
