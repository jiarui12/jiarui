//
//  NewCommentTableViewCell.h
//  teamCollection
//
//  Created by 贾瑞 on 2017/5/17.
//  Copyright © 2017年 八九点. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WQLStarView.h"
@interface NewCommentTableViewCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
-(void)setIntroductionText:(NSString*)text;
@property(nonatomic,strong)UILabel * nameLabel;
@property(nonatomic,strong)UIImageView * OneImage;

@property(nonatomic,strong)UILabel * timeLabel;

@property(nonatomic,strong)UILabel * DetailLabel;

@property(nonatomic,strong)WQLStarView * starView;

@end
