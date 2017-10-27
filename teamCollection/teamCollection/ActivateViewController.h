//
//  ActivateViewController.h
//  teamCollection
//
//  Created by 八九点 on 16/1/5.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol TestJSObjectProtocol <JSExport>

-(void)tologin;
-(void)startActivity4Scan;
-(void)chooseimg4wv;

@end
@interface ActivateViewController : UIViewController<TestJSObjectProtocol,UINavigationBarDelegate,UIImagePickerControllerDelegate>
{
    int num;
    BOOL upOrdown;
    NSTimer * timer;
    
}
@property (nonatomic, strong) UIImageView * line;
@property(nonatomic,assign)id<TestJSObjectProtocol>Delegate;
@end
