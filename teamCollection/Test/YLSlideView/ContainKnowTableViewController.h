//
//  ContainKnowTableViewController.h
//  teamCollection
//
//  Created by 八九点 on 16/7/15.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContainKnowTableViewController : UIViewController
@property (strong, nonatomic) UIViewController *parentController;

@property (strong, nonatomic) UIColor *navigationBarBackgrourdColor;

+ (instancetype) containerControllerWithSubControlers:(NSArray<UIViewController *> *)viewControllers parentController:(UIViewController *)vc;

@end
