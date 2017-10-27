//
//  collectionKnowledgeTableViewCell.h
//  teamCollection
//
//  Created by 八九点 on 16/2/26.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface collectionKnowledgeTableViewCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,strong)UIImageView * mainImage;
@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UILabel * detailLabel;
@property(nonatomic,strong)UILabel * categaryLabel;
@property(nonatomic,strong)UILabel * timeLabel;

@end
