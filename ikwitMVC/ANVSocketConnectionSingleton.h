//
//  ANVSocketConnectionSingleton.h
//  ikwit
//
//  Created by Andrei Nechaev on 12/4/14.
//  Copyright (c) 2014 Andrei Nechaev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GCDAsyncSocket;

@interface ANVSocketConnectionSingleton : NSObject {
    GCDAsyncSocket *socket;
}

+ (id)sharedManager;
- (void)connectToPort:(UInt16)port;
- (void)readAndWriteDataToSocket:(NSData *)data;
- (void)disconectSocket;

@end
