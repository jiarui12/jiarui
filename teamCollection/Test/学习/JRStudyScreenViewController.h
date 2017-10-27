//
//  JRStudyScreenViewController.h
//  teamCollection
//
//  Created by 贾瑞 on 2017/5/2.
//  Copyright © 2017年 八九点. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JRStudyScreenViewController : UIViewController
@property (nonatomic, assign) BOOL isMultiSelection;
@property (nonatomic, strong)NSMutableString * keyWord;
@property (nonatomic, strong)NSMutableString * nodeName;
@property (nonatomic, strong)NSString * fristSelect;
@property (nonatomic, strong)NSString * secendSelect;
@property (nonatomic, strong)NSMutableString * nodeID;
@property(nonatomic,strong)NSString * categoryID;
@property(nonatomic,strong)NSMutableString * category;
@property(nonatomic,strong)NSString * secondName;

@end
