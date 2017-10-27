//
//  Header1TableViewCell.h
//  teamCollection
//
//  Created by 八九点 on 16/1/15.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircularProgressView.h"
#import "ToggleButton.h"
@protocol SkipToMyDelegate <NSObject>

-(void)SkipToMyControllerOnClick:(UIButton *)button;

@end
@interface Header1TableViewCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,strong)NSString * ImageUrl;
@property(nonatomic,strong)NSString * userName;
@property (strong, nonatomic) UIImageView *headImageView;
@property(nonatomic,strong)CircularProgressView * circularView;
@property(nonatomic,strong)UILabel * nameLabel;
@property(nonatomic,strong)UIImageView * scoreImage;
@property(nonatomic,strong)UIImageView * levelImage;
@property(nonatomic,strong)UILabel * scoreLabel;
@property(nonatomic,strong)UILabel * levelLabel;
@property(nonatomic,weak)id<SkipToMyDelegate>delegate;




@end
