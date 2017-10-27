//
//  OneImageTableViewCell.h
//  teamCollection
//
//  Created by 八九点 on 16/7/5.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OneImageTableViewCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,strong)UIImageView * headImage;
@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UILabel * percentLabel;
@property(nonatomic,strong)UIImageView * videoImage;
@property(nonatomic,strong)UILabel * videoTimeLabel;
@property(nonatomic,strong)UILabel * categaryLabel;
@property(nonatomic,strong)UIImageView * commentImage;
@property(nonatomic,strong)UIImageView * flowerImage;
@property(nonatomic,strong)UILabel * commentLabel;
@property(nonatomic,strong)UILabel * flowerLabel;
@property(nonatomic,strong)UIImageView * AuthenticateImage;
@property(nonatomic,strong)UILabel * AuthenticateLabel;
@property(nonatomic,strong)UILabel * nodeLabel;
@property(nonatomic,strong)UILabel * DetailLabel;
@property(nonatomic,strong)UIProgressView * progress;
@end
