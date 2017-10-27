//
//  touxiangTableViewCell.h
//  teamCollection
//
//  Created by 八九点 on 2016/12/1.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface touxiangTableViewCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;
-(void)setCellWithCategory:(NSString *)cate andContentDic:(NSDictionary *)dic andTime:(NSString *)time;
-(void)setcontentString:(NSString *)string;
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
@property(nonatomic,strong)UILabel * userLabel;
@property(nonatomic,strong)UILabel * contentLabel;
@property(nonatomic,strong)UILabel * catgorylabel;
@end
