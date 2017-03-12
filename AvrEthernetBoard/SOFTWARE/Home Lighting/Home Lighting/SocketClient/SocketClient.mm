//  ---------------------------------------------------------
//  Copyright (c) Neopost Inc., 2012. All rights reserved.   
//  ---------------------------------------------------------
//  Domain     -    IDFNetworks
//  Version    -    0.1
//  ---------------------------------------------------------
//  File Name  -    IDFHttpClient.mm
//  Initiated  -    Neopost OSDC, FPT Software, G10-iOS Team.
//  Change History: 
//      - [06/25/2012][iOS Hanoi]: Creation.
//      - [Date][Author]: [Reason to modify]
//  ---------------------------------------------------------

#import "SocketClient.h"
#import "CDFSocketClient.h"

@interface SocketClient()
{
}

@end

@implementation SocketClient

@synthesize delegate;

struct SocketClientRef
{
public:
	SocketClientRef() : sockClient() {};
	CDFSocketClient sockClient;
};

-(id)init
{
	self = [super init];
	if (self != nil) {
		sockClientRef = new SocketClientRef();
	}
	return self;
}

-(void)dealloc
{
    sockClientRef->sockClient.Exit();
	delete sockClientRef;
	sockClientRef = NULL;
}

-(bool)closeConnection
{
    if (sockClientRef->sockClient.CloseSocket()==0) {
        return true;
    }
    return false;
}

-(void)setSocketReceiveBufferSize:(int)nRxBufferSize transmitBufferSize:(int)nTxBufferSize
{
    sockClientRef->sockClient.SetSocketBufferSize(nRxBufferSize, nTxBufferSize);
}

-(void)setReceiveTimeout:(int)nTimeout
{
    sockClientRef->sockClient.SetReceiveTimeout(nTimeout);
}

-(void)setSocketReusable:(bool)bSockReusable
{
    sockClientRef->sockClient.SetSocketReusable(bSockReusable);
}

static void OnSocketClientCallback(void* object, int status, const char* message, int length)
{
    @autoreleasepool {
        id<SocketClientDelegate> delegate = ((__bridge SocketClient*)object).delegate;
        if (delegate != nil) {
            switch (status) {
                case DF_SOCKET_TIMEOUT:
                    if([delegate respondsToSelector:@selector(onReceiveTimeout) ])
                        [delegate onReceiveTimeout];
                    break;
                case DF_SOCKET_NO_ERROR:
                    if([delegate respondsToSelector:@selector(onReceiveData:length:) ])
                        [delegate onReceiveData:(const unsigned char*)message length:length];
                    break;
                case DF_SOCKET_CONNECTED:
                    if([delegate respondsToSelector:@selector(onConnected) ])
                        [delegate onConnected];
                    break;
                case DF_SOCKET_DISCONNECTED:
                    if([delegate respondsToSelector:@selector(onDisconnected) ])
                        [delegate onDisconnected];
                    break;
                case DF_SOCKET_ERROR:
                default:
                    if([delegate respondsToSelector:@selector(onReceiveError:) ])
                        [delegate onReceiveError:status];
                    break;
            }
        }
    }
}

-(bool)connectToHost:(const char *)host port:(int)port
{
    sockClientRef->sockClient.InitThread((__bridge void*)self);
    sockClientRef->sockClient.SetObjectName("SOCKCLIENT");
    sockClientRef->sockClient.CreateSocket(host, port);
    sockClientRef->sockClient.SetSocketCallback(&OnSocketClientCallback);
    sockClientRef->sockClient.Start();
    return (sockClientRef->sockClient.Connect()==0)?true:false;
}

-(bool)sendData:(const char*)buffer length:(int)length
{
    return sockClientRef->sockClient.Send(buffer, length) > 0? true: false;
}

@end
