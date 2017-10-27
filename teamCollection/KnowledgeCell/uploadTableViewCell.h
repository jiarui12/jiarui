//
//  uploadTableViewCell.h
//  teamCollection
//
//  Created by 八九点 on 2016/11/6.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import <UIKit/UIKit.h>
@class uploadTableViewCell;
@protocol TableViewCellDelegate <NSObject>

- (void)cell:(uploadTableViewCell *)cell didClickedBtn:(UIButton *)btn;
-(void)refreshData;
@end
@interface uploadTableViewCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,strong)UIImageView * headImage;
@property(nonatomic,strong)UILabel * titleLabel;

@property(nonatomic,strong)UIImageView * videoImage;

@property(nonatomic,strong)UILabel * categaryLabel;

@property(nonatomic,strong)UIProgressView * progress;

@property(nonatomic,strong)UILabel * uploadStatus;

@property(nonatomic,strong)UILabel * percentLabel;

@property(nonatomic,strong)UILabel * nodeLabel;
@property(nonatomic,strong)UILabel * DetailLabel;
@property (nonatomic,copy)NSString *url;

@property (nonatomic, weak) id <TableViewCellDelegate> delegate;
@end
