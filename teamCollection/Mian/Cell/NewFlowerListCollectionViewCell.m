//
//  NewFlowerListCollectionViewCell.m
//  teamCollection
//
//  Created by 贾瑞 on 2017/5/22.
//  Copyright © 2017年 八九点. All rights reserved.
//

#import "NewFlowerListCollectionViewCell.h"
#define WIDTH  [UIScreen mainScreen].bounds.size.width

@implementation NewFlowerListCollectionViewCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //
        //        _pointImage  = [[UIImageView alloc] initWithFrame:CGRectMake(5, 8, 4, 4)];
        //        _pointImage.image=[UIImage imageNamed:@"diandian"];
        //
        //        [self.contentView addSubview:_pointImage];
        
        _headView=[[UIImageView alloc]initWithFrame:CGRectMake(12*WIDTH/375, 12*WIDTH/375, 36*WIDTH/375, 36*WIDTH/375)];
        
        _headView.layer.masksToBounds = YES;
        _headView.layer.cornerRadius=18*WIDTH/375;
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        // 新建一个红色的ColorRef，用于设置边框（四个数字分别是 r, g, b, alpha）
        CGColorRef borderColorRef = CGColorCreate(colorSpace,(CGFloat[]){ 223/255.0, 223/255.0, 223/255.0, 1 });
        _headView.layer.borderWidth=0.5;
        _headView.layer.borderColor=borderColorRef;
        [self.contentView addSubview:_headView];
        
        
        _titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 48*WIDTH/375,WIDTH/6 , 20*WIDTH/375)];
        _titlelabel.textAlignment = NSTextAlignmentCenter;
        
        _titlelabel.layer.masksToBounds=YES;
        _titlelabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        _titlelabel.font = [UIFont systemFontOfSize:WIDTH* 12/375];
        _titlelabel.backgroundColor=[UIColor whiteColor];
        [self.contentView addSubview:_titlelabel];
    }
    
    return self;
}
@end
