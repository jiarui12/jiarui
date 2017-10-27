//
//  NewSetTableViewCell.h
//  teamCollection
//
//  Created by 八九点 on 16/7/28.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewSetTableViewCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,strong)UIImageView * headImage;
@property(nonatomic,strong)UILabel * nameLabel;
@end
