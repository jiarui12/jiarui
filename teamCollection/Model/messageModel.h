//
//  messageModel.h
//  teamCollection
//
//  Created by 八九点 on 2016/12/1.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface messageModel : NSObject
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, copy, readonly) NSString *identifier;
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *content;

@end
