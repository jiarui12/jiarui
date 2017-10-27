//
//  CloudBag1TableViewCell.m
//  teamCollection
//
//  Created by 八九点 on 16/1/18.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "CloudBag1TableViewCell.h"

@implementation CloudBag1TableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"cloud";
    // 1.缓存中取
    CloudBag1TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[CloudBag1TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
    
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        UIView * grayView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width , 10)];
        grayView.backgroundColor=[UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0];
        [self.contentView addSubview:grayView];
        
        
        UIScrollView * scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 40, self.contentView.frame.size.width, 120)];
        scroll.directionalLockEnabled = YES;
        scroll.pagingEnabled = YES;
        scroll.backgroundColor=[UIColor whiteColor];
        scroll.showsVerticalScrollIndicator = NO;
        scroll.showsHorizontalScrollIndicator = NO;
        
        scroll.delegate=self;
        UIImageView * headView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 30, 30)];
        headView.image=[UIImage imageNamed:@"honor_kp_card_label"];
        [self.contentView addSubview:headView];
        UIView * view=[[UIView alloc]initWithFrame:CGRectMake(0, 39, self.contentView.frame.size.width, 1)];
        view.backgroundColor=[UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1.0];
        [self.contentView addSubview:view];
        UILabel * CloudbagLabel=[[UILabel alloc]initWithFrame:CGRectMake(50, 7, 200, 40)];
        CloudbagLabel.text=@"云书包知识库";
        [self.contentView addSubview:CloudbagLabel];
        _view1=[[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.contentView.frame.size.width, 120)];
        _view1.backgroundColor=[UIColor whiteColor];
        _headImage1=[[UIImageView alloc]initWithFrame:CGRectMake(self.contentView.frame.size.width/3*0+25, 10, (self.contentView.frame.size.width-5*2*10)/4, (self.contentView.frame.size.width-5*2*10)/4)];
        _headImage1.layer.cornerRadius=_headImage1.frame.size.width/2;
        _headImage1.clipsToBounds=YES;
        
        _label1=[[UILabel alloc]init];
        _label1.frame=CGRectMake(self.contentView.frame.size.width/3*0+22, 100, (self.contentView.frame.size.width-5*2*10)/4,20 );
        _label1.textAlignment=NSTextAlignmentCenter;
        _label1.font=[UIFont systemFontOfSize:14];
        [self.view1 addSubview:_label1];
        
         _label2=[[UILabel alloc]init];
        _label2.frame=CGRectMake(self.contentView.frame.size.width/3*1+22, 100, (self.contentView.frame.size.width-5*2*10)/4,20 );
        _label2.textAlignment=NSTextAlignmentCenter;
        _label2.font=[UIFont systemFontOfSize:14];
        [self.view1 addSubview:_label2];

         _label3=[[UILabel alloc]init];
        _label3.frame=CGRectMake(self.contentView.frame.size.width/3*2+12, 100, (self.contentView.frame.size.width-5*2*10)/4+20,20 );
        _label3.textAlignment=NSTextAlignmentCenter;
        _label3.font=[UIFont systemFontOfSize:14];
        [self.view1 addSubview:_label3];

        [self.view1 addSubview:_headImage1];
        
        
        _headImage2=[[UIImageView alloc]initWithFrame:CGRectMake(self.contentView.frame.size.width/3*1+25, 10, (self.contentView.frame.size.width-5*2*10)/4, (self.contentView.frame.size.width-5*2*10)/4)];
        _headImage2.layer.cornerRadius=_headImage2.frame.size.width/2;
        _headImage2.clipsToBounds=YES;
        
        [self.view1 addSubview:_headImage2];
        
        
        _headImage3=[[UIImageView alloc]initWithFrame:CGRectMake(self.contentView.frame.size.width/3*2+25, 10, (self.contentView.frame.size.width-5*2*10)/4, (self.contentView.frame.size.width-5*2*10)/4)];
        _headImage3.layer.cornerRadius=_headImage3.frame.size.width/2;
        _headImage3.clipsToBounds=YES;
        
        [self.view1 addSubview:_headImage3];
        [scroll addSubview:_view1];
        
        
        
        
        
        for (int i = 0; i<3; i++) {
            
            UIButton * button=[UIButton buttonWithType:UIButtonTypeSystem];
            button.frame=CGRectMake(self.contentView.frame.size.width/3*i+15, 30, (self.contentView.frame.size.width-5*2*10)/3, (self.contentView.frame.size.width-5*2*10)/3);
            button.tag=i;
            button.backgroundColor=[UIColor clearColor];
            [button addTarget:self action:@selector(toNextController:) forControlEvents:UIControlEventTouchUpInside];
            [self.view1 addSubview:button];
        }
        _view2=[[UIView alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width, 0.0, self.contentView.frame.size.width, 120)];
        _view2.backgroundColor=[UIColor whiteColor];
        _headImage4=[[UIImageView alloc]initWithFrame:CGRectMake(self.contentView.frame.size.width/2-((self.contentView.frame.size.width-5*2*10)/3/2)+15, 10, (self.contentView.frame.size.width-5*2*10)/4, (self.contentView.frame.size.width-5*2*10)/4)];
        _headImage4.layer.cornerRadius=_headImage4.frame.size.width/2;
        _headImage4.clipsToBounds=YES;
        
        self.label4=[[UILabel alloc]initWithFrame:CGRectMake(0, 100, self.contentView.frame.size.width, 20)];
        self.label4.font=[UIFont systemFontOfSize:14];
        
        self.label4.text=@"高峰论坛";
        self.label4.textAlignment=NSTextAlignmentCenter;
        [self.view2 addSubview:self.label4];
        [self.view2 addSubview:_headImage4];

        UIButton  * button=[UIButton buttonWithType:UIButtonTypeSystem];
        button.frame=CGRectMake(self.contentView.frame.size.width/2-((self.contentView.frame.size.width-5*2*10)/3/2), 30, (self.contentView.frame.size.width-5*2*10)/3, (self.contentView.frame.size.width-5*2*10)/3);
        
        button.backgroundColor=[UIColor clearColor];
        [button addTarget:self action:@selector(toNextController:) forControlEvents:UIControlEventTouchUpInside];
        button.tag=3;
        [self.view2 addSubview:button];
//        [scroll addSubview:_view2];
        
        [scroll setContentSize:CGSizeMake(self.contentView.frame.size.width, 120)];
        [self.contentView addSubview:scroll];

       
        _page=[[UIPageControl alloc]init];
        _page.frame=CGRectMake(self.contentView.frame.size.width/2-25, 170, 50, 20);
        _page.numberOfPages=2;
        _page.currentPage=0;
        
        _page.currentPageIndicatorTintColor = [UIColor colorWithRed:41/255.0 green:181/255.0 blue:235/255.0 alpha:1.0];
        _page.pageIndicatorTintColor = [UIColor grayColor];
//        [self.contentView addSubview:_page];
        [self.view1 setExclusiveTouch:YES];

    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}
-(void)setFrame:(CGRect)frame
{
    frame.size.width= [UIScreen mainScreen].applicationFrame.size.width;
    [super setFrame:frame];
}
-(void)toNextController:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(SkipToNextControllerOnClick:)]) {
        [self.delegate SkipToNextControllerOnClick:button];
    }
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int index = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;
    _page.currentPage = index;

}
@end
