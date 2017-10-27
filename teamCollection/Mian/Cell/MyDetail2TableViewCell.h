//
//  MyDetail2TableViewCell.h
//  teamCollection
//
//  Created by 八九点 on 16/5/15.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyDetail2TableViewCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,strong)UIImageView * headImageView;
@property(nonatomic,strong)UILabel * nameLabel;
@property(nonatomic,strong)UILabel * scoreLabel;
@property(nonatomic,strong)UILabel * rankLabel;

@end
