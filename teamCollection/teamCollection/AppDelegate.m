//
//  AppDelegate.m
//  teamCollection
//
//  Created by 八九点 on 16/1/4.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "MainViewController.h"
#import "SettingViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window=[[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    LoginViewController * login=[[LoginViewController alloc]init];
    login.title=@"班组汇";
    UINavigationController * nav=[[UINavigationController alloc]initWithRootViewController:login];
    nav.navigationBar.barTintColor=[UIColor colorWithRed:68/255.0 green:153/255.0 blue:252/255.0 alpha:1.0];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    
    [NSThread sleepForTimeInterval:0.0];
    
    MainViewController*main=[[MainViewController alloc]init];
    UINavigationController * navi=[[UINavigationController alloc]initWithRootViewController:main];
    navi.navigationBar.hidden=YES;
    
    
    self.window.rootViewController=nav;
    [self.window makeKeyAndVisible];

    
    _placeholderView=[[UIImageView alloc]initWithFrame:self.window.bounds];
    [_placeholderView setImage:[UIImage imageNamed:@"splash_bg.jpg"]];
    _logoView=[[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-50, 100, 100, 100)];
    _logoView.image=[UIImage imageNamed:@"ic_launcher"];
    UIImageView * bigWords=[[UIImageView alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-150)/2, 400, 150, 40)];
    bigWords.image=[UIImage imageNamed:@"bag_name_text"];
    [self.placeholderView addSubview:bigWords];
    
    [self.placeholderView addSubview:_logoView];
    
    
    [self.window addSubview:_placeholderView];
    [self.window bringSubviewToFront:_placeholderView];
    
    
    [UIView animateWithDuration:2 animations:^{
        bigWords.frame=CGRectMake(([UIScreen mainScreen].bounds.size.width-150)/2, 300, 150, 40);
    } completion:^(BOOL finished) {
        
    }];
        
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIImageView * smallView=[[UIImageView alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-250)/2, 400, 250, 70)];
        smallView.image=[UIImage imageNamed:@"bag_slogan_text"];
        [_placeholderView addSubview:smallView];
    });
    
    [UIView animateWithDuration:2 delay:3 options:UIViewAnimationOptionAllowAnimatedContent  animations:^{
        _placeholderView.alpha=0.0;
    } completion:^(BOOL finished) {
        [_placeholderView removeFromSuperview];
    }];
    
    return YES;
}
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{if (notification.userInfo) {
    NSNotification * noti=[NSNotification notificationWithName:@"pushMessage" object:nil userInfo:notification.userInfo];
        [[NSNotificationCenter defaultCenter] postNotification:noti];
    }
     [[UIApplication sharedApplication]setApplicationIconBadgeNumber:0];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
     [[UIApplication sharedApplication]setApplicationIconBadgeNumber:0];//进入前台取消应用消息图标
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
