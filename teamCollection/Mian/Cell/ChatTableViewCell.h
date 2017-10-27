//
//  ChatTableViewCell.h
//  teamCollection
//
//  Created by 八九点 on 16/3/1.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NSAttributedString+JTATEmoji.h"
@class MessageFrame;
@interface ChatTableViewCell : UITableViewCell

@property(nonatomic,strong)MessageFrame * messageFrame;
@property(nonatomic,strong) UIButton * timeBtn;


@property(nonatomic,strong)UIImageView * iconView;
@property(nonatomic,strong)UIButton * contentBtn;
@end
