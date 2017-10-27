//
//  notifyMessageTableViewCell.h
//  teamCollection
//
//  Created by 八九点 on 2016/11/24.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface notifyMessageTableViewCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,strong)UIImageView * headImageView;
@property(nonatomic,strong)UILabel * nameLabel;
@property(nonatomic,strong)UILabel * scoreLabel;
@property(nonatomic,strong)UILabel * rankLabel;
@property(nonatomic,strong)UILabel * detailLabel;
@property(nonatomic,strong)UILabel * numberLabel;
@property(nonatomic,strong)UILabel * timeLabel;
@property(nonatomic,strong)NSString * iconURL;
@end
