//
//  KnowledgeDetailViewController.h
//  teamCollection
//
//  Created by 八九点 on 16/1/18.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
@protocol KnowDetailController <JSExport>
-(void)getKPInfo:(NSString *)kpShareInfo;

@end
@interface KnowledgeDetailViewController : UIViewController
@property(nonatomic,strong)NSString * kpId;
@property(nonatomic,strong)NSString * fenlei;
@property(nonatomic,strong)NSString * webUrl;
@end
