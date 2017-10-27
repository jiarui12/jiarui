//
//  MMRightCell.m
//  teamCollection
//
//  Created by 贾瑞 on 2017/5/3.
//  Copyright © 2017年 八九点. All rights reserved.
//

#import "MMRightCell.h"
#import "MMComboBoxHeader.h"
@interface MMRightCell ()
@property (nonatomic, strong) CALayer *bottomLine;
@property (nonatomic, strong) UIView * leftLine;

@end

@implementation MMRightCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        
        
        
        [self addSubview:self.infoLabel];
        //        [self.layer addSublayer:self.bottomLine];
        //        [self addSubview:self.leftLine];
    }
    return self;
}

- (void)setItem:(MMItem *)item {
    _item = item;
    
    //    NSLog(@"%@",item);
    
    
    self.infoLabel.text = item.title;
    self.backgroundColor = item.isSelected?[UIColor whiteColor]:[UIColor whiteColor];
    self.infoLabel.textColor = item.isSelected?[UIColor colorWithHexString:titleSelectedColor]:[UIColor colorWithHexString:@"333333"];
    self.leftLine.hidden=!item.isSelected;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    
    
    self.leftLine.frame=CGRectMake(0, 0, 7*kScreenWidth/375, self.height);
    self.infoLabel.frame = CGRectMake(16*kScreenWidth/375, 0, self.width - 2 *LeftCellHorizontalMargin, self.height);
    self.bottomLine.frame = CGRectMake(0, self.height - 1.0/scale , self.width, 1.0/scale);
}

- (UILabel *)infoLabel {
    if (!_infoLabel) {
        _infoLabel = [[UILabel alloc] init];
        _infoLabel.backgroundColor = [UIColor clearColor];
        _infoLabel.font = [UIFont systemFontOfSize:15*kScreenWidth/375];
    }
    return _infoLabel;
}

- (CALayer *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [CALayer layer];
        _bottomLine.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.3].CGColor;
    }
    return _bottomLine;
}
-(UIView*)leftLine{
    
    if (!_leftLine) {
        _leftLine=[[UIView alloc]init];
        
        _leftLine.backgroundColor=[UIColor colorWithHexString:titleSelectedColor];
        
    }
    
    return _leftLine;
}
@end
