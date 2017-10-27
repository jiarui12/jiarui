//
//  newWeiKeTableViewCell.h
//  teamCollection
//
//  Created by 贾瑞 on 2017/5/31.
//  Copyright © 2017年 八九点. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol UnfoldDelegate <NSObject>

-(void)UnfoldCellDidClickUnfoldBtn;

@end
@interface newWeiKeTableViewCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
-(void)setIntroductionText:(NSString*)text;
-(void)setIntroductionText1:(NSString*)text;
@property(nonatomic,strong)UILabel * DetailLabel;
@property (nonatomic,weak)id<UnfoldDelegate>delegate;
@property (nonatomic,assign)NSInteger numberLines;
@end
