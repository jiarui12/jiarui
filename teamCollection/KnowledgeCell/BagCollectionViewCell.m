//
//  BagCollectionViewCell.m
//  teamCollection
//
//  Created by 八九点 on 16/7/25.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "BagCollectionViewCell.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
@implementation BagCollectionViewCell
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
        
        _titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,104 * WIDTH/375 , WIDTH* 36/375)];
        _titlelabel.textAlignment = NSTextAlignmentCenter;
        
        _titlelabel.layer.masksToBounds=YES;
        _titlelabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        _titlelabel.font = [UIFont systemFontOfSize:WIDTH* 14/375];
        _titlelabel.backgroundColor=[UIColor whiteColor];
        self.titlelabel.layer.cornerRadius=4;
        [self.contentView addSubview:_titlelabel];
    }
   
    return self;
}
@end
