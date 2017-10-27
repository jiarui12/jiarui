//
//  JRPageControl.m
//  teamCollection
//
//  Created by 贾瑞 on 2017/4/18.
//  Copyright © 2017年 八九点. All rights reserved.
//

#import "JRPageControl.h"

@implementation JRPageControl

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //计算圆点间距
    CGFloat marginX = dotW + magrin;
    
    //计算整个pageControll的宽度
    CGFloat newW = (self.subviews.count - 1 ) * marginX;
    
    //设置新frame
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, newW, self.frame.size.height);
    
    //设置居中
    CGPoint center = self.center;
    center.x = self.superview.center.x;
    self.center = center;
    
    //遍历subview,设置圆点frame
    for (int i=0; i<[self.subviews count]; i++) {
        UIImageView* dot = [self.subviews objectAtIndex:i];
        
        if (i == self.currentPage) {
            [dot setFrame:CGRectMake(i * marginX, dot.frame.origin.y - 1, activeDotW, activeDotW)];
        }else {
            [dot setFrame:CGRectMake(i * marginX, dot.frame.origin.y, dotW, dotW)];
        }
    }
}

@end
