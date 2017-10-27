//
//  ChatTool.h
//  teamCollection
//
//  Created by 八九点 on 16/3/3.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import "XMPPFramework.h"
@interface ChatTool : NSObject
singleton_interface(ChatTool);

@property (nonatomic, strong)XMPPStream *xmppStream;
//@property (nonatomic, strong,readonly)XMPPvCardTempModule *vCard;//电子名片
//@property (nonatomic, strong,readonly)XMPPRosterCoreDataStorage *rosterStorage;//花名册数据存储
//@property (nonatomic, strong,readonly)XMPPRoster *roster;//花名册模块
@property (nonatomic, strong)XMPPMessageArchivingCoreDataStorage *msgStorage;//聊天的数据存储
@end
