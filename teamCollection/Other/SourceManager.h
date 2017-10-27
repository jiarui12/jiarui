//
//  SourceManager.h
//  teamCollection
//
//  Created by 八九点 on 16/1/28.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMPPFramework.h"
@interface SourceManager : NSObject
@property (nonatomic, strong)XMPPMessageArchivingCoreDataStorage *msgStorage;//聊天的数据存储
+(SourceManager *)defaultManager;
@end
