//
//  AppDelegate.h
//  Home Lighting
//
//  Created by Duong Dinh Cuong on 3/7/14.
//  Copyright (c) 2014 CuongQuay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SocketClient.h"

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ViewController *viewController;

@end
