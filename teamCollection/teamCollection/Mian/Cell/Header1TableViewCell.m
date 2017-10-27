//
//  Header1TableViewCell.m
//  teamCollection
//
//  Created by 八九点 on 16/1/15.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "Header1TableViewCell.h"

@implementation Header1TableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"status";
         // 1.缓存中取
         Header1TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
         // 2.创建
         if (cell == nil) {
                 cell = [[Header1TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
             }
         return cell;

}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
 {
        self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
         if (self) {
             NSLog(@"%f" ,  self.contentView.frame.size.width);
             NSArray * imageArray=@[@"honor_bag_icon",@"honor_awesome_card_label",@"honor_group_card_label",@"honor_local_value",@"honor_more_down"];
             NSArray * nameArray=@[@"书包",@"标杆",@"虚拟班组",@"本地宝",@"更多"];
             
             NSArray * image1Array=@[@"honor_card_item_icon",@"my_subject",@"play_game",@"shake_phone"];
             
             NSArray * name1Array=@[@"一事一控",@"O2O",@"玩一玩",@"摇一摇"];
             UIImageView*backImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, 230)];
             backImage.image=[UIImage imageNamed:@"honor_user_infor_bg"];
             [self.contentView addSubview:backImage];
             
             int i=70;
            self.headImageView=[[UIImageView alloc]initWithFrame:CGRectMake(self.contentView.frame.size.width/2-(i/2),70, i, i)];
             
             self.headImageView.layer.cornerRadius=self.headImageView.frame.size.width/2;
             self.headImageView.clipsToBounds=YES;
             
           
            
             [self.contentView addSubview:self.headImageView];
             self.circularView=[[CircularProgressView alloc]initWithFrame:CGRectMake(self.contentView.frame.size.width/2-(i/2)-5,65, i+10, i+10) backColor:[UIColor blackColor] progressColor:[UIColor colorWithRed:247/255.0 green:145/255.0 blue:43/255.0 alpha:1.0] lineWidth:5 audioPath:nil];
             
             [self.contentView addSubview:_circularView];
             
             self.scoreLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.contentView.frame.size.width/4, 180, 60, 20)];
             self.scoreLabel.font=[UIFont systemFontOfSize:14.0];
             self.scoreLabel.textColor=[UIColor whiteColor];
             
             [self.contentView addSubview:self.scoreLabel];
             
             
             self.levelLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.contentView.frame.size.width/3*2, 180, 60, 20)];
             self.levelLabel.font=[UIFont systemFontOfSize:14.0];
             self.levelLabel.textColor=[UIColor whiteColor];
            
             [self.contentView addSubview:self.levelLabel];
             
             self.levelImage=[[UIImageView alloc]initWithFrame:CGRectMake(self.contentView.frame.size.width/3*2-35, 185,30 , 10)];
             
             [self.contentView addSubview:self.levelImage];
             
             self.scoreImage=[[UIImageView alloc]initWithFrame:CGRectMake(self.contentView.frame.size.width/4-20, 185, 15, 10)];
             self.scoreImage.image=[UIImage imageNamed:@"user_score_icon"];
             [self.contentView addSubview:self.scoreImage];
             
             
             UIButton * levelButton=[UIButton buttonWithType:UIButtonTypeSystem];
             levelButton.frame=CGRectMake(self.contentView.frame.size.width/3*2-35, 180, 90, 20);
             levelButton.backgroundColor=[UIColor clearColor];
             levelButton.tag=101;
             [levelButton addTarget:self action:@selector(ToMyController:) forControlEvents:UIControlEventTouchUpInside];
             [self.contentView addSubview:levelButton];
             
             UIButton * scoreButton=[UIButton buttonWithType:UIButtonTypeSystem];
             scoreButton.frame=CGRectMake(self.contentView.frame.size.width/4-20, 180, 90, 20);
             scoreButton.backgroundColor=[UIColor clearColor];
             scoreButton.tag=102;
             [scoreButton addTarget:self action:@selector(ToMyController:) forControlEvents:UIControlEventTouchUpInside];
             [self.contentView addSubview:scoreButton];
             
             UIButton * button=[UIButton buttonWithType:UIButtonTypeCustom];
             button.frame=CGRectMake(10, 20, 30, 30);
             button.tag=1;
             [button setBackgroundImage:[UIImage imageNamed:@"menu_search"] forState:UIControlStateNormal];
             [self.contentView addSubview:button];
             UIButton * ScanButton=[UIButton buttonWithType:UIButtonTypeCustom];
             ScanButton.tag=2;
             ScanButton.frame=CGRectMake(self.contentView.frame.size.width-40, 20, 30, 30);
             [ScanButton setBackgroundImage:[UIImage imageNamed:@"honor_scan_icon"] forState:UIControlStateNormal];
             [self.contentView addSubview:ScanButton];
             self.nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 150, self.contentView.frame.size.width, 20)];
        
             self.nameLabel.textColor=[UIColor whiteColor];
             self.nameLabel.textAlignment=NSTextAlignmentCenter;
             [self.contentView addSubview:self.nameLabel];
             for (int i=0; i<5; i++) {
                 UIImageView * image=[[UIImageView alloc]initWithFrame:CGRectMake(self.contentView.frame.size.width/5*i+15, 240, (self.contentView.frame.size.width-5*2*10)/5-10, (self.contentView.frame.size.width-5*2*10)/5-10)];
                 image.image=[UIImage imageNamed:imageArray[i]];
                 
                 [self.contentView addSubview:image];
                 UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake((self.contentView.frame.size.width/5)*i, 285, self.contentView.frame.size.width/5, 20)];
                 label.textAlignment=NSTextAlignmentCenter;
                 label.font=[UIFont systemFontOfSize:14];
                 label.text=nameArray[i];
                 [self.contentView addSubview:label];
                 
                 UIButton * button=[UIButton buttonWithType:UIButtonTypeSystem];
                 button.frame=CGRectMake(self.contentView.frame.size.width/5*i+15, 240, (self.contentView.frame.size.width-5*2*10)/5-10, (self.contentView.frame.size.width-5*2*10)/5+20);
                 button.backgroundColor=[UIColor clearColor];
                 [button addTarget:self action:@selector(ToMyController:) forControlEvents:UIControlEventTouchUpInside];
                 button.tag=10+i;
                 [self.contentView addSubview:button];
             }
             for (int i=0; i<4; i++) {
                 UIImageView * image=[[UIImageView alloc]initWithFrame:CGRectMake(self.contentView.frame.size.width/5*i+15, 310, (self.contentView.frame.size.width-5*2*10)/5-10, (self.contentView.frame.size.width-5*2*10)/5-10)];
                 image.image=[UIImage imageNamed:image1Array[i]];
                 [self.contentView addSubview:image];
                 
                 UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake((self.contentView.frame.size.width/5)*i,355, self.contentView.frame.size.width/5, 20)];
                 label.textAlignment=NSTextAlignmentCenter;
                 label.font=[UIFont systemFontOfSize:14];
                 label.text=name1Array[i];
                 [self.contentView addSubview:label];
                 UIButton * button=[UIButton buttonWithType:UIButtonTypeSystem];
                 button.frame=CGRectMake(self.contentView.frame.size.width/5*i+15, 310, (self.contentView.frame.size.width-5*2*10)/5-10, (self.contentView.frame.size.width-5*2*10)/5+20);
                 button.backgroundColor=[UIColor clearColor];
                 [button addTarget:self action:@selector(ToMyController:) forControlEvents:UIControlEventTouchUpInside];
                 button.tag=20+i;
                 [self.contentView addSubview:button];
             }
             
             UIButton * button1=[UIButton buttonWithType:UIButtonTypeSystem];
             button1.frame=CGRectMake(self.contentView.frame.size.width/2-(i/2),70, i, i);
             button1.backgroundColor=[UIColor clearColor];
             button1.tag=3;
             [button1 addTarget:self action:@selector(ToMyController:) forControlEvents:UIControlEventTouchUpInside];
             [button addTarget:self action:@selector(ToMyController:) forControlEvents:UIControlEventTouchUpInside];
             [ScanButton addTarget:self action:@selector(ToMyController:) forControlEvents:UIControlEventTouchUpInside];
             [self.contentView addSubview:button1];
             
             
            }
return self;
}
-(void)ToMyController:(UIButton * )button{
    if ([self.delegate respondsToSelector:@selector(SkipToMyControllerOnClick:)]) {
        [self.delegate SkipToMyControllerOnClick:button];
    }
  

}
-(void)setFrame:(CGRect)frame
{
    frame.size.width= [UIScreen mainScreen].applicationFrame.size.width;
    [super setFrame:frame];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

   
}

@end
