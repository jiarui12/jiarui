//
//  friendListTableViewCell.m
//  teamCollection
//
//  Created by 八九点 on 2016/12/2.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "friendListTableViewCell.h"
#import "UIImageView+WebCache.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@implementation friendListTableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"newfriend";
    // 1.缓存中取
    friendListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[friendListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
    
    
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor=[UIColor clearColor];
        /*   添加圆形头像    */
        //        int i=70;
        _headImageView=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH* 15/375,WIDTH* 10/375,WIDTH*36/375, WIDTH*36/375)];
        _headImageView.layer.cornerRadius=_headImageView.frame.size.width/2;
        _headImageView.clipsToBounds=YES;
        _headImageView.layer.borderWidth=0.5;
        _headImageView.layer.borderColor=(__bridge CGColorRef _Nullable)([UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0]);
        [_headImageView sd_setImageWithURL:[NSURL URLWithString:@"http://image.89mc.com/bjd/portrait/20b435d2-acc3-4800-8bf2-d63c7caf9f47.jpg"]];
        [self.contentView addSubview:_headImageView];
        _nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH* 58/375, WIDTH* 10/375, 200, WIDTH*36/375)];
        _nameLabel.text=@"颢文";
        _nameLabel.font=[UIFont systemFontOfSize:WIDTH *14/375];
        [self.contentView addSubview:_nameLabel];
       
        _gaunzhu=[UIButton buttonWithType:UIButtonTypeCustom];
        _gaunzhu.frame=CGRectMake(WIDTH *285/375,WIDTH *2/375, WIDTH*90/375,WIDTH* 50/375) ;
        [_gaunzhu setTitle:@"加关注" forState:UIControlStateNormal];
        _gaunzhu.titleEdgeInsets=UIEdgeInsetsMake(0,WIDTH*5/375 , 0, 0) ;
        _gaunzhu.titleLabel.font=[UIFont systemFontOfSize:WIDTH*14/375];
        [_gaunzhu setTitleColor:[UIColor colorWithRed:44/255.0 green:140/255.0 blue:251/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_gaunzhu setImage:[UIImage imageNamed:@"icon_jiaguanzhu_defult@2x"] forState:UIControlStateNormal];
        [self.contentView addSubview:_gaunzhu];
        
        
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
