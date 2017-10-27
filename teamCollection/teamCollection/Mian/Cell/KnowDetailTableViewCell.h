//
//  KnowDetailTableViewCell.h
//  teamCollection
//
//  Created by 八九点 on 16/1/18.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KnowledgeDetailDelegate <NSObject>

-(void)PresentVideoPlayerController:(UIButton *)button;

@end

@interface KnowDetailTableViewCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;


@property(nonatomic,strong)NSMutableDictionary * videoSource;


@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UILabel * nameLabel;
@property(nonatomic,strong)UILabel * timeLabel;
@property(nonatomic,strong)UILabel * categaryLabel;
@property(nonatomic,strong)UIImageView * iconImage;

@property(nonatomic,strong)UIImageView * rightIconView;

@property(nonatomic,strong)UIImageView * videoImageView;

@property(nonatomic,strong)UIWebView * webView;

@property(nonatomic,strong)UILabel * Label;

@property(nonatomic,strong)id<KnowledgeDetailDelegate>delegate;
@property(nonatomic,strong)NSString * Width;

@property(nonatomic,strong)NSString * name;
@property(nonatomic,strong)NSString * icon;
@property(nonatomic,strong)NSString * time;
@property(nonatomic,strong)NSString * categary;
@property(nonatomic,strong)NSString * Title;
@property(nonatomic,strong)NSMutableArray * rightIcons;
@property(nonatomic,strong)NSString * rightIcon;
@property(nonatomic,strong)NSString * videoImage;

@property(nonatomic,strong)NSString * content;

@property(nonatomic,strong)NSString * eggs;
@property(nonatomic,strong)NSString * flowers;

@property(nonatomic,strong)NSMutableArray * UserIDArr;

@property(nonatomic,strong)NSMutableArray * pListArr;

@property(nonatomic,assign)CGSize size;

@property(nonatomic,strong)UIImageView * pListIcon;
@end
