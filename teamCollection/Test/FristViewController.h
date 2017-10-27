//
//  FristViewController.h
//  teamCollection
//
//  Created by 八九点 on 16/5/13.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "TheFatherViewController.h"
@protocol FristController <JSExport>

-(void)kpDetail:(int)kp_id;

-(void)customize_nodes:(NSString *)url;


@end
@interface FristViewController : TheFatherViewController

@end
