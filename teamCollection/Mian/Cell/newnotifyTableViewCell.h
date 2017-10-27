//
//  newnotifyTableViewCell.h
//  teamCollection
//
//  Created by 八九点 on 2016/11/30.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface newnotifyTableViewCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (void)setCellWithCategory:(NSString *)cate andWithContentString:(NSString *)string andTimeString:(NSString*)time andTite:(NSString * )title;

@property(nonatomic,strong)UIImageView * headImageView;
@property(nonatomic,strong)UILabel * nameLabel;
@property(nonatomic,strong)UILabel * scoreLabel;
@property(nonatomic,strong)UILabel * rankLabel;
@property(nonatomic,strong)UILabel * detailLabel;
@property(nonatomic,strong)UILabel * numberLabel;
@property(nonatomic,strong)UILabel * timeLabel;
@property(nonatomic,strong)NSString* category;
@property(nonatomic,strong)UIView * shu;
@property(nonatomic,strong)UIImageView * detailImage;
@property(nonatomic,strong)UILabel * contentLabel;

@end
