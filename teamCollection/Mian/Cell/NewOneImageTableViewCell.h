//
//  NewOneImageTableViewCell.h
//  teamCollection
//
//  Created by 贾瑞 on 2017/5/17.
//  Copyright © 2017年 八九点. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewOneImageTableViewCell : UITableViewCell
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
