//
//  MessageFrame.h

//

#define kMargin 10 //间隔
#define kIconWH 40 //头像宽高
#define kContentW 180 //内容宽度

#define kTimeMarginW 10 //时间文本与边框间隔宽度方向
#define kTimeMarginH 5 //时间文本与边框间隔高度方向

#define kContentTop 10 //文本内容与按钮上边缘间隔
#define kContentLeft 10 //文本内容与按钮左边缘间隔
#define kContentBottom 10 //文本内容与按钮下边缘间隔
#define kContentRight 10 //文本内容与按钮右边缘间隔

#define kTimeFont [UIFont systemFontOfSize:12] //时间字体
#define kContentFont [UIFont systemFontOfSize:16] //内容字体

#import <Foundation/Foundation.h>
#import "NSAttributedString+JTATEmoji.h"
#import <UIKit/UIKit.h>
@class Message;

@interface MessageFrame : NSObject

@property (nonatomic, assign, readonly) CGRect iconF;
@property (nonatomic, assign, readonly) CGRect timeF;
@property (nonatomic, assign, readonly) CGRect contentF;

@property (nonatomic, assign) CGFloat cellHeight; //cell高度

@property (nonatomic, strong) Message *message;

@property (nonatomic, assign) BOOL showTime;

@end
