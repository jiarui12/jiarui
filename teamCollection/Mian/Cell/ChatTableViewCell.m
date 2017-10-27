//
//  ChatTableViewCell.m
//  teamCollection
//
//  Created by 八九点 on 16/3/1.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "ChatTableViewCell.h"
#import "Message.h"
#import "MessageFrame.h"
#import "UIImageView+WebCache.h"
@interface ChatTableViewCell ()

{
   
}

@end



@implementation ChatTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        _timeBtn=[[UIButton alloc]init];
        [_timeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _timeBtn.titleLabel.font=kTimeFont;
        _timeBtn.enabled=NO;
        _timeBtn.layer.cornerRadius=[UIScreen mainScreen].bounds.size.width*4/375;
        [_timeBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        _timeBtn.backgroundColor=[UIColor colorWithRed:126/255.0 green:167/255.0 blue:184/255.0 alpha:1.0];
        
        
        
    
        
        [self.contentView addSubview:_timeBtn];
        _iconView =[[UIImageView alloc]init];
        _iconView.layer.cornerRadius=20;
        [self.contentView addSubview:_iconView];
        _contentBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_contentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _contentBtn.titleLabel.font=kContentFont;
        _contentBtn.titleLabel.numberOfLines=0;
        _contentBtn.layer.cornerRadius=[UIScreen mainScreen].bounds.size.width*4/375;
        [self.contentView addSubview:_contentBtn];
        
    }
    return self;
}
-(void)setMessageFrame:(MessageFrame *)messageFrame
{
    
    
    
    _messageFrame=messageFrame;
    Message *message=_messageFrame.message;
    [_timeBtn setTitle:message.time forState:UIControlStateNormal];
    
//    NSLog(@"%@",message.date);
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    if (![user objectForKey:@"messageDate"]) {
        [user setObject:message.date forKey:@"messageDate"];
        _timeBtn.hidden=NO;
    }else{
    
    
        NSDate * date=[user objectForKey:@"messageDate"];
        NSTimeInterval start = [date timeIntervalSince1970]*1;
        NSTimeInterval end = [message.date timeIntervalSince1970]*1;
        NSTimeInterval value = end - start;
        
        

        
        if (value>300) {
            _timeBtn.hidden=NO;
            [user setObject:message.date forKey:@"messageDate"];
        }else{
            _timeBtn.hidden=YES;
        
        }
    }
    
    
    
    _timeBtn.frame=_messageFrame.timeF;
//    _iconView.image=[UIImage imageNamed:message.icon];
   
    _iconView.frame=_messageFrame.iconF;
    _iconView.layer.cornerRadius=_messageFrame.iconF.size.width/2;
    _iconView.layer.masksToBounds=YES;
//    _iconView.backgroundColor=[UIColor redColor];
     [_iconView sd_setImageWithURL:[NSURL URLWithString:message.icon] placeholderImage:[UIImage imageNamed:@"weidenglutouxiang@2x"]];
    
    
    
    if (message.content.length>0) {
        [_contentBtn setTitle:message.content forState:UIControlStateNormal];
     [_contentBtn setAttributedTitle:[NSAttributedString emojiAttributedString:message.content withFont:kContentFont] forState:UIControlStateNormal]  ;
//    [_contentBtn.titleLabel setAttributedText:[NSAttributedString emojiAttributedString:message.content withFont:kContentFont]];
    
    }
    
    _contentBtn.contentEdgeInsets=UIEdgeInsetsMake(kContentTop, kContentLeft, kContentBottom, kContentRight);
    _contentBtn.frame=_messageFrame.contentF;
    if (message.type==MessageTypeMe) {
        _contentBtn.contentEdgeInsets=UIEdgeInsetsMake(kContentTop, kContentRight, kContentBottom, kContentLeft);
    }
    UIImage * normal,*focused;
    if (message.type==MessageTypeMe) {
        normal=[UIImage imageNamed:@"chat_item_right_new"];
        normal=[normal stretchableImageWithLeftCapWidth:normal.size.width*0.5 topCapHeight:normal.size.height*0.7];
        focused=[UIImage imageNamed:@"chat_item_right_new_pressed.9"];
        focused=[focused stretchableImageWithLeftCapWidth:normal.size.width*0.5 topCapHeight:normal.size.height*0.7];
        
        _contentBtn.backgroundColor=[UIColor colorWithRed:216/255.0 green:226/255.0 blue:234/255.0 alpha:1.0];
        
    }else{
      
        normal=[UIImage imageNamed:@"chat_item_left_new"];
        normal=[normal stretchableImageWithLeftCapWidth:normal.size.width*0.5 topCapHeight:normal.size.height*0.7];
        focused=[UIImage imageNamed:@"chat_item_left_new_pressed.9"];
        focused=[focused stretchableImageWithLeftCapWidth:normal.size.width*0.5 topCapHeight:normal.size.height*0.7];
        
        _contentBtn.backgroundColor=[UIColor whiteColor];
    
    }
//    [_contentBtn setBackgroundImage:normal forState:UIControlStateNormal];
//    [_contentBtn setBackgroundImage:focused forState:UIControlStateHighlighted];
    
}


- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
