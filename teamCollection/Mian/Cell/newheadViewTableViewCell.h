//
//  newheadViewTableViewCell.h
//  teamCollection
//
//  Created by 八九点 on 16/8/22.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface newheadViewTableViewCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,strong)UIImageView * headImage;
@property(nonatomic,strong)UILabel * nameLabel;
@end
