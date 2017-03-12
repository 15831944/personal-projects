//
//  ViewController.h
//  Home Lighting
//
//  Created by Duong Dinh Cuong on 3/7/14.
//  Copyright (c) 2014 CuongQuay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SocketClient.h"
#import "SwitchButton.h"

@interface ViewController : UIViewController <SocketClientDelegate>

@property (weak, nonatomic) IBOutlet SwitchButton *switchOne;
@property (weak, nonatomic) IBOutlet SwitchButton *switchTwo;
@property (weak, nonatomic) IBOutlet SwitchButton *switchThree;
@property (weak, nonatomic) IBOutlet SwitchButton *switchFour;
@property (weak, nonatomic) IBOutlet SwitchButton *switchFive;
@property (weak, nonatomic) IBOutlet SwitchButton *powerButton;
@property (strong, nonatomic) SocketClient* socketClient;

- (IBAction)didTapPower:(id)sender;

- (IBAction)swipeGesture:(id)sender;
- (IBAction)didTapSwitchOne:(id)sender;
- (IBAction)didTapSwitchTwo:(id)sender;
- (IBAction)didTapSwitchThree:(id)sender;
- (IBAction)didTapSwitchFour:(id)sender;
- (IBAction)didTapSwitchFive:(id)sender;

@end
