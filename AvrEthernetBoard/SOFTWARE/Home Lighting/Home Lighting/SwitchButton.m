//
//  SwitchButton.m
//  Home Lighting
//
//  Created by Duong Dinh Cuong on 3/17/14.
//  Copyright (c) 2014 CuongQuay. All rights reserved.
//

#import "SwitchButton.h"

@implementation SwitchButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIPanGestureRecognizer* panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    }
    return self;
}

- (void)setTogglePosition:(float)positonValue ended:(BOOL)isEnded
{
}

- (void)handlePanGesture:(UIPanGestureRecognizer*) sender {
    
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        CGPoint currentPoint = [sender locationInView:self];
        float position = currentPoint.x;
        float positionValue = position / self.frame.size.width;
        
        if (positionValue < 1.f && positionValue > 0.f)
        {
            [self setTogglePosition:positionValue ended:NO];
        }
    }
    
    if (sender.state == UIGestureRecognizerStateChanged)
    {
        CGPoint currentPoint = [sender locationInView:self];
        float position = currentPoint.x;
        float positionValue = position / self.frame.size.width;
        
        if (positionValue < 1.f && positionValue > 0.f)
        {
            [self setTogglePosition:positionValue ended:NO];
        }
    }
    
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        
        CGPoint currentPoint = [sender locationInView:self];
        float position = currentPoint.x;
        float positionValue = position / self.frame.size.width;
        
        if (positionValue < 1.f && positionValue > 0.f)
        {
            [self setTogglePosition:positionValue ended:YES];
        }
        else if (positionValue >= 1.f)
        {
            [self setTogglePosition:1.f ended:YES];
        }
        else if (positionValue <= 0.f)
        {
            [self setTogglePosition:0.f ended:YES];
        }
    }
}

@end
