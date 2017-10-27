//
//  TheFatherViewController.m
//  teamCollection
//
//  Created by 八九点 on 2016/12/6.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "TheFatherViewController.h"

@interface TheFatherViewController ()

@end

@implementation TheFatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
 
    
    // Do any additional setup after loading the view.
}
-(void)dealloc{
    
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(PushMessage:) name:@"pushMessage" object:nil];

}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"pushMessage" object:nil];
}
-(void)PushMessage:(NSNotification*)notif{
    
 
    
    
    
    if (notif.userInfo) {
        UIAlertView * av=[[UIAlertView alloc]initWithTitle:notif.userInfo[@"pushTitle"] message:notif.userInfo[@"pushMsg"] delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        av.delegate=self;
        av.tag=1222;
//        [av show];
        
        
        
    }
    
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag==140) {
//        HistoryLoginViewController * his=[[HistoryLoginViewController alloc]init];
//        UINavigationController * nav=[[UINavigationController alloc]initWithRootViewController:his];
//        nav.navigationBar.barTintColor=[UIColor colorWithRed:44/255.0 green:140/255.0 blue:253/255.0 alpha:1.0];
//        [self presentViewController:nav animated:YES completion:^{
//            
//        }];
        
    }else{
        if (buttonIndex==1) {
            
            //            NewLoginViewController * new=[[NewLoginViewController alloc]init];
            //
            //
            //            [self.navigationController pushViewController:new animated:YES];
            
//            NSString * sql=@" select * from t_student ";
//            FMResultSet *result=[dataBase executeQuery:sql];
//            while(result.next){
//                int ids=[result intForColumn:@"id"];
//                NSString * name=[result stringForColumn:@"pushMsg"];
//                NSString * title=[result stringForColumn:@"pushTitle"];
//                //                int ids=[result intForColumnIndex:0];
//                //                NSString * name=[result stringForColumnIndex:1];
//                NSLog(@"%@,%d,%@",name,ids,title);
//            }
            
            
            
        }
        
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
