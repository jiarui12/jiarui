//
//  messageModel.m
//  teamCollection
//
//  Created by 八九点 on 2016/12/1.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "messageModel.h"

@implementation messageModel
- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = super.init;
    if (self) {
        _identifier = [self uniqueIdentifier];
        _title = dictionary[@"title"];
        _content = dictionary[@"content"];
    }
    return self;
}

- (NSString *)uniqueIdentifier
{
    static NSInteger counter = 0;
    return [NSString stringWithFormat:@"unique-id-%@", @(counter++)];
}
@end
