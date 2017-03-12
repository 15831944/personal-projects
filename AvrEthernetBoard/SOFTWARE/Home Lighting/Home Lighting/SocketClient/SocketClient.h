//  ---------------------------------------------------------
//  Copyright (c) Neopost Inc., 2012. All rights reserved.   
//  ---------------------------------------------------------
//  Domain     -    IDFNetworks
//  Version    -    0.1
//  ---------------------------------------------------------
//  File Name  -    IDFHttpClient.h
//  Initiated  -    Neopost OSDC, FPT Software, G10-iOS Team.
//  Change History: 
//      - [06/25/2012][iOS Hanoi]: Creation.
//      - [Date][Author]: [Reason to modify]
//  ---------------------------------------------------------



#import <UIKit/UIKit.h>

@protocol SocketClientDelegate <NSObject>
@required
-(void)onReceiveData:(const unsigned char*)message length:(int)length;
-(void)onReceiveError:(int)status;
-(void)onReceiveTimeout;
-(void)onDisconnected;
-(void)onConnected;
@end

struct SocketClientRef;

@interface SocketClient : NSObject {
    struct SocketClientRef* sockClientRef;
}

@property (nonatomic, assign) id<SocketClientDelegate> delegate;

-(bool)connectToHost:(const char*)host port:(int)port;
-(bool)sendData:(const char*)buffer length:(int)length;
-(bool)closeConnection;

@end
