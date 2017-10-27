

/*
   Cell View 在此只是继承 UITableView 
   如果自定义Cell 那必须增加 index 属性 ，本人比较懒直接使用 index 做些机制的处理
   自定义时没增加属性会导致奔溃
 */

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
@interface YLSlideCell : UITableView
@property (nonatomic,assign)NSInteger index;


+(YLSlideCell*)setMJrefresh;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com