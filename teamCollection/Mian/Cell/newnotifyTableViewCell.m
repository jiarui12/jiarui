//
//  newnotifyTableViewCell.m
//  teamCollection
//
//  Created by 八九点 on 2016/11/30.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "newnotifyTableViewCell.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@implementation newnotifyTableViewCell
{

    UIView * view;
    UILabel * label;
    UIImageView * jiatou;
    UIView * xian;
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"notify";
    // 1.缓存中取
    newnotifyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[newnotifyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
        
        
        
        _nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH*15/375, WIDTH* 11/375,WIDTH *250/375, WIDTH *15/375)];
        _nameLabel.font=[UIFont systemFontOfSize:WIDTH*16/375];
        
        _nameLabel.textAlignment=NSTextAlignmentLeft;
        
        [view addSubview:_nameLabel];

        _detailLabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH*10/375,WIDTH *40/375,WIDTH* 250/375,WIDTH *15/375)];
        _detailLabel.textColor=[UIColor colorWithRed:29/255.0 green:30/255.0 blue:30/255.0 alpha:1.0];
        
        _detailLabel.font=[UIFont systemFontOfSize:WIDTH*15/375];
        [view addSubview:_detailLabel];
        
        jiatou=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH*294/375, view.frame.size.height-WIDTH*22.5/375, WIDTH *5.5/375, WIDTH*9/375)];
        jiatou.image=[UIImage imageNamed:@"icon_arrow1211_defult@2x"];
        
        [view addSubview:jiatou];
        
        _contentLabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH*10/375, WIDTH *65/375, WIDTH*290/375, 0)];
        _contentLabel.textColor=[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0];
        _contentLabel.font=[UIFont systemFontOfSize:WIDTH *13/375];
        
        
        
        _contentLabel.numberOfLines=3;
        
        
        [view addSubview:_contentLabel];
        
        
        
        _detailImage=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH*10/375, WIDTH*65/375, WIDTH*36/375, WIDTH*36/375)];
        
        
        
        
//        
//        _numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH *695/750, WIDTH*86/750,WIDTH* 16/375,WIDTH * 16/375)];
//        _numberLabel.font = [UIFont boldSystemFontOfSize:10];  //UILabel的字体大小
//        _numberLabel.textColor = [UIColor whiteColor];
//        _numberLabel.textAlignment = NSTextAlignmentLeft;  //文本对齐方式
//        [_numberLabel setBackgroundColor:[UIColor redColor]];
//        _numberLabel.layer.cornerRadius=WIDTH* 16/375/2;
//        _numberLabel.clipsToBounds=YES;
//        NSString *str = @"1";
//        _numberLabel.backgroundColor=[UIColor redColor];
//        _numberLabel.textColor=[UIColor whiteColor];
//        CGSize size = [str sizeWithFont:_numberLabel.font constrainedToSize:CGSizeMake(MAXFLOAT, self.frame.size.height)];
//        //        [_numberLabel setFrame:CGRectMake(self.contentView.frame.size.width/8, 10, size.width, 10)];
//        _numberLabel.text = str;
//        _numberLabel.textAlignment=NSTextAlignmentCenter;
//        _numberLabel.userInteractionEnabled=YES;
//        [self.contentView addSubview:_numberLabel];
//        
        _timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH*10/375, WIDTH*15/375, WIDTH*580/750,WIDTH *10/375)];
        _timeLabel.font=[UIFont systemFontOfSize:WIDTH* 12/375];
        _timeLabel.textAlignment=NSTextAlignmentRight;
        _timeLabel.textColor=[UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1.0];

        [view addSubview:_timeLabel];
//
        
        
    }
    return self;
}
- (void)setCellWithCategory:(NSString *)cate andWithContentString:(NSString *)string andTimeString:(NSString *)time andTite:(NSString *)title{

    if ([cate isEqualToString:@"17"]) {
        
        
         _contentLabel.hidden=NO;
        jiatou.image=[UIImage imageNamed:@"icon_arrow1211_defult@2x"];
        label.text=@"查看详情";
        xian.backgroundColor=[UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0];
        _timeLabel.text=time;
        _shu.backgroundColor=[UIColor colorWithRed:94/255.0 green:151/255.0 blue:246/255.0 alpha:1.0];
        _nameLabel.textColor=[UIColor colorWithRed:94/255.0 green:151/255.0 blue:246/255.0 alpha:1.0];
        _headImageView.image=[UIImage imageNamed:@"image_gonggao@2x"];
        _nameLabel.text=@"公告";
        _detailLabel.textColor=[UIColor colorWithRed:29/255.0 green:30/255.0 blue:30/255.0 alpha:1.0];
        _detailLabel.text=title;
//        _contentLabel.text=string;
        _contentLabel.text=@"";
        [_contentLabel sizeToFit];
        _contentLabel.numberOfLines=3;
        
        
        NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:_contentLabel.text];
        NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle1 setLineSpacing:5.0];
        [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [_contentLabel.text length])];
        [_contentLabel setAttributedText:attributedString1];
        
        //根据最大行数需求来设置
        _contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        CGSize maximumLabelSize = CGSizeMake(WIDTH*290/375, 9999);
        CGSize expectSize = [_contentLabel sizeThatFits:maximumLabelSize];
        
        _contentLabel.frame=CGRectMake(WIDTH*10/375, WIDTH *65/375, WIDTH*290/375, expectSize.height+5) ;
        if (string.length<1) {
            _contentLabel.frame=CGRectMake(WIDTH*10/375, WIDTH *65/375, WIDTH*290/375, 0) ;
        }
        
        [view setFrame:CGRectMake(WIDTH* 56/375, WIDTH* 7.5/375, WIDTH* 309/375, WIDTH*107.5/375+_contentLabel.frame.size.height)];
        [label setFrame:CGRectMake(WIDTH* 10/375, view.frame.size.height-WIDTH*25/375, WIDTH*290/375, 15)];
        [jiatou setFrame: CGRectMake(WIDTH*294/375, view.frame.size.height-WIDTH*22.5/375, WIDTH *5.5/375, WIDTH*9/375)];
        [xian setFrame: CGRectMake(WIDTH* 10/375, view.frame.size.height-WIDTH*35/375, WIDTH*290/375, 0.5)];

        
        
        
        
        
        
        
        
        
        
        
        
    } if ([cate isEqualToString:@"23"]) {
        
        
        _contentLabel.hidden=NO;
        jiatou.image=[UIImage imageNamed:@"icon_arrow1211_defult@2x"];
        label.text=@"查看详情";
        xian.backgroundColor=[UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0];
        
        
         _timeLabel.text=time;
        
        _shu.backgroundColor=[UIColor colorWithRed:246/255.0 green:191/255.0 blue:38/255.0 alpha:1.0];
        _nameLabel.textColor=[UIColor colorWithRed:246/255.0 green:191/255.0 blue:38/255.0 alpha:1.0];
        _headImageView.image=[UIImage imageNamed:@"image_huodong@2x"];
        _nameLabel.text=@"活动通知";
        _detailLabel.textColor=[UIColor colorWithRed:29/255.0 green:30/255.0 blue:30/255.0 alpha:1.0];
        _detailLabel.text=title;
            _contentLabel.text=string;
            [_contentLabel sizeToFit];
            NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:_contentLabel.text];
            NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
            [paragraphStyle1 setLineSpacing:5.0];
            [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [_contentLabel.text length])];
            [_contentLabel setAttributedText:attributedString1];
        
            //根据最大行数需求来设置
            _contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            CGSize maximumLabelSize = CGSizeMake(WIDTH*290/375, 9999);
            CGSize expectSize = [_contentLabel sizeThatFits:maximumLabelSize];
        
            _contentLabel.frame=CGRectMake(WIDTH*10/375, WIDTH *65/375, WIDTH*290/375, expectSize.height+5) ;
            if (string.length<1) {
                _contentLabel.frame=CGRectMake(WIDTH*10/375, WIDTH *65/375, WIDTH*290/375, 0) ;
            }
        
            [view setFrame:CGRectMake(WIDTH* 56/375, WIDTH* 7.5/375, WIDTH* 309/375, WIDTH*107.5/375+_contentLabel.frame.size.height)];
            [label setFrame:CGRectMake(WIDTH* 10/375, view.frame.size.height-WIDTH*25/375, WIDTH*290/375, 15)];
            [jiatou setFrame: CGRectMake(WIDTH*294/375, view.frame.size.height-WIDTH*22.5/375, WIDTH *5.5/375, WIDTH*9/375)];
            [xian setFrame: CGRectMake(WIDTH* 10/375, view.frame.size.height-WIDTH*35/375, WIDTH*290/375, 0.5)];

    } if ([cate isEqualToString:@"23"]) {
        
        _contentLabel.hidden=NO;
        jiatou.image=[UIImage imageNamed:@"icon_arrow1211_defult@2x"];
        label.text=@"查看详情";
        xian.backgroundColor=[UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0];
        
        
        
        
         _timeLabel.text=time;
        
        _shu.backgroundColor=[UIColor colorWithRed:59/255.0 green:193/255.0 blue:180/255.0 alpha:1.0];
        _nameLabel.textColor=[UIColor colorWithRed:59/255.0 green:193/255.0 blue:180/255.0 alpha:1.0];
        _headImageView.image=[UIImage imageNamed:@"fuwutongzhi@2x"];
        _nameLabel.text=@"服务通知";
        _detailLabel.text=title;
        _detailLabel.textColor=[UIColor colorWithRed:29/255.0 green:30/255.0 blue:30/255.0 alpha:1.0];
            _contentLabel.text=string;
            [_contentLabel sizeToFit];
            NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:_contentLabel.text];
            NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
            [paragraphStyle1 setLineSpacing:5.0];
            [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [_contentLabel.text length])];
            [_contentLabel setAttributedText:attributedString1];
        
            //根据最大行数需求来设置
            _contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            CGSize maximumLabelSize = CGSizeMake(WIDTH*290/375, 9999);
            CGSize expectSize = [_contentLabel sizeThatFits:maximumLabelSize];
        
            _contentLabel.frame=CGRectMake(WIDTH*10/375, WIDTH *65/375, WIDTH*290/375, expectSize.height+5) ;
            if (string.length<1) {
                _contentLabel.frame=CGRectMake(WIDTH*10/375, WIDTH *65/375, WIDTH*290/375, 0) ;
            }
        
            [view setFrame:CGRectMake(WIDTH* 56/375, WIDTH* 7.5/375, WIDTH* 309/375, WIDTH*107.5/375+_contentLabel.frame.size.height)];
            [label setFrame:CGRectMake(WIDTH* 10/375, view.frame.size.height-WIDTH*25/375, WIDTH*290/375, 15)];
            [jiatou setFrame: CGRectMake(WIDTH*294/375, view.frame.size.height-WIDTH*22.5/375, WIDTH *5.5/375, WIDTH*9/375)];
            [xian setFrame: CGRectMake(WIDTH* 10/375, view.frame.size.height-WIDTH*35/375, WIDTH*290/375, 0.5)];

        
    } if ([cate isEqualToString:@"25"]) {
         _timeLabel.text=time;
        
        _contentLabel.hidden=NO;
        jiatou.image=[UIImage imageNamed:@"icon_arrow1211_defult@2x"];
        label.text=@"查看详情";
        xian.backgroundColor=[UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0];
        
        
        _shu.backgroundColor=[UIColor colorWithRed:106/255.0 green:198/255.0 blue:111/255.0 alpha:1.0];
        _nameLabel.textColor=[UIColor colorWithRed:106/255.0 green:198/255.0 blue:111/255.0 alpha:1.0];
        _headImageView.image=[UIImage imageNamed:@"image_yijianfankui@2x"];
        _nameLabel.text=title;
        _detailLabel.textColor=[UIColor colorWithRed:29/255.0 green:30/255.0 blue:30/255.0 alpha:1.0];
        _detailLabel.text=@"您提交的意见反馈已成功";
            _contentLabel.text=string;
            [_contentLabel sizeToFit];
            NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:_contentLabel.text];
            NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
            [paragraphStyle1 setLineSpacing:5.0];
            [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [_contentLabel.text length])];
            [_contentLabel setAttributedText:attributedString1];
        
            //根据最大行数需求来设置
            _contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            CGSize maximumLabelSize = CGSizeMake(WIDTH*290/375, 9999);
            CGSize expectSize = [_contentLabel sizeThatFits:maximumLabelSize];
        
            _contentLabel.frame=CGRectMake(WIDTH*10/375, WIDTH *65/375, WIDTH*290/375, expectSize.height+5) ;
            if (string.length<1) {
                _contentLabel.frame=CGRectMake(WIDTH*10/375, WIDTH *65/375, WIDTH*290/375, 0) ;
            }
        
            [view setFrame:CGRectMake(WIDTH* 56/375, WIDTH* 7.5/375, WIDTH* 309/375, WIDTH*107.5/375+_contentLabel.frame.size.height)];
            [label setFrame:CGRectMake(WIDTH* 10/375, view.frame.size.height-WIDTH*25/375, WIDTH*290/375, 15)];
            [jiatou setFrame: CGRectMake(WIDTH*294/375, view.frame.size.height-WIDTH*22.5/375, WIDTH *5.5/375, WIDTH*9/375)];
            [xian setFrame: CGRectMake(WIDTH* 10/375, view.frame.size.height-WIDTH*35/375, WIDTH*290/375, 0.5)];

    }if ([cate isEqualToString:@"5"]) {
         _timeLabel.text=time;
//        _shu.backgroundColor=[UIColor colorWithRed:246/255.0 green:191/255.0 blue:38/255.0 alpha:1.0];
//        _nameLabel.textColor=[UIColor colorWithRed:246/255.0 green:191/255.0 blue:38/255.0 alpha:1.0];
//        _headImageView.image=[UIImage imageNamed:@"image_shubao@2x"];
//        _nameLabel.text=@"书包";
//        _detailLabel.textColor=[UIColor colorWithRed:29/255.0 green:30/255.0 blue:30/255.0 alpha:1.0];
//        _detailLabel.text=@"[评论]精细化班组建设在管理中的应用";
//        jiatou.image=[UIImage imageNamed:@"icon_arrow1211_defult@2x"];
//        label.text=@"查看详情";
//        xian.backgroundColor=[UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1.0];
    }if ([cate isEqualToString:@"16"]) {
         _timeLabel.text=time;
        _shu.backgroundColor=[UIColor colorWithRed:236/255.0 green:124/255.0 blue:127/255.0 alpha:1.0];
        _nameLabel.textColor=[UIColor colorWithRed:236/255.0 green:124/255.0 blue:127/255.0 alpha:1.0];
        _headImageView.image=[UIImage imageNamed:@"image_xindeganzhu@2x"];
        _nameLabel.text=@"新的关注";
        _contentLabel.hidden=YES;
        _detailLabel.text=title;
        _detailLabel.textColor=[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0];
        jiatou.image=[UIImage imageNamed:@""];
        label.text=@"";
        xian.backgroundColor=[UIColor clearColor];
            _contentLabel.text=string;
            [_contentLabel sizeToFit];
            NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:_contentLabel.text];
            NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
            [paragraphStyle1 setLineSpacing:5.0];
            [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [_contentLabel.text length])];
            [_contentLabel setAttributedText:attributedString1];
        
            //根据最大行数需求来设置
            _contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            CGSize maximumLabelSize = CGSizeMake(WIDTH*290/375, 9999);
            CGSize expectSize = [_contentLabel sizeThatFits:maximumLabelSize];
        
            _contentLabel.frame=CGRectMake(WIDTH*10/375, WIDTH *65/375, WIDTH*290/375, expectSize.height+5) ;
            if (string.length<1) {
                _contentLabel.frame=CGRectMake(WIDTH*10/375, WIDTH *65/375, WIDTH*290/375, 0) ;
            }
        
            [view setFrame:CGRectMake(WIDTH* 56/375, WIDTH* 7.5/375, WIDTH* 309/375, WIDTH*68.5/375)];
       

    }if ([cate isEqualToString:@"22"]) {
        
        
        _contentLabel.hidden=NO;
        jiatou.image=[UIImage imageNamed:@"icon_arrow1211_defult@2x"];
        label.text=@"查看详情";
        xian.backgroundColor=[UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0];
        
        
        _timeLabel.text=time;
        
        _shu.backgroundColor=[UIColor colorWithRed:94/255.0 green:201/255.0 blue:246/255.0 alpha:1.0];
        _nameLabel.textColor=[UIColor colorWithRed:94/255.0 green:201/255.0 blue:246/255.0 alpha:1.0];
        _headImageView.image=[UIImage imageNamed:@"image_chanpingengxin@2x"];
        _nameLabel.text=@"产品更新";
        _detailLabel.text=title;
        jiatou.image=[UIImage imageNamed:@"icon_arrow1211_defult@2x"];
        label.text=@"查看详情";
        
        
        
        
        _detailLabel.textColor=[UIColor colorWithRed:29/255.0 green:30/255.0 blue:30/255.0 alpha:1.0];
        xian.backgroundColor=[UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0];
        _contentLabel.text=string;
        [_contentLabel sizeToFit];
        NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:_contentLabel.text];
        NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle1 setLineSpacing:5.0];
        [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [_contentLabel.text length])];
        [_contentLabel setAttributedText:attributedString1];
        
        //根据最大行数需求来设置
        _contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        CGSize maximumLabelSize = CGSizeMake(WIDTH*290/375, 9999);
        CGSize expectSize = [_contentLabel sizeThatFits:maximumLabelSize];
        
        _contentLabel.frame=CGRectMake(WIDTH*10/375, WIDTH *65/375, WIDTH*290/375, expectSize.height+5) ;
        if (string.length<1) {
            _contentLabel.frame=CGRectMake(WIDTH*10/375, WIDTH *65/375, WIDTH*290/375, 0) ;
        }
        
        [view setFrame:CGRectMake(WIDTH* 56/375, WIDTH* 7.5/375, WIDTH* 309/375, WIDTH*107.5/375+_contentLabel.frame.size.height)];
        [label setFrame:CGRectMake(WIDTH* 10/375, view.frame.size.height-WIDTH*25/375, WIDTH*290/375, 15)];
        [jiatou setFrame: CGRectMake(WIDTH*294/375, view.frame.size.height-WIDTH*22.5/375, WIDTH *5.5/375, WIDTH*9/375)];
        [xian setFrame: CGRectMake(WIDTH* 10/375, view.frame.size.height-WIDTH*35/375, WIDTH*290/375, 0.5)];
        
        

    }if ([cate isEqualToString:@"18"]) {
         _timeLabel.text=time;
        _shu.backgroundColor=[UIColor colorWithRed:246/255.0 green:191/255.0 blue:38/255.0 alpha:1.0];
        _nameLabel.textColor=[UIColor colorWithRed:246/255.0 green:191/255.0 blue:38/255.0 alpha:1.0];
        _headImageView.image=[UIImage imageNamed:@"image_banzuzhichuang@2x"];
        _nameLabel.text=@"班组之窗";
        _detailLabel.textColor=[UIColor colorWithRed:29/255.0 green:30/255.0 blue:30/255.0 alpha:1.0];
        _detailLabel.text=@"[回复]精细化班组建设在管理中的应用";
    }if ([cate isEqualToString:@"19"]) {
         _timeLabel.text=time;
        _contentLabel.hidden=NO;
        jiatou.image=[UIImage imageNamed:@"icon_arrow1211_defult@2x"];
        label.text=@"查看详情";
        xian.backgroundColor=[UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0];
        
        
        _shu.backgroundColor=[UIColor colorWithRed:106/255.0 green:198/255.0 blue:111/255.0 alpha:1.0];
        _nameLabel.textColor=[UIColor colorWithRed:106/255.0 green:198/255.0 blue:111/255.0 alpha:1.0];
        _headImageView.image=[UIImage imageNamed:@"image_diaoyan@2x"];
        _nameLabel.text=@"调研";
        _detailLabel.textColor=[UIColor colorWithRed:29/255.0 green:30/255.0 blue:30/255.0 alpha:1.0];
        _detailLabel.text=title;
        _contentLabel.text=string;
        [_contentLabel sizeToFit];
            NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:_contentLabel.text];
            NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
            [paragraphStyle1 setLineSpacing:5.0];
            [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [_contentLabel.text length])];
            [_contentLabel setAttributedText:attributedString1];
        
            //根据最大行数需求来设置
            _contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            CGSize maximumLabelSize = CGSizeMake(WIDTH*290/375, 9999);
            CGSize expectSize = [_contentLabel sizeThatFits:maximumLabelSize];
        
            _contentLabel.frame=CGRectMake(WIDTH*10/375, WIDTH *65/375, WIDTH*290/375, expectSize.height+5) ;
            if (string.length<1) {
                _contentLabel.frame=CGRectMake(WIDTH*10/375, WIDTH *65/375, WIDTH*290/375, 0) ;
            }
        
            [view setFrame:CGRectMake(WIDTH* 56/375, WIDTH* 7.5/375, WIDTH* 309/375, WIDTH*107.5/375+_contentLabel.frame.size.height)];
            [label setFrame:CGRectMake(WIDTH* 10/375, view.frame.size.height-WIDTH*25/375, WIDTH*290/375, 15)];
            [jiatou setFrame: CGRectMake(WIDTH*294/375, view.frame.size.height-WIDTH*22.5/375, WIDTH *5.5/375, WIDTH*9/375)];
            [xian setFrame: CGRectMake(WIDTH* 10/375, view.frame.size.height-WIDTH*35/375, WIDTH*290/375, 0.5)];

    }if ([cate isEqualToString:@"20"]) {
        
        
        _contentLabel.hidden=NO;
        jiatou.image=[UIImage imageNamed:@"icon_arrow1211_defult@2x"];
        label.text=@"查看详情";
        xian.backgroundColor=[UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0];
         _timeLabel.text=time;
        _shu.backgroundColor=[UIColor colorWithRed:94/255.0 green:201/255.0 blue:246/255.0 alpha:1.0];
        _nameLabel.textColor=[UIColor colorWithRed:94/255.0 green:201/255.0 blue:246/255.0 alpha:1.0];
        _headImageView.image=[UIImage imageNamed:@"image_ceping@2x"];
        _nameLabel.text=@"测评";
        _detailLabel.textColor=[UIColor colorWithRed:29/255.0 green:30/255.0 blue:30/255.0 alpha:1.0];
        _detailLabel.text=title;
            _contentLabel.text=string;
            [_contentLabel sizeToFit];
            NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:_contentLabel.text];
            NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
            [paragraphStyle1 setLineSpacing:5.0];
            [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [_contentLabel.text length])];
            [_contentLabel setAttributedText:attributedString1];
        
            //根据最大行数需求来设置
            _contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            CGSize maximumLabelSize = CGSizeMake(WIDTH*290/375, 9999);
            CGSize expectSize = [_contentLabel sizeThatFits:maximumLabelSize];
        
            _contentLabel.frame=CGRectMake(WIDTH*10/375, WIDTH *65/375, WIDTH*290/375, expectSize.height+5) ;
            if (string.length<1) {
                _contentLabel.frame=CGRectMake(WIDTH*10/375, WIDTH *65/375, WIDTH*290/375, 0) ;
            }
        
            [view setFrame:CGRectMake(WIDTH* 56/375, WIDTH* 7.5/375, WIDTH* 309/375, WIDTH*107.5/375+_contentLabel.frame.size.height)];
            [label setFrame:CGRectMake(WIDTH* 10/375, view.frame.size.height-WIDTH*25/375, WIDTH*290/375, 15)];
            [jiatou setFrame: CGRectMake(WIDTH*294/375, view.frame.size.height-WIDTH*22.5/375, WIDTH *5.5/375, WIDTH*9/375)];
            [xian setFrame: CGRectMake(WIDTH* 10/375, view.frame.size.height-WIDTH*35/375, WIDTH*290/375, 0.5)];

    }if ([cate isEqualToString:@"21"]) {
        
        
        _contentLabel.hidden=NO;
        jiatou.image=[UIImage imageNamed:@"icon_arrow1211_defult@2x"];
        label.text=@"查看详情";
        xian.backgroundColor=[UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0];
         _timeLabel.text=time;
        
        _shu.backgroundColor=[UIColor colorWithRed:255/255.0 green:135/255.0 blue:38/255.0 alpha:1.0];
        _nameLabel.textColor=[UIColor colorWithRed:255/255.0 green:135/255.0 blue:38/255.0 alpha:1.0];
        _headImageView.image=[UIImage imageNamed:@"image_jifen@2x"];
        _nameLabel.text=@"积分机制";
        _detailLabel.textColor=[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0];
        _detailLabel.text=title;
        jiatou.image=[UIImage imageNamed:@""];
        label.text=@"";
        xian.backgroundColor=[UIColor clearColor];
        _contentLabel.text=string;
        [_contentLabel sizeToFit];
        NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:_contentLabel.text];
        NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle1 setLineSpacing:5.0];
        [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [_contentLabel.text length])];
        [_contentLabel setAttributedText:attributedString1];
        
            //根据最大行数需求来设置
        _contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        CGSize maximumLabelSize = CGSizeMake(WIDTH*290/375, 9999);
        CGSize expectSize = [_contentLabel sizeThatFits:maximumLabelSize];
        
        _contentLabel.frame=CGRectMake(WIDTH*10/375, WIDTH *65/375, WIDTH*290/375, expectSize.height+5) ;
        if (string.length<1) {
                _contentLabel.frame=CGRectMake(WIDTH*10/375, WIDTH *65/375, WIDTH*290/375, 0) ;
        }
        
        [view setFrame:CGRectMake(WIDTH* 56/375, WIDTH* 7.5/375, WIDTH* 309/375, WIDTH*107.5/375+_contentLabel.frame.size.height)];
        [label setFrame:CGRectMake(WIDTH* 10/375, view.frame.size.height-WIDTH*25/375, WIDTH*290/375, 15)];
        [jiatou setFrame: CGRectMake(WIDTH*294/375, view.frame.size.height-WIDTH*22.5/375, WIDTH *5.5/375, WIDTH*9/375)];
        [xian setFrame: CGRectMake(WIDTH* 10/375, view.frame.size.height-WIDTH*35/375, WIDTH*290/375, 0.5)];

        
    }

}
-(void)setContentLabel:(UILabel *)contentLabel{

    NSLog(@"调用了：：：：%@",contentLabel.text);
[_contentLabel sizeToFit];
    
    
    
    
}
//-(void)setCellWithCategory:(NSString *)cate andWithContentString:(NSString *)string{
//    _contentLabel.text=string;
//    [_contentLabel sizeToFit];
//    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:_contentLabel.text];
//    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
//    [paragraphStyle1 setLineSpacing:5.0];
//    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [_contentLabel.text length])];
//    [_contentLabel setAttributedText:attributedString1];
//    
//    //根据最大行数需求来设置
//    _contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
//    CGSize maximumLabelSize = CGSizeMake(WIDTH*290/375, 9999);
//    CGSize expectSize = [_contentLabel sizeThatFits:maximumLabelSize];
//    
//    _contentLabel.frame=CGRectMake(WIDTH*10/375, WIDTH *65/375, WIDTH*290/375, expectSize.height+5) ;
//    if (string.length<1) {
//        _contentLabel.frame=CGRectMake(WIDTH*10/375, WIDTH *65/375, WIDTH*290/375, 0) ;
//    }
//    
//    [view setFrame:CGRectMake(WIDTH* 56/375, WIDTH* 7.5/375, WIDTH* 309/375, WIDTH*107.5/375+_contentLabel.frame.size.height)];
//    [label setFrame:CGRectMake(WIDTH* 10/375, view.frame.size.height-WIDTH*25/375, WIDTH*290/375, 15)];
//    [jiatou setFrame: CGRectMake(WIDTH*294/375, view.frame.size.height-WIDTH*22.5/375, WIDTH *5.5/375, WIDTH*9/375)];
//    [xian setFrame: CGRectMake(WIDTH* 10/375, view.frame.size.height-WIDTH*35/375, WIDTH*290/375, 0.5)];
//}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
