//
//  myLocalValueTableViewCell.h
//  teamCollection
//
//  Created by 八九点 on 16/3/21.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myLocalValueTableViewCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,strong)UIImageView * headImage;
@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UILabel * categaryLabel;
@property(nonatomic,strong)UILabel * stateLabel;
@end
