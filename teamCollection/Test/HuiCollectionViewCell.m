//
//  HuiCollectionViewCell.m
//  teamCollection
//
//  Created by 八九点 on 16/7/27.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "HuiCollectionViewCell.h"

@implementation HuiCollectionViewCell


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        _iconImage=[[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/8-25,15, 46.875, 46.875)];
        
        [self.contentView addSubview:_iconImage];
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 80,self.contentView.frame.size.width , 20)];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        _nameLabel.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:_nameLabel];
        _iconImage.frame=CGRectMake([UIScreen mainScreen].bounds.size.width/8-25,15, [UIScreen mainScreen].bounds.size.width*50/375, [UIScreen mainScreen].bounds.size.width*50/375);
        _iconImage.center=CGPointMake([UIScreen mainScreen].bounds.size.width/6, [UIScreen mainScreen].bounds.size.width*50/375);
        _nameLabel.center=CGPointMake([UIScreen mainScreen].bounds.size.width/6, [UIScreen mainScreen].bounds.size.width*95/375);
        

    }
    
    return self;
}

@end
