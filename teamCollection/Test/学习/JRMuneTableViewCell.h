//
//  JRMuneTableViewCell.h
//  teamCollection
//
//  Created by 贾瑞 on 2017/4/27.
//  Copyright © 2017年 八九点. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JRMuneTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel * label;
+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
