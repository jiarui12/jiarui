//
//  CloudBag1TableViewCell.h
//  teamCollection
//
//  Created by 八九点 on 16/1/18.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CloudBagDelegate <NSObject>

-(void)SkipToNextControllerOnClick:(UIButton *)button;

@end
@interface CloudBag1TableViewCell : UITableViewCell<UIScrollViewDelegate>
@property(nonatomic,strong)UIView * view1;
@property(nonatomic,strong)UIView * view2;
@property(nonatomic,strong)UIPageControl * page;
@property(nonatomic,assign)id<CloudBagDelegate>delegate;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,strong)UIImageView * headImage1;
@property(nonatomic,strong)UIImageView * headImage2;
@property(nonatomic,strong)UIImageView * headImage3;
@property(nonatomic,strong)UIImageView * headImage4;



@property(nonatomic,strong)UILabel * label1;
@property(nonatomic,strong)UILabel * label2;
@property(nonatomic,strong)UILabel * label3;
@property(nonatomic,strong)UILabel * label4;

@end
