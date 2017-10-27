//
//  SourceManager.m
//  teamCollection
//
//  Created by 八九点 on 16/1/28.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "SourceManager.h"

@implementation SourceManager
+(SourceManager *)defaultManager{
    static SourceManager * sourceManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sourceManager=[[SourceManager alloc]init];
    });
    return sourceManager;
}
@end
