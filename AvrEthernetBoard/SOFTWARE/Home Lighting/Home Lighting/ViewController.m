//
//  ViewController.m
//  Home Lighting
//
//  Created by Duong Dinh Cuong on 3/7/14.
//  Copyright (c) 2014 CuongQuay. All rights reserved.
//

#import "ViewController.h"
#import "FBSquareFontView.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)(((rgbValue) & 0xFF0000) >> 16))/255.0 green:((float)(((rgbValue) & 0xFF00) >> 8))/255.0 blue:((float)((rgbValue) & 0xFF))/255.0 alpha:1.0]

#define IS_SWITCH_ONE(data)      ((data & 1<<6)==1<<6)
#define IS_SWITCH_TWO(data)      ((data & 1<<5)==1<<5)
#define IS_SWITCH_THREE(data)    ((data & 1<<4)==1<<4)
#define IS_SWITCH_FOUR(data)     ((data & 1<<3)==1<<3)
#define IS_SWITCH_FIVE(data)     ((data & 1<<2)==1<<2)


@interface ViewController ()
{
    bool isConnected;
    unsigned char buttonState;
    FBSquareFontView* labelOne;
    FBSquareFontView* labelTwo;
    FBSquareFontView* labelThree;
    FBSquareFontView* labelFour;
    FBSquareFontView* labelFive;
}

- (FBSquareFontView*)setRoomLabel:(NSString*)label onView:(UIView*)frame state:(BOOL)onOff;

@end

@implementation UIView (FBSquareFontView)
- (void)centerizeInHeight:(CGFloat)height
{
    self.frame = CGRectMake(self.frame.origin.x,
                            (height - self.frame.size.height)/2.0,
                            self.frame.size.width,
                            self.frame.size.height);
}
-(void)setRoomOnOff:(BOOL)onOff
{
    ((FBSquareFontView*)self).glowColor = UIColorFromRGB(onOff?0x0db1eb:0xe0f3fa);
    ((FBSquareFontView*)self).innerGlowColor = UIColorFromRGB(onOff?0x0db1eb:0xe0f3fa);
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
    
    labelOne = [self setRoomLabel:@"KITCHEN" onView:self.switchOne state:self.switchOne.selected];
    labelTwo = [self setRoomLabel:@"LIVROOM" onView:self.switchTwo state:self.switchTwo.selected];
    labelThree = [self setRoomLabel:@"AIRCON1" onView:self.switchThree state:self.switchThree.selected];
    labelFour = [self setRoomLabel:@"AIRCON2" onView:self.switchFour state:self.switchFour.selected];
    labelFive = [self setRoomLabel:@"HEATSYS" onView:self.switchFive state:self.switchFive.selected];
    
    buttonState = 0x00;
}

#pragma mark - ToggleViewDelegate

- (void)selectLeftButton
{
    NSLog(@"LeftButton Selected");
}

- (void)selectRightButton
{
    NSLog(@"RightButton Selected");
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

- (FBSquareFontView*)setRoomLabel:(NSString*)label onView:(UIView*)view state:(BOOL)onOff
{
    CGRect rect = CGRectMake(view.frame.origin.x + 135, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
    FBSquareFontView *viewLabel = [[FBSquareFontView alloc] initWithFrame:rect];
    viewLabel.text = label;
    viewLabel.lineWidth = 3.0;
    viewLabel.lineCap = kCGLineCapRound;
    viewLabel.lineJoin = kCGLineJoinRound;
    viewLabel.margin = 12.0;
    viewLabel.backgroundColor = [[UIColor alloc] initWithWhite:1.0 alpha:0.0];
    viewLabel.horizontalPadding = 10;
    viewLabel.verticalPadding = 14;
    viewLabel.glowSize = 10.0;
    viewLabel.glowColor = UIColorFromRGB(onOff?0x0db1eb:0xe0f3fa);
    viewLabel.innerGlowColor = UIColorFromRGB(onOff?0x0db1eb:0xe0f3fa);
    viewLabel.lineColor = UIColorFromRGB(0xffffff); 
    viewLabel.innerGlowSize = 2.0;
    viewLabel.verticalEdgeLength = 6;
    viewLabel.horizontalEdgeLength = 4;
    [view addSubview:viewLabel];
    [viewLabel resetSize];
    [viewLabel centerizeInHeight:view.frame.size.height];
    
    return viewLabel;
}

-(void)onConnected
{
    unsigned char buffer[] = {0x55, 0x00, 0x00, 0x00, 0xAA};
    [self.socketClient sendData:(const char*)buffer length:5];
    
    self.powerButton.selected = true;
    self.powerButton.enabled = true;
    self.switchOne.enabled = true;
    self.switchTwo.enabled = true;
    self.switchThree.enabled = true;
    self.switchFour.enabled = true;
    self.switchFive.enabled = true;
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void)disableControlPanel
{
    [self rotatePowerButton:NO];
    
    self.powerButton.selected = false;
    self.powerButton.enabled = true;
    
    self.switchOne.enabled = false;
    self.switchTwo.enabled = false;
    self.switchThree.enabled = false;
    self.switchFour.enabled = false;
    self.switchFive.enabled = false;
    
    self.switchOne.selected = true;
    self.switchTwo.selected = true;
    self.switchThree.selected = true;
    self.switchFour.selected = true;
    self.switchFive.selected = true;
    
}

-(void)onDisconnected
{
    [self performSelectorOnMainThread:@selector(disableControlPanel) withObject:nil waitUntilDone:NO];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

-(void)updateDataOnMainThread:(NSNumber*)object
{
    self.switchOne.selected = IS_SWITCH_ONE([object intValue])? true: false;
    self.switchTwo.selected = IS_SWITCH_TWO([object intValue])? true: false;
    self.switchThree.selected = IS_SWITCH_THREE([object intValue])? true: false;
    self.switchFour.selected = IS_SWITCH_FOUR([object intValue])? true: false;
    self.switchFive.selected = IS_SWITCH_FIVE([object intValue])? true: false;
    [labelOne setRoomOnOff:self.switchOne.selected];
    [labelTwo setRoomOnOff:self.switchTwo.selected];
    [labelThree setRoomOnOff:self.switchThree.selected];
    [labelFour setRoomOnOff:self.switchFour.selected];
    [labelFive setRoomOnOff:self.switchFive.selected];
}

-(void)onReceiveData:(const unsigned char *)message length:(int)length
{
    if ( (message[0]==0x55) && (message[1]==0x00) && (message[4]==0xAA) ) {
        [self performSelectorOnMainThread:@selector(updateDataOnMainThread:) withObject:[NSNumber numberWithInt:message[2]] waitUntilDone:YES];
        NSLog(@"%02X%02X%02X%02X%02X",message[0],message[1],message[2],message[3],message[4]);
        buttonState = message[2];
    }
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

-(void)onReceiveError:(int)status
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

-(void)onReceiveTimeout
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void)OnConnectToDevice:(id)sender
{
    self.powerButton.enabled = false;
    if (self.powerButton.selected) {
        if ([self.socketClient closeConnection]) {
            [self onDisconnected];
        }
    } else {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        if ([self.socketClient connectToHost:"192.168.1.5" port:1681] == false) {
            [self onDisconnected];
        }
    }
}

-(void)rotatePowerButton:(BOOL)clockwise
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.3];
    
    self.powerButton.transform = CGAffineTransformRotate(self.powerButton.transform, clockwise?M_PI:0);
    
    [UIView commitAnimations];
}

- (IBAction)didTapPower:(id)sender
{
    [self rotatePowerButton:YES];
    [self performSelectorInBackground:@selector(OnConnectToDevice:) withObject:self];
}

- (IBAction)swipeGesture:(id)sender
{
    unsigned char buffer[] = {0x55, 0x00, 0x00, 0x00, 0xAA};
    [self.socketClient sendData:(const char*)buffer length:5];
}

- (IBAction)didTapSwitchOne:(id)sender
{
    unsigned char buffer[] = {0x55, 0x01, 0x00, 0x00, 0xAA};
    buffer[2] = self.switchOne.selected?(buttonState & ~(1<<6)):(buttonState | 1<<6);
    [self.socketClient sendData:(const char*)buffer length:5];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (IBAction)didTapSwitchTwo:(id)sender
{
    unsigned char buffer[] = {0x55, 0x01, 0x00, 0x00, 0xAA};
    buffer[2] = self.switchTwo.selected?(buttonState & ~(1<<5)):(buttonState | 1<<5);
    [self.socketClient sendData:(const char*)buffer length:5];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (IBAction)didTapSwitchThree:(id)sender
{
    unsigned char buffer[] = {0x55, 0x01, 0x00, 0x00, 0xAA};
    buffer[2] = self.switchThree.selected?(buttonState & ~(1<<4)):(buttonState | 1<<4);
    [self.socketClient sendData:(const char*)buffer length:5];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];

}

- (IBAction)didTapSwitchFour:(id)sender
{
    unsigned char buffer[] = {0x55, 0x01, 0x00, 0x00, 0xAA};
    buffer[2] = self.switchFour.selected?(buttonState & ~(1<<3)):(buttonState | 1<<3);
    [self.socketClient sendData:(const char*)buffer length:5];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];

}

- (IBAction)didTapSwitchFive:(id)sender
{
    unsigned char buffer[] = {0x55, 0x01, 0x00, 0x00, 0xAA};
    buffer[2] = self.switchFive.selected?(buttonState & ~(1<<2)):(buttonState | 1<<2);
    [self.socketClient sendData:(const char*)buffer length:5];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];

}
@end
