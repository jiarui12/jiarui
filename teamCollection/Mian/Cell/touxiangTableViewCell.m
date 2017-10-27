//
//  touxiangTableViewCell.m
//  teamCollection
//
//  Created by 八九点 on 2016/12/1.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "touxiangTableViewCell.h"
#import "WQLStarView.h"
#import "UIImageView+WebCache.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@implementation touxiangTableViewCell
{
    WQLStarView *starView;
    UIView * view;
    UILabel * label;
    UIImageView * jiatou;
    UIView * xian;
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"newnotify";
    // 1.缓存中取
    touxiangTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[touxiangTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
    
    
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor=[UIColor clearColor];
        /*   添加圆形头像    */
        //        int i=70;
        _headImageView=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH* 10/375,WIDTH* 7.5/375,WIDTH*36/375, WIDTH*36/375)];
        _headImageView.layer.cornerRadius=_headImageView.frame.size.width/2;
        _headImageView.clipsToBounds=YES;
        
        [self.contentView addSubview:_headImageView];
        
        
        view=[[UIView alloc]initWithFrame:CGRectMake(WIDTH* 56/375, WIDTH* 7.5/375, WIDTH* 309/375, WIDTH*107.5/375)];
        view.backgroundColor=[UIColor whiteColor];
        
        
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        // 新建一个红色的ColorRef，用于设置边框（四个数字分别是 r, g, b, alpha）
        CGColorRef borderColorRef = CGColorCreate(colorSpace,(CGFloat[]){ 175/255.0, 175/255.0, 175/255.0, 1 });
        view.layer.borderWidth=0.3;
        view.layer.borderColor=borderColorRef;
        view.layer.cornerRadius=WIDTH *10/375;
        [self.contentView addSubview:view];
        
        xian=[[UIView alloc]initWithFrame:CGRectMake(WIDTH* 10/375, view.frame.size.height-WIDTH*35/375, WIDTH*290/375, 0.5)];
        xian.backgroundColor=[UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0];
        [view addSubview:xian];
        label=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH* 10/375, view.frame.size.height-WIDTH*25/375, WIDTH*290/375, 15)];
        label.textColor=[UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0];
        label.font=[UIFont systemFontOfSize:WIDTH* 15/375];
        label.text=@"查看详情";
        [view addSubview:label];
        
        
        _shu=[[UIView alloc]initWithFrame:CGRectMake(WIDTH *9/375, WIDTH*11/375,WIDTH* 1.5/375, WIDTH*15/375)];
        
        
        
        [view addSubview:_shu];
        
        
        
        _nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH*15/375, WIDTH* 11/375,WIDTH *290/375, WIDTH *15/375)];
        _nameLabel.font=[UIFont systemFontOfSize:WIDTH*16/375];
        
        _nameLabel.textAlignment=NSTextAlignmentLeft;
        
        [view addSubview:_nameLabel];
        
        _detailLabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH*10/375,WIDTH *40/375,WIDTH* 290/375,WIDTH *15/375)];
        _detailLabel.textColor=[UIColor colorWithRed:29/255.0 green:30/255.0 blue:30/255.0 alpha:1.0];
        
        _detailLabel.font=[UIFont systemFontOfSize:WIDTH*15/375];
        [view addSubview:_detailLabel];
        
        jiatou=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH*294/375, view.frame.size.height-WIDTH*22.5/375, WIDTH *5.5/375, WIDTH*9/375)];
        jiatou.image=[UIImage imageNamed:@"icon_arrow1211_defult@2x"];
        
        [view addSubview:jiatou];
        
        _contentLabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH*55/375, WIDTH *120/375, WIDTH*244/375, 0)];
        _contentLabel.textColor=[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0];
        _contentLabel.font=[UIFont systemFontOfSize:WIDTH *13/375];
        
        
        //        _contentLabel.text=@"这个对于我们管理方面有着非常重要的指导意义，希望大家再接再厉这个对于我们管理方面有着非常重要的指导意义，希望大家再接再厉。";
        
        _contentLabel.numberOfLines=3;
        
        
        [view addSubview:_contentLabel];
        
        
        
        _detailImage=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH*10/375, WIDTH*65/375, WIDTH*36/375, WIDTH*36/375)];
        
        _detailImage.layer.cornerRadius=_detailImage.frame.size.width/2;
        _detailImage.clipsToBounds=YES;
        _detailImage.layer.borderWidth=0.5;
        _detailImage.image=[UIImage imageNamed:@"43e21444-b529-4052-b7a2-f05b913588cd.png"];
        
        CGColorSpaceRef colorSpace1 = CGColorSpaceCreateDeviceRGB();
        // 新建一个红色的ColorRef，用于设置边框（四个数字分别是 r, g, b, alpha）
        CGColorRef borderColorRef1 = CGColorCreate(colorSpace1,(CGFloat[]){ 175/255.0, 175/255.0, 175/255.0, 1 });
        _detailImage.layer.borderWidth=0.5;
        _detailImage.layer.borderColor=borderColorRef1;
     
        
        [view addSubview:_detailImage];

        
        
       
        
        _timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH*10/375, WIDTH*15/375, WIDTH*580/750,WIDTH *10/375)];
        _timeLabel.font=[UIFont systemFontOfSize:WIDTH* 12/375];
        _timeLabel.textAlignment=NSTextAlignmentRight;
        _timeLabel.textColor=[UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1.0];
        [view addSubview:_timeLabel];
        _userLabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH*55/375, WIDTH*65/375, 100, WIDTH*36/375)];
        _userLabel.textAlignment=NSTextAlignmentLeft;
        _userLabel.textColor=[UIColor colorWithRed:29/255.0 green:30/255.0 blue:30/255.0 alpha:1.0];
       
        _userLabel.font=[UIFont systemFontOfSize:WIDTH*15/375];
        [view addSubview:_userLabel];
        
        
        
        _catgorylabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH*55/375, WIDTH*105/375, 100, WIDTH*10/375)];
        
        _catgorylabel.textColor=[UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1.0];
        
        _catgorylabel.text=@"综合";
        
        _catgorylabel.font=[UIFont systemFontOfSize:WIDTH *13/375];
        [view addSubview:_catgorylabel];
        starView = [[WQLStarView alloc]initWithFrame:CGRectMake(WIDTH*88/375,WIDTH* 102/375, WIDTH*80/375,WIDTH* 14/375) withTotalStar:5 withTotalPoint:10 starSpace:WIDTH*5/375];
        //            starView.backgroundColor=[UIColor redColor];
        starView.starAliment = StarAlimentCenter;
        
        [view addSubview:starView];
        
        
        
    }
    return self;
}
- (void)setCellWithCategory:(NSString *)cate andContentDic:(NSDictionary *)dic andTime:(NSString *)time{
    
    if ([cate isEqualToString:@"1"]) {
        _shu.backgroundColor=[UIColor colorWithRed:94/255.0 green:201/255.0 blue:246/255.0 alpha:1.0];
        _nameLabel.textColor=[UIColor colorWithRed:94/255.0 green:201/255.0 blue:246/255.0 alpha:1.0];
        _headImageView.image=[UIImage imageNamed:@"image_chanpingengxin@2x"];
        _nameLabel.text=@"产品更新";
        _detailLabel.text=@"班组汇开启7.0时代";
        jiatou.image=[UIImage imageNamed:@"icon_arrow1211_defult@2x"];
        label.text=@"查看详情";
        _detailLabel.textColor=[UIColor colorWithRed:29/255.0 green:30/255.0 blue:30/255.0 alpha:1.0];
        xian.backgroundColor=[UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0];
    } if ([cate isEqualToString:@"2"]) {
        _shu.backgroundColor=[UIColor colorWithRed:246/255.0 green:191/255.0 blue:38/255.0 alpha:1.0];
        _nameLabel.textColor=[UIColor colorWithRed:246/255.0 green:191/255.0 blue:38/255.0 alpha:1.0];
        _headImageView.image=[UIImage imageNamed:@"image_huodong@2x"];
        _nameLabel.text=@"活动通知";
        _detailLabel.textColor=[UIColor colorWithRed:29/255.0 green:30/255.0 blue:30/255.0 alpha:1.0];
        _detailLabel.text=@"企业标杆100活动";
    } if ([cate isEqualToString:@"3"]) {
        _shu.backgroundColor=[UIColor colorWithRed:59/255.0 green:193/255.0 blue:180/255.0 alpha:1.0];
        _nameLabel.textColor=[UIColor colorWithRed:59/255.0 green:193/255.0 blue:180/255.0 alpha:1.0];
        _headImageView.image=[UIImage imageNamed:@"fuwutongzhi@2x"];
        _nameLabel.text=@"服务通知";
        _detailLabel.text=@"优惠续费";
        _detailLabel.textColor=[UIColor colorWithRed:29/255.0 green:30/255.0 blue:30/255.0 alpha:1.0];
    } if ([cate isEqualToString:@"4"]) {
        _shu.backgroundColor=[UIColor colorWithRed:106/255.0 green:198/255.0 blue:111/255.0 alpha:1.0];
        _nameLabel.textColor=[UIColor colorWithRed:106/255.0 green:198/255.0 blue:111/255.0 alpha:1.0];
        _headImageView.image=[UIImage imageNamed:@"image_yijianfankui@2x"];
        _nameLabel.text=@"意见反馈";
        _detailLabel.textColor=[UIColor colorWithRed:29/255.0 green:30/255.0 blue:30/255.0 alpha:1.0];
        _detailLabel.text=@"您提交的意见反馈已成功";
    }if ([cate isEqualToString:@"15"]) {
        _shu.backgroundColor=[UIColor colorWithRed:246/255.0 green:191/255.0 blue:38/255.0 alpha:1.0];
        _nameLabel.textColor=[UIColor colorWithRed:246/255.0 green:191/255.0 blue:38/255.0 alpha:1.0];
        _headImageView.image=[UIImage imageNamed:@"image_shubao@2x"];
        _catgorylabel.hidden=NO;
        [_detailImage sd_setImageWithURL:[NSURL URLWithString:dic[@"commentUserIcon"]]];
        
//        [_headImageView sd_setImageWithURL:[NSURL URLWithString:dic[@"commentUserIcon"]]];
        _nameLabel.text=@"书包";
        _timeLabel.text=time;
        _detailLabel.textColor=[UIColor colorWithRed:29/255.0 green:30/255.0 blue:30/255.0 alpha:1.0];
        _detailLabel.text=[NSString stringWithFormat:@"[%@]%@",dic[@"subTypeTitle"],dic[@"pushMessageTitle"]];
        
        starView.hidden=NO;

        
        starView.commentPoint = [dic[@"commentLevel"] integerValue]*2;
        
        
        _userLabel.text=dic[@"commentUserName"];
        
//        [NSString stringWithFormat:@"[%@]%@",dic[@"subTypeTitle"],dic[@"pushMessageTitle"]];
        
        NSMutableAttributedString * allStr=[[NSMutableAttributedString alloc]initWithString: [NSString stringWithFormat:@"[%@]%@",dic[@"subTypeTitle"],dic[@"pushMessageTitle"]]];
        
        [allStr addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0]} range:NSMakeRange(0, 4)];
        
        [_detailLabel setAttributedText:allStr];
        jiatou.image=[UIImage imageNamed:@"icon_arrow1211_defult@2x"];
        label.text=@"查看详情";
        xian.backgroundColor=[UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0];
        
        
        _contentLabel.text=dic[@"pushMessageContent"];
        
        [_contentLabel sizeToFit];
        NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:_contentLabel.text];
        NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle1 setLineSpacing:5.0];
        [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [_contentLabel.text length])];
        [_contentLabel setAttributedText:attributedString1];
        
        //根据最大行数需求来设置
        _contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        CGSize maximumLabelSize = CGSizeMake(WIDTH*244/375, 9999);
        CGSize expectSize = [_contentLabel sizeThatFits:maximumLabelSize];
        
        _contentLabel.frame=CGRectMake(WIDTH*55/375, WIDTH *125/375, WIDTH*244/375, expectSize.height+5) ;
        if ([dic[@"pushMessageContent"] length]<1) {
            _contentLabel.frame=CGRectMake(WIDTH*55/375, WIDTH *120/375, WIDTH*244/375, 0) ;
        }
        
        [view setFrame:CGRectMake(WIDTH* 56/375, WIDTH* 7.5/375, WIDTH* 309/375, WIDTH*107.5/375+_contentLabel.frame.size.height+WIDTH*60/375)];
        [label setFrame:CGRectMake(WIDTH* 10/375, view.frame.size.height-WIDTH*25/375, WIDTH*290/375, 15)];
        [jiatou setFrame: CGRectMake(WIDTH*294/375, view.frame.size.height-WIDTH*22.5/375, WIDTH *5.5/375, WIDTH*9/375)];
        [xian setFrame: CGRectMake(WIDTH* 10/375, view.frame.size.height-WIDTH*35/375, WIDTH*290/375, 0.5)];

        
        
        
    }if ([cate isEqualToString:@"6"]) {
        _shu.backgroundColor=[UIColor colorWithRed:236/255.0 green:124/255.0 blue:127/255.0 alpha:1.0];
        _nameLabel.textColor=[UIColor colorWithRed:236/255.0 green:124/255.0 blue:127/255.0 alpha:1.0];
        _headImageView.image=[UIImage imageNamed:@"image_xindeganzhu@2x"];
        _nameLabel.text=@"新的关注";
        _detailLabel.text=@"小辉已经关注了你";
        _detailLabel.textColor=[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0];
       
    }if ([cate isEqualToString:@"7"]) {
        _shu.backgroundColor=[UIColor colorWithRed:94/255.0 green:151/255.0 blue:246/255.0 alpha:1.0];
        _nameLabel.textColor=[UIColor colorWithRed:94/255.0 green:151/255.0 blue:246/255.0 alpha:1.0];
        _headImageView.image=[UIImage imageNamed:@"image_gonggao@2x"];
        _nameLabel.text=@"公告";
        _detailLabel.textColor=[UIColor colorWithRed:29/255.0 green:30/255.0 blue:30/255.0 alpha:1.0];
        _detailLabel.text=@"八九点2017年元旦放假通知";
    }if ([cate isEqualToString:@"18"]) {
        _shu.backgroundColor=[UIColor colorWithRed:246/255.0 green:191/255.0 blue:38/255.0 alpha:1.0];
        _nameLabel.textColor=[UIColor colorWithRed:246/255.0 green:191/255.0 blue:38/255.0 alpha:1.0];
        _headImageView.image=[UIImage imageNamed:@"image_banzuzhichuang@2x"];
        _catgorylabel.hidden=YES;
        [_detailImage sd_setImageWithURL:[NSURL URLWithString:dic[@"commentUserIcon"]]];
        
        //        [_headImageView sd_setImageWithURL:[NSURL URLWithString:dic[@"commentUserIcon"]]];
        _nameLabel.text=@"班组之窗";
        _timeLabel.text=time;
        _detailLabel.textColor=[UIColor colorWithRed:29/255.0 green:30/255.0 blue:30/255.0 alpha:1.0];
        _detailLabel.text=[NSString stringWithFormat:@"[%@]%@",dic[@"subTypeTitle"],dic[@"pushMessageTitle"]];
        starView.hidden=YES;
       
       
        _userLabel.text=dic[@"commentUserName"];
        
        //        [NSString stringWithFormat:@"[%@]%@",dic[@"subTypeTitle"],dic[@"pushMessageTitle"]];
        
        NSMutableAttributedString * allStr=[[NSMutableAttributedString alloc]initWithString: [NSString stringWithFormat:@"[%@]%@",dic[@"subTypeTitle"],dic[@"pushMessageTitle"]]];
        
        [allStr addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0]} range:NSMakeRange(0, 4)];
        
        [_detailLabel setAttributedText:allStr];
        jiatou.image=[UIImage imageNamed:@"icon_arrow1211_defult@2x"];
        label.text=@"查看详情";
        xian.backgroundColor=[UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0];
        
        
        _contentLabel.text=dic[@"pushMessageContent"];
        [_contentLabel sizeToFit];
        NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:_contentLabel.text];
        NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle1 setLineSpacing:5.0];
        [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [_contentLabel.text length])];
        [_contentLabel setAttributedText:attributedString1];
        
        //根据最大行数需求来设置
        _contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        CGSize maximumLabelSize = CGSizeMake(WIDTH*244/375, 9999);
        CGSize expectSize = [_contentLabel sizeThatFits:maximumLabelSize];
        
        _contentLabel.frame=CGRectMake(WIDTH*55/375, WIDTH *105/375, WIDTH*244/375, expectSize.height+5) ;
        if ([dic[@"pushMessageContent"] length]<1) {
            _contentLabel.frame=CGRectMake(WIDTH*55/375, WIDTH *105/375, WIDTH*244/375, 0) ;
        }
        
        [view setFrame:CGRectMake(WIDTH* 56/375, WIDTH* 7.5/375, WIDTH* 309/375, WIDTH*107.5/375+_contentLabel.frame.size.height+WIDTH*40/375)];
        [label setFrame:CGRectMake(WIDTH* 10/375, view.frame.size.height-WIDTH*25/375, WIDTH*290/375, 15)];
        [jiatou setFrame: CGRectMake(WIDTH*294/375, view.frame.size.height-WIDTH*22.5/375, WIDTH *5.5/375, WIDTH*9/375)];
        [xian setFrame: CGRectMake(WIDTH* 10/375, view.frame.size.height-WIDTH*35/375, WIDTH*290/375, 0.5)];
        
    }if ([cate isEqualToString:@"9"]) {
        _shu.backgroundColor=[UIColor colorWithRed:106/255.0 green:198/255.0 blue:111/255.0 alpha:1.0];
        _nameLabel.textColor=[UIColor colorWithRed:106/255.0 green:198/255.0 blue:111/255.0 alpha:1.0];
        _headImageView.image=[UIImage imageNamed:@"image_diaoyan@2x"];
        _nameLabel.text=@"调研";
        _detailLabel.textColor=[UIColor colorWithRed:29/255.0 green:30/255.0 blue:30/255.0 alpha:1.0];
        _detailLabel.text=@"班组汇新版使用感受调研问卷";
    }if ([cate isEqualToString:@"10"]) {
        _shu.backgroundColor=[UIColor colorWithRed:94/255.0 green:201/255.0 blue:246/255.0 alpha:1.0];
        _nameLabel.textColor=[UIColor colorWithRed:94/255.0 green:201/255.0 blue:246/255.0 alpha:1.0];
        _headImageView.image=[UIImage imageNamed:@"image_ceping@2x"];
        _nameLabel.text=@"测评";
        _detailLabel.textColor=[UIColor colorWithRed:29/255.0 green:30/255.0 blue:30/255.0 alpha:1.0];
        _detailLabel.text=@"班组汇培训考核试卷";
    }if ([cate isEqualToString:@"11"]) {
        _shu.backgroundColor=[UIColor colorWithRed:255/255.0 green:135/255.0 blue:38/255.0 alpha:1.0];
        _nameLabel.textColor=[UIColor colorWithRed:255/255.0 green:135/255.0 blue:38/255.0 alpha:1.0];
        _headImageView.image=[UIImage imageNamed:@"image_jifen@2x"];
        _nameLabel.text=@"积分机制";
        _detailLabel.textColor=[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0];
        _detailLabel.text=@"恭喜您~您的等级已升至25级";
       
    }
    
}
-(void)setContentLabel:(UILabel *)contentLabel{
    
    NSLog(@"调用了：：：：%@",contentLabel.text);
    [_contentLabel sizeToFit];
    
    
    
    
}
-(void)setcontentString:(NSString *)string{
    _contentLabel.text=string;
    [_contentLabel sizeToFit];
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:_contentLabel.text];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:5.0];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [_contentLabel.text length])];
    [_contentLabel setAttributedText:attributedString1];
    
    //根据最大行数需求来设置
    _contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    CGSize maximumLabelSize = CGSizeMake(WIDTH*244/375, 9999);
    CGSize expectSize = [_contentLabel sizeThatFits:maximumLabelSize];
    
    _contentLabel.frame=CGRectMake(WIDTH*55/375, WIDTH *125/375, WIDTH*244/375, expectSize.height+5) ;
    if (string.length<1) {
        _contentLabel.frame=CGRectMake(WIDTH*55/375, WIDTH *120/375, WIDTH*244/375, 0) ;
    }
    
    [view setFrame:CGRectMake(WIDTH* 56/375, WIDTH* 7.5/375, WIDTH* 309/375, WIDTH*107.5/375+_contentLabel.frame.size.height+WIDTH*60/375)];
    [label setFrame:CGRectMake(WIDTH* 10/375, view.frame.size.height-WIDTH*25/375, WIDTH*290/375, 15)];
    [jiatou setFrame: CGRectMake(WIDTH*294/375, view.frame.size.height-WIDTH*22.5/375, WIDTH *5.5/375, WIDTH*9/375)];
    [xian setFrame: CGRectMake(WIDTH* 10/375, view.frame.size.height-WIDTH*35/375, WIDTH*290/375, 0.5)];
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
