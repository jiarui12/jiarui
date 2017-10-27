//
//  TADotView.m
//  TAPageControl
//
//  Created by Tanguy Aladenise on 2015-01-22.
//  Copyright (c) 2015 Tanguy Aladenise. All rights reserved.
//

#import "TADotView.h"

@implementation TADotView


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

- (void)initialization
{
    self.backgroundColor    = [UIColor colorWithRed:213/255.0 green:213/255.0 blue:216/255.0 alpha:1.0];
    self.layer.cornerRadius = CGRectGetWidth(self.frame) / 2;
    self.layer.borderColor  = [UIColor colorWithRed:213/255.0 green:213/255.0 blue:216/255.0 alpha:1.0].CGColor;
    self.layer.borderWidth  = 2;
}


- (void)changeActivityState:(BOOL)active
{
    if (active) {
        self.backgroundColor = [UIColor whiteColor];
    } else {
        self.backgroundColor = [UIColor colorWithRed:213/255.0 green:213/255.0 blue:216/255.0 alpha:1.0];
    }
}

@end
