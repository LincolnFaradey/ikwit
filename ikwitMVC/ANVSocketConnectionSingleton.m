//
//  ANVSocketConnectionSingleton.m
//  ikwit
//
//  Created by Andrei Nechaev on 12/4/14.
//  Copyright (c) 2014 Andrei Nechaev. All rights reserved.
//

#import "ANVSocketConnectionSingleton.h"
#import "GCDAsyncSocket.h"

@interface ANVSocketConnectionSingleton ()

@property (nonatomic)GCDAsyncSocket *socket;

@end

@implementation ANVSocketConnectionSingleton
@synthesize socket;

static NSString *HOST_NAME = @"192.168.1.7";

+ (id)sharedManager
{
    static ANVSocketConnectionSingleton *socketSingleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        socketSingleton = [[ANVSocketConnectionSingleton alloc] init];
    });
    
    return socketSingleton;
}

- (id)init
{
    if (self = [super init]) {
        socket = [[GCDAsyncSocket alloc] initWithDelegate:self
                                            delegateQueue:dispatch_get_main_queue()];
        socket.delegate = self;
    }
    
    return self;
}

- (void)connectToPort:(UInt16)port
{
    NSError *err;
    if (![socket connectToHost:HOST_NAME onPort:port error:&err]) {
        //TODO Alert
        NSLog(@"unabe to connect to port: %ui", port);
    }
}

- (void)socket:(GCDAsyncSocket *)sender didConnectToHost:(NSString *)host port:(UInt16)port
{
    NSLog(@"Connected");
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    
}


@end
