//
//  AllWebViewController.h
//  teamCollection
//
//  Created by 八九点 on 16/1/15.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
@protocol DetailController <JSExport>

-(void)kpDetail:(int)ID;

@end


@interface AllWebViewController : UIViewController
@property(nonatomic,strong)NSString * webUrl;
@property(nonatomic,strong)NSMutableArray * nodeIDArray;
@property(nonatomic,weak)id<DetailController>delegate;
@end
