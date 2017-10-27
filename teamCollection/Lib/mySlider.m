//
//  mySlider.m
//  teamCollection
//
//  Created by 八九点 on 2016/11/3.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "mySlider.h"

@implementation mySlider

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (CGRect)trackRectForBounds:(CGRect)bounds{
    return CGRectMake([UIScreen mainScreen].bounds.size.width *50/375,[UIScreen mainScreen].bounds.size.height*13/667,[UIScreen mainScreen].bounds.size.width*275/375,[UIScreen mainScreen].bounds.size.height *4/667);
}

@end
