//
//  O2OTableViewCell.h
//  teamCollection
//
//  Created by 八九点 on 16/4/7.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface O2OTableViewCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property(nonatomic,strong)UIImageView * headImage;
@property(nonatomic,strong)UILabel * TitleLabel;
@property(nonatomic,strong)UILabel * focusLabel;
@property(nonatomic,strong)UILabel * viewLabel;
@property(nonatomic,strong)UILabel * timeLabel;


@end
