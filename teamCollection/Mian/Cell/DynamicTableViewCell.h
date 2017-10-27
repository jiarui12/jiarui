//
//  DynamicTableViewCell.h
//  teamCollection
//
//  Created by 八九点 on 16/4/11.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DynamicTableViewCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,strong)UILabel * TitleLabel;
@property(nonatomic,strong)UILabel * DetailLabel;

@end
