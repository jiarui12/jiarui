//
//  newSearchViewController.h
//  teamCollection
//
//  Created by 八九点 on 16/5/18.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import <UIKit/UIKit.h>
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
@interface newSearchViewController : UIViewController

@end
