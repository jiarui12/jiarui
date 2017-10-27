//
//  studyHistoryCollectionViewCell.h
//  teamCollection
//
//  Created by 八九点 on 16/3/16.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface studyHistoryCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UILabel * detailLabel;
@property(nonatomic,strong)UIImageView * mainImageView;
@property(nonatomic,strong)UILabel * categaryLabel;
@property(nonatomic,strong)UILabel * lookTimeLabel;
@property(nonatomic,strong)UILabel * timeLabel;
@property(nonatomic,strong)UIButton * downloadBtn;
@end
