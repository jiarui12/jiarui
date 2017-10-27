//
//  TAAnimatedDotView.m
//  TAPageControl
//
//  Created by Tanguy Aladenise on 2015-01-22.
//  Copyright (c) 2015 Tanguy Aladenise. All rights reserved.
//

#import "TAAnimatedDotView.h"

static CGFloat const kAnimateDuration = 1;

@implementation TAAnimatedDotView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialization];
    }
    
    return self;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialization];
    }
    return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialization];
    }
    
    return self;
}

- (void)setDotColor:(UIColor *)dotColor
{
    _dotColor = [UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0];
//    self.layer.borderColor  = [UIColor colorWithRed:213/255.0 green:213/255.0 blue:216/255.0 alpha:1.0].CGColor;
}

- (void)initialization
{
    _dotColor = [UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0];
    self.backgroundColor    = [UIColor colorWithRed:213/255.0 green:213/255.0 blue:216/255.0 alpha:1.0];
    self.layer.cornerRadius = CGRectGetWidth(self.frame) / 2;
}


- (void)changeActivityState:(BOOL)active
{
    if (active) {
        [self animateToActiveState];
    } else {
        [self animateToDeactiveState];
    }
}


- (void)animateToActiveState
{
    [UIView animateWithDuration:kAnimateDuration delay:0 usingSpringWithDamping:.5 initialSpringVelocity:-20 options:UIViewAnimationOptionCurveLinear animations:^{
        self.backgroundColor = _dotColor;
        self.transform = CGAffineTransformMakeScale(1.4, 1.4);
    } completion:nil];
}

- (void)animateToDeactiveState
{
    [UIView animateWithDuration:kAnimateDuration delay:0 usingSpringWithDamping:.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.backgroundColor = [UIColor colorWithRed:213/255.0 green:213/255.0 blue:216/255.0 alpha:1.0];
        self.transform = CGAffineTransformIdentity;
    } completion:nil];
}

@end
