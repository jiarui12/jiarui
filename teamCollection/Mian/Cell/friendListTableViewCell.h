//
//  friendListTableViewCell.h
//  teamCollection
//
//  Created by 八九点 on 2016/12/2.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface friendListTableViewCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property(nonatomic,strong)UIImageView * headImageView;
@property(nonatomic,strong)UILabel * nameLabel;
@property(nonatomic,strong)UIButton * gaunzhu;
@end
