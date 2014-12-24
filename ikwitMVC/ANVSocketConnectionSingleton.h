//
//  ANVSocketConnectionSingleton.h
//  ikwit
//
//  Created by Andrei Nechaev on 12/4/14.
//  Copyright (c) 2014 Andrei Nechaev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GCDAsyncSocket;

@protocol ANVSocketConnectionSingletonDelegate
@optional
- (void)didReceiveData:(NSData *)data;

@end

@interface ANVSocketConnectionSingleton : NSObject {
    GCDAsyncSocket *socket;
}

@property (nonatomic, weak)id <ANVSocketConnectionSingletonDelegate> delegate;

+ (id)sharedManager;
- (void)connectToPort:(UInt16)port;
- (void)readAndWriteDataToSocket:(NSData *)data;
- (void)disconnectSocket;

@end
