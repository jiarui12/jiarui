//
//  commentTableViewCell.h
//  teamCollection
//
//  Created by 八九点 on 16/3/17.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface commentTableViewCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,strong)UILabel * commentLabel;
@property(nonatomic,strong)UIImageView * titleImage;
@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UILabel * timeLabel;
@end
