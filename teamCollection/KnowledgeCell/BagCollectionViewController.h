//
//  BagCollectionViewController.h
//  teamCollection
//
//  Created by 八九点 on 16/7/22.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BagCollectionViewController : UICollectionViewController
@property(nonatomic,strong)NSString * category;


-(void)setDataWith:(NSString *)categary;
@end
