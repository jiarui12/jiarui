//
//  SettingHeadTableViewCell.h
//  teamCollection
//
//  Created by 八九点 on 16/1/13.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingHeadTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property(strong,nonatomic)UISwitch * Switch;

@end
