//
//  KnowDetailTableViewCell.m
//  teamCollection
//
//  Created by 八九点 on 16/1/18.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "KnowDetailTableViewCell.h"
#import "AFNetworking.h"
#import "PrefixHeader.pch"

#import "UIImageView+WebCache.h"
@implementation KnowDetailTableViewCell
{
    NSString * _str;
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"status";
    // 1.缓存中取
    KnowDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[KnowDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}
-(void)loadData{
    
    
    self.UserIDArr=[NSMutableArray new];
    self.pListArr=[NSMutableArray new];
    self.videoSource=[NSMutableDictionary new];
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    
    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    NSString * url=[NSString stringWithFormat:@"%@:PORT/BagServer/kpDetail4New.mob",URLDOMAIN];
    NSUserDefaults * userInfo=[NSUserDefaults standardUserDefaults];
    CGFloat width =[UIScreen mainScreen].applicationFrame.size.width;
    if (width<400) {
        _Width=@"720";
    }if (width>400) {
        _Width=@"1080";
    }
  
    
    NSDictionary * parameters=@{@"token":[userInfo objectForKey:@"token"],@"kpID":[user objectForKey:@"kpID"],@"adapterSize":_Width};
    
    
    
    [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
       
        
        NSDictionary * Dic=dic[@"kpData"];
        self.name=Dic[@"authorName"];
        self.Title=Dic[@"title"];
        
        NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
        [user setObject:Dic[@"title"] forKey:@"timeTitle"];
        
        NSArray * arr=[Dic[@"rTime"] componentsSeparatedByString:@" "];
        
        self.time=arr[0];
        self.icon=Dic[@"headUrl"];
        self.categary=Dic[@"category"];
        self.videoImage=Dic[@"iconUrl"];
        self.content=Dic[@"content"];
        self.videoSource=Dic[@"videoSour"];
        NSString * str=self.content;
        
      
        
        str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
        str = [str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        
        self.flowers=[NSString stringWithFormat:@"%@",Dic[@"flowers"]];
        self.eggs=[NSString stringWithFormat:@"%@",Dic[@"eggs"]];
        
        NSArray * array=dic[@"bpList"];
        _rightIcons=[NSMutableArray new];
        for (NSDictionary * subDic in array) {
            [self.rightIcons addObject:subDic[@"headUrl"]];
        }
        if (self.rightIcons.count) {
            self.rightIcon=self.rightIcons[0];

        }
        
        
      
        
        NSArray * pList=dic[@"pList"];
        for (NSDictionary * pListDic in pList) {
            [self.UserIDArr addObject:[NSString stringWithFormat:@"%@",pListDic[@"userID"]]];
            [self.pListArr addObject:pListDic[@"headUrl"]];
        }
        
        
        [self loadView];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [self loadView];
    }];
   
  
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{   self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self loadData];
        
    }
    return self;
}
-(void)cai:(UIButton * )button{


}
-(void)zan:(UIButton*)button{

}



-(void)Animotion:(UIBarButtonItem*)button{
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
}
-(void)setFrame:(CGRect)frame
{
   
    frame.size.width= [UIScreen mainScreen].applicationFrame.size.width;
    frame.size.height=self.contentView.frame.size.width-10+_size.height+90+(self.contentView.frame.size.width-70)/6+20;
    
    [super setFrame:frame];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)loadView{

    _titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, self.contentView.frame.size.width, 15)];
    _titleLabel.font=[UIFont systemFontOfSize:17];
    _titleLabel.text=self.Title;
    [self.contentView addSubview:_titleLabel];
    
    _iconImage=[[UIImageView alloc]initWithFrame:CGRectMake(5, 35, 40, 40)];
    _iconImage.layer.cornerRadius=_iconImage.frame.size.width/2;
    _iconImage.clipsToBounds=YES;
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:self.icon]placeholderImage:[UIImage imageNamed:@"man_default_icon"]];
    [self.contentView addSubview:_iconImage];
    
    _nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(55, 40, 50, 10)];
    _nameLabel.font=[UIFont systemFontOfSize:13];
    _nameLabel.textColor=[UIColor colorWithRed:41/255.0 green:181/255.0 blue:235/255.0 alpha:1.0];
    self.nameLabel.text=_name;
    [self.contentView addSubview:_nameLabel];
    _categaryLabel=[[UILabel alloc]initWithFrame:CGRectMake(55, 60, 30, 15)];
    _categaryLabel.font=[UIFont systemFontOfSize:13];
    self.categaryLabel.text=_categary;
    [self.contentView addSubview:_categaryLabel];
    
    _timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(90, 60,200, 15)];
    _timeLabel.font=[UIFont systemFontOfSize:13];
    self.timeLabel.text=_time;
    [self.contentView addSubview:_timeLabel];
    
    
    UIButton * smallButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [smallButton setBackgroundImage:[UIImage imageNamed:@"ic_keyboard_arrow_right_grey600_24dp"] forState:UIControlStateNormal];
    smallButton.frame=CGRectMake(self.contentView.frame.size.width-20, 50, 10, 10);
    [smallButton addTarget:self action:@selector(Animotion:) forControlEvents:UIControlEventValueChanged];
    [self.contentView addSubview:smallButton];
    
    _rightIconView=[[UIImageView alloc]initWithFrame:CGRectMake(self.contentView.frame.size.width-70, 35, 40, 40)];
    _rightIconView.layer.cornerRadius=_rightIconView.frame.size.width/2;
    _rightIconView.clipsToBounds=YES;
    
    [self.rightIconView sd_setImageWithURL:[NSURL URLWithString:self.rightIcon]placeholderImage:[UIImage imageNamed:@"man_default_icon"]];
    [self.contentView addSubview:_rightIconView];
    
    UIImageView * zanImage=[[UIImageView alloc]initWithFrame:CGRectMake(self.contentView.frame.size.width-100, 40, 30, 30)];
    zanImage.image=[UIImage imageNamed:@"kp_detail_title_tip_icon"];
    [self.contentView addSubview:zanImage];
    UIView * view=[[UIView alloc]initWithFrame:CGRectMake(10,85, self.contentView.frame.size.width-20, 1)];
    view.backgroundColor=[UIColor colorWithRed:182/255.0 green:182/255.0 blue:182/255.0 alpha:1.0];
    [self.contentView addSubview:view];
    _videoImageView=[[UIImageView alloc]initWithFrame:CGRectMake(55, 90, self.contentView.frame.size.width-110, self.contentView.frame.size.width-110)];
    [self.videoImageView sd_setImageWithURL:[NSURL URLWithString:self.videoImage]placeholderImage:[UIImage imageNamed:@"material_default_pic_2"]];
   
    [self.contentView addSubview:_videoImageView];
    UIButton * playButton=[UIButton buttonWithType:UIButtonTypeCustom];
    playButton.frame=CGRectMake(self.contentView.frame.size.width/2-30, 90+(self.contentView.frame.size.width-110)/2-30, 60, 60);
    [playButton setBackgroundImage:[UIImage imageNamed:@"kp_list_item_icon_play"] forState:UIControlStateNormal];
    [playButton setBackgroundImage:[UIImage imageNamed:@"kp_list_item_icon_play_pressd"] forState:UIControlStateSelected];
    [playButton addTarget:self action:@selector(PlayVideo:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.contentView addSubview:playButton];
    
    
    
    
    
    _Label = [[UILabel alloc] initWithFrame:CGRectMake(0, 90+self.contentView.frame.size.width-110,self.contentView.frame.size.width, 0)];
    _Label.numberOfLines=0;
    
    
    _Label.font = [UIFont boldSystemFontOfSize:16];
    
    _size = [_str sizeWithFont:_Label.font constrainedToSize:CGSizeMake(_Label.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    
    _Label.textColor = [UIColor grayColor];
    
    _Label.textAlignment = NSTextAlignmentLeft;
    
    
    
    
    
    
    
    
    
    [_Label setFrame:CGRectMake(10, self.contentView.frame.size.width-20,self.contentView.frame.size.width-20, _size.height)];
    
    _Label.text = _str;
    
    
    [self.contentView addSubview:_Label];
    
    
    UIView * buttonView1=[[UIView alloc]initWithFrame:CGRectMake(10, self.contentView.frame.size.width-10+_size.height, (self.contentView.frame.size.width-40)/2, 30)];
    UIView * buttonView2=[[UIView alloc]initWithFrame:CGRectMake(30+(self.contentView.frame.size.width-40)/2, self.contentView.frame.size.width-10+_size.height, (self.contentView.frame.size.width-40)/2, 30)];
    buttonView1.backgroundColor=[UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];
    buttonView2.backgroundColor=[UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];
    [self.contentView addSubview:buttonView1];
    [self.contentView addSubview:buttonView2];
    UIImageView * zanImageView=[[UIImageView alloc]initWithFrame:CGRectMake(60, 5, 20, 20)];
    zanImageView.image=[UIImage imageNamed:@"kp_detail_tip_enable"];
    [buttonView1 addSubview:zanImageView];
    
    UIImageView * caiImageView=[[UIImageView alloc]initWithFrame:CGRectMake(60, 5, 20, 20)];
    caiImageView.image=[UIImage imageNamed:@"kp_detail_tread_enable"];
    [buttonView2 addSubview:caiImageView];
    UILabel * zanLabel=[[UILabel alloc]initWithFrame:CGRectMake(100, 5, 40, 20)];
    zanLabel.text=self.flowers;
    zanLabel.textColor=[UIColor grayColor];
    [buttonView1 addSubview:zanLabel];
    UILabel * caiLabel=[[UILabel alloc]initWithFrame:CGRectMake(100, 5, 40, 20)];
    caiLabel.text=self.eggs;
    caiLabel.textColor=[UIColor grayColor];
    [buttonView2 addSubview:caiLabel];
    
    UIButton * zanbutton=[UIButton buttonWithType:UIButtonTypeSystem];
    zanbutton.frame=CGRectMake(10, self.contentView.frame.size.width-10+_size.height, (self.contentView.frame.size.width-40)/2, 30);
    zanbutton.backgroundColor=[UIColor clearColor];
    [zanbutton addTarget:self action:@selector(zan:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:zanbutton];
    
    UIButton * caibutton=[UIButton buttonWithType:UIButtonTypeSystem];
    caibutton.frame=CGRectMake(30+(self.contentView.frame.size.width-40)/2, self.contentView.frame.size.width-10+_size.height, (self.contentView.frame.size.width-40)/2, 30);
    caibutton.backgroundColor=[UIColor clearColor];
    [caibutton addTarget:self action:@selector(cai:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:caibutton];
    
    UILabel * FlowerPeople=[[UILabel alloc]initWithFrame:CGRectMake(10, self.contentView.frame.size.width-10+_size.height+50, (self.contentView.frame.size.width-40)/2, 20)];
    FlowerPeople.text=@"他们都在赞：";
    FlowerPeople.textColor=[UIColor colorWithRed:182/255.0 green:182/255.0 blue:182/255.0 alpha:1.0];
    
    FlowerPeople.font=[UIFont systemFontOfSize:14];
    
    [self.contentView addSubview:FlowerPeople];
    
    for (int i =0; i<self.pListArr.count; i++) {
        _pListIcon=[[UIImageView alloc]initWithFrame:CGRectMake(10*(i+1)+(self.contentView.frame.size.width-70)/6*i,self.contentView.frame.size.width-10+_size.height+90 , (self.contentView.frame.size.width-70)/6, (self.contentView.frame.size.width-70)/6)];
        _pListIcon.layer.cornerRadius=_pListIcon.frame.size.width/2;
        _pListIcon.clipsToBounds=YES;
        [_pListIcon sd_setImageWithURL:[NSURL URLWithString:self.pListArr[i]]placeholderImage:[UIImage imageNamed:@"man_default_icon"]];
        [self.contentView addSubview:_pListIcon];
    }
}
-(void)PlayVideo:(UIButton * )button{
 
    
    if ([self.delegate respondsToSelector:@selector(PresentVideoPlayerController:)]) {
        [self.delegate PresentVideoPlayerController:button];
    }
    
    
}
@end
