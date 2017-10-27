//
//  studyHistoryCollectionViewCell.m
//  teamCollection
//
//  Created by 八九点 on 16/3/16.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "studyHistoryCollectionViewCell.h"

@implementation studyHistoryCollectionViewCell
-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        
        
        _mainImageView=[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 80, 80)];
        [self.contentView addSubview:_mainImageView];
        _titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(90, 5, self.contentView.frame.size.width-100, 10)];
        _titleLabel.font=[UIFont systemFontOfSize:13];
        [self.contentView addSubview:_titleLabel];
        _detailLabel=[[UILabel alloc]initWithFrame:CGRectMake(90, 20, self.contentView.frame.size.width-100,60)];
        _detailLabel.numberOfLines=0;
        _detailLabel.font=[UIFont systemFontOfSize:13];
        [self.contentView addSubview:_detailLabel];
        _categaryLabel=[[UILabel alloc]initWithFrame:CGRectMake(5,80, 50, 30)];
        _categaryLabel.font=[UIFont systemFontOfSize:12];
        [self.contentView addSubview:_categaryLabel];
        _lookTimeLabel=[[UILabel alloc]initWithFrame:CGRectMake(90, 80, 30, 30)];
        _lookTimeLabel.font=[UIFont systemFontOfSize:12];
        [self.contentView addSubview:_lookTimeLabel];
        _timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(200, 80, 80, 30)];
        _timeLabel.font=[UIFont systemFontOfSize:12];
        [self.contentView addSubview:_timeLabel];
        _downloadBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        
        
        _downloadBtn.frame=CGRectMake(self.contentView.frame.size.width-30, 80,20, 20);
        [_downloadBtn setBackgroundImage:[UIImage imageNamed:@"ic_system_update_tv_grey600_18dp"] forState:UIControlStateNormal];
//        [self.contentView addSubview:_downloadBtn];
        
        
        
        
        
    }
    return self;
}
@end
