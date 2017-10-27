//
//  integralLevelTableViewCell.h
//  teamCollection
//
//  Created by 八九点 on 16/4/1.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface integralLevelTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel * levelNum;
@property(nonatomic,strong)UIImageView * levelIcon;
@property(nonatomic,strong)UILabel * levelName;
@property(nonatomic,strong)UILabel * integralNum;

+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
