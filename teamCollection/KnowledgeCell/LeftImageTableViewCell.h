//
//  LeftImageTableViewCell.h
//  teamCollection
//
//  Created by 八九点 on 16/7/6.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftImageTableViewCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UIImageView * OneImage;
@property(nonatomic,strong)UIImageView * TwoImage;
@property(nonatomic,strong)UIImageView * ThreeImage;


@property(nonatomic,strong)UILabel * nodeLabel;


@property(nonatomic,strong)UILabel * categaryLabel;
@property(nonatomic,strong)UIImageView * commentImage;
@property(nonatomic,strong)UIImageView * flowerImage;
@property(nonatomic,strong)UILabel * commentLabel;
@property(nonatomic,strong)UILabel * flowerLabel;

@property(nonatomic,strong)UILabel * DetailLabel;
@end
