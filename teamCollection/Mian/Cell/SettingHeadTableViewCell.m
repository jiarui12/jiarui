//
//  SettingHeadTableViewCell.m
//  teamCollection
//
//  Created by 八九点 on 16/1/13.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "SettingHeadTableViewCell.h"

@implementation SettingHeadTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    _Switch=[[UISwitch alloc]initWithFrame:CGRectMake(self.contentView.frame.size.width-70, 15,100 , 28)];
    [_Switch addTarget:self action:@selector(SwitchS:) forControlEvents:UIControlEventValueChanged];
    [self.contentView addSubview:_Switch];
}
-(void)SwitchS:(UISwitch *)Switch{
    

}
@end
