//
//  newWeiKeTableViewCell.m
//  teamCollection
//
//  Created by 贾瑞 on 2017/5/31.
//  Copyright © 2017年 八九点. All rights reserved.
//

#import "newWeiKeTableViewCell.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@implementation newWeiKeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"comment";
    // 1.缓存中取
    newWeiKeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[newWeiKeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }
    
    return cell;
    
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _DetailLabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH * 12/375, 48*WIDTH/375, WIDTH * 287/375, 10*WIDTH/375)];
        _DetailLabel.font=[UIFont systemFontOfSize:14*WIDTH/375];
        _numberLines=5;
        _DetailLabel.textColor=[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0];
        
        
        [self.contentView addSubview:_DetailLabel];
        
        
        UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH * 12/375, 0*WIDTH/375,WIDTH , 48*WIDTH/375)];
        
        label.font=[UIFont systemFontOfSize:16*WIDTH/375];
        
        label.text=@"内容介绍";
        
        [self.contentView addSubview:label];
   
        
    }
    return self;
    
    
}


-(void)setIntroductionText:(NSString*)text{
    //获得当前cell高度
    CGRect frame = [self frame];
    //文本赋值
    self.DetailLabel.text = text;
    //设置label的最大行数
    
//    CGSize labelSize = [self.DetailLabel.text sizeWithFont:self.DetailLabel.font constrainedToSize:size lineBreakMode:NSLineBreakByClipping];
    
    CGSize contentH = [self.DetailLabel.text boundingRectWithSize:CGSizeMake(351*WIDTH/375, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14*WIDTH/375]} context:nil].size;
    CGSize onelineH = [@"" boundingRectWithSize:CGSizeMake(351*WIDTH/375, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14*WIDTH/375]} context:nil].size;
    
    
    NSLog(@"%f        %f",contentH.height,onelineH.height);
    
    self.DetailLabel.numberOfLines = _numberLines;//根据最大行数需求来设置
    self.DetailLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    CGSize maximumLabelSize = CGSizeMake(351*WIDTH/375, 9999);//labelsize的最大值
    //关键语句
    CGSize expectSize = [self.DetailLabel sizeThatFits:maximumLabelSize];
    //别忘了把frame给回label，如果用xib加了约束的话可以只改一个约束的值
    
    
    self.DetailLabel.frame = CGRectMake( WIDTH * 12/375, 48*WIDTH/375, expectSize.width, expectSize.height);
    
//    self.DetailLabel.frame = CGRectMake(WIDTH * 12/375, 48*WIDTH/375, contentH.width, contentH.height);
    if (onelineH.height*5<contentH.height&&_numberLines>0) {
        
        UIButton * button=[UIButton buttonWithType:UIButtonTypeCustom];
        
        
        button.frame=CGRectMake(179.5*WIDTH/375,_DetailLabel.frame.origin.y+expectSize.height+3*WIDTH/375, 32*WIDTH/375, 32*WIDTH/375);
        
        
//        button.backgroundColor=[UIColor redColor];
        
        [button setImage:[UIImage imageNamed:@"zhankai"] forState:UIControlStateNormal];
        [self.contentView addSubview:button];
        [button addTarget:self action:@selector(zhankai:) forControlEvents:UIControlEventTouchUpInside];
        frame.size.height = expectSize.height+_DetailLabel.frame.origin.y+30*WIDTH/375;

    }
    
    else{
        frame.size.height = contentH.height+60*WIDTH/375;
    }
    //计算出自适应的高度
    
    
    self.frame = frame;
}

-(void)setIntroductionText1:(NSString*)text{
    //获得当前cell高度
    CGRect frame = [self frame];
    //文本赋值
    self.DetailLabel.text = text;
    //设置label的最大行数
    self.DetailLabel.numberOfLines = 1000;
    
    //    CGSize labelSize = [self.DetailLabel.text sizeWithFont:self.DetailLabel.font constrainedToSize:size lineBreakMode:NSLineBreakByClipping];
    CGSize contentH = [self.DetailLabel.text boundingRectWithSize:CGSizeMake(351*WIDTH/375, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14*WIDTH/375]} context:nil].size;

 
    self.DetailLabel.numberOfLines = 999;//根据最大行数需求来设置
    self.DetailLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    CGSize maximumLabelSize = CGSizeMake(351*WIDTH/375, 9999);//labelsize的最大值
    //关键语句
    CGSize expectSize = [self.DetailLabel sizeThatFits:maximumLabelSize];
    
    
    self.DetailLabel.frame = CGRectMake(WIDTH * 12/375, 48*WIDTH/375, expectSize.width, expectSize.height);
    
//    +_DetailLabel.frame.origin.y
    
     frame.size.height = contentH.height+60*WIDTH/375;
    //计算出自适应的高度
    
    
    self.frame = frame;
}
-(void)zhankai:(UIButton *)button{
    _numberLines=0;
    
        if ([self.delegate respondsToSelector:@selector(UnfoldCellDidClickUnfoldBtn)]) {
            [self.delegate UnfoldCellDidClickUnfoldBtn];
        }
    


}
@end
