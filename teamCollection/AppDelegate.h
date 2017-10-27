//
//  AppDelegate.h
//  teamCollection
//
//  Created by 八九点 on 16/1/4.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/TencentApiInterface.h>
#import "WXApi.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,assign)BOOL allowRotation;
@property(strong,nonatomic)UIImageView * placeholderView;
@property(strong,nonatomic)UIImageView * logoView;
@end

