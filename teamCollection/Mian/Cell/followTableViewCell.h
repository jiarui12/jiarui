//
//  followTableViewCell.h
//  teamCollection
//
//  Created by 八九点 on 16/2/25.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface followTableViewCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,strong)UIImageView * mainImageView;
@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UILabel * detailLabel;
@property(nonatomic,strong)UILabel * fromLabel;
@property(nonatomic,strong)UILabel * timeLabel;
@end
