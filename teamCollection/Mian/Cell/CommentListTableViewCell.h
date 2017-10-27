//
//  CommentListTableViewCell.h
//  teamCollection
//
//  Created by 八九点 on 16/8/5.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentListTableViewCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,strong)UIImageView * headImage;
@property(nonatomic,strong)UILabel * contentLabel;
@property(nonatomic,strong)UILabel * nameLabel;
@property(nonatomic,strong)UILabel * timeLabel;
@end
