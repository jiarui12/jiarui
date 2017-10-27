//
//  newStudyCalendarTableViewCell.h
//  teamCollection
//
//  Created by 贾瑞 on 2017/6/13.
//  Copyright © 2017年 八九点. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface newStudyCalendarTableViewCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,strong)UILabel * titleLabel;


@property(nonatomic,strong)UILabel * nodeLabel;


@property(nonatomic,strong)UILabel * categaryLabel;

@end
