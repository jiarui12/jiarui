//
//  MessageFrame.m




#import "MessageFrame.h"
#import "Message.h"

@implementation MessageFrame
{

    NSAttributedString *attribute;
}
- (void)setMessage:(Message *)message{
    
    _message = message;
    
    // 0、获取屏幕宽度
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    // 1、计算时间的位置
    
        
        CGFloat timeY = kMargin;
//        CGSize timeSize = [_message.time sizeWithAttributes:@{UIFontDescriptorSizeAttribute: @"16"}];
        CGSize timeSize = [_message.time sizeWithFont:kTimeFont];
        
        CGFloat timeX = (screenW - timeSize.width) / 2;
        _timeF = CGRectMake(timeX, timeY, timeSize.width + kTimeMarginW, timeSize.height + kTimeMarginH);

    // 2、计算头像位置
    CGFloat iconX = kMargin;
    // 2.1 如果是自己发得，头像在右边
    if (_message.type == MessageTypeMe) {
        iconX = screenW - kMargin - kIconWH;
    }

    CGFloat iconY = CGRectGetMaxY(_timeF) + kMargin;
    _iconF = CGRectMake(iconX, iconY, kIconWH, kIconWH);

    // 3、计算内容位置
    CGFloat contentX = CGRectGetMaxX(_iconF) + kMargin;
    CGFloat contentY = iconY;
    if (message.content>0) {
        attribute = [NSAttributedString emojiAttributedString:message.content withFont:kContentFont];
    }
    UILabel * contentLable=[[UILabel alloc]init];
    
    [contentLable sizeToFit];

    [contentLable setAttributedText:attribute];
    
    //根据最大行数需求来设置
    contentLable.lineBreakMode = NSLineBreakByTruncatingTail;
    CGSize maximumLabelSize = CGSizeMake(kContentW, 9999);
    CGSize expectSize = [contentLable sizeThatFits:maximumLabelSize];
    
    if (_message.type == MessageTypeMe) {
        contentX = iconX - kMargin - expectSize.width - kContentLeft - kContentRight;
    }
    
    _contentF = CGRectMake(contentX, contentY, expectSize.width + kContentLeft + kContentRight, expectSize.height + kContentTop + kContentBottom);

    // 4、计算高度
    _cellHeight = MAX(CGRectGetMaxY(_contentF), CGRectGetMaxY(_iconF))  + kMargin;
}

@end
