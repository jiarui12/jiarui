//
//  newCepingTableViewCell.h
//  teamCollection
//
//  Created by 贾瑞 on 2017/5/26.
//  Copyright © 2017年 八九点. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface newCepingTableViewCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;

@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UILabel * timeLabel;
@property(nonatomic,strong)UILabel * jiezhiLabel;
@property(nonatomic,strong)UILabel * zongfenLabel;
@property(nonatomic,strong)UIButton * jinruBtn;
@end
