
//
//  newDetailViewController.m
//  teamCollection
//
//  Created by 八九点 on 16/8/22.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "newDetailViewController.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "PrefixHeader.pch"
#import "newheadViewTableViewCell.h"
#import "newOtherTableViewCell.h"
#import "WKProgressHUD.h"
#import "MBProgressHUD+HM.h"
#import "MyErWeiMaViewController.h"
#import <AliyunOSSiOS/AliyunOSSiOS.h>

NSString * const AccessKey = @"k6M7GQpNzeUWHJ6wftjIdqLFFHyLtA";
NSString * const SecretKey = @"LTAIARV4L6r8aHmj";

OSSClient * client;

@interface newDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIAlertViewDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSArray * nameArr;
@property(nonatomic,strong)NSDictionary * dic;
@property(nonatomic,strong)UIImage * image;
@property(nonatomic,strong)UIPickerView * picker;
@property(nonatomic,strong)NSArray * teams;
@property(nonatomic,strong)NSUserDefaults * user;
@property(nonatomic,strong)WKProgressHUD * hud;
@end
/*


 */
@implementation newDetailViewController
-(void)loadData{
    
    NSString *filePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    filePath = [filePath stringByAppendingFormat:@"/%@.plist",@"wode"];
    _dic=[NSMutableDictionary dictionaryWithContentsOfFile:filePath];
    if (_dic.count>0) {
        [_tableView removeFromSuperview];
        
        [self.view addSubview:_tableView];
        [self.tableView reloadData];
    }else{
     _hud = [WKProgressHUD showInView:self.view withText:@"加载中..." animated:YES];
    }
    
   

    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    NSString * Url=[NSString stringWithFormat:@"%@/BagServer/personalInfo.mob?token=%@",URLDOMAIN,[[NSUserDefaults standardUserDefaults] objectForKey:@"token"]];
   
    [manager POST:Url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        _dic=(NSDictionary *)responseObject;
        
        NSString *filePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
        filePath = [filePath stringByAppendingFormat:@"/%@.plist",@"wode"];
        [_dic writeToFile:filePath atomically:NO];
        [_tableView removeFromSuperview];
       
        
        
        [_hud dismiss:YES];
        
     
        [self.view addSubview:_tableView];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
         [_hud dismiss:YES];
    }];

}
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context {
    
    
        if ([change[@"new"] length]>0) {
            
    
             newheadViewTableViewCell * cell=[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
             [cell.headImage setImageWithURL:[NSURL URLWithString:change[@"new"]] placeholderImage:[UIImage imageNamed:@"man_default_icon"]];
            
    
        }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [OSSLog enableLog];
    
    [self initOSSClient];

    
    _dic=[NSDictionary new];
    _teams=@[@"男",@"女"];
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.navigationItem.title=@"我的资料";
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStyleGrouped];
    _tableView.sectionFooterHeight=10;
    _tableView.sectionHeaderHeight=0;
    _tableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 10)];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    
    [self loadData];
    
}
-(void)initOSSClient{

    
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    
    
  NSDictionary * userDic = [user objectForKey:@"aliyunOSS"];
    
    NSLog(@"%@",userDic);
    
    if (userDic.count>0) {
        
    
    
    
    id<OSSCredentialProvider> credential = [[OSSPlainTextAKSKPairCredentialProvider alloc] initWithPlainTextAccessKey:userDic[@"accessid"]
                                                                                                            secretKey:userDic[@"accessKey"]];
        
    // 自实现签名，可以用本地签名也可以远程加签
//    id<OSSCredentialProvider> credential1 = [[OSSCustomSignerCredentialProvider alloc] initWithImplementedSigner:^NSString *(NSString *contentToSign, NSError *__autoreleasing *error) {
//        NSString *signature = [OSSUtil calBase64Sha1WithData:contentToSign withSecret:SecretKey];
//        if (signature != nil) {
//            *error = nil;
//        } else {
//            // construct error object
//            *error = [NSError errorWithDomain:@"<your error domain>" code:OSSClientErrorCodeSignFailed userInfo:nil];
//            return nil;
//        }
//        return [NSString stringWithFormat:@"OSS %@:%@", AccessKey, signature];
//    }];
    

    
    
    OSSClientConfiguration * conf = [OSSClientConfiguration new];
    conf.maxRetryCount = 2;
    conf.timeoutIntervalForRequest = 30;
    conf.timeoutIntervalForResource = 24 * 60 * 60;
    
    client = [[OSSClient alloc] initWithEndpoint:@"https://oss-cn-beijing.aliyuncs.com" credentialProvider:credential clientConfiguration:conf];
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section==0) {
        return 5;
    }else{
    
        return 3;
    }
    
    
    
    

}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            newheadViewTableViewCell * cell=[newheadViewTableViewCell cellWithTableView:tableView];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            

            
            
            NSString *documentsPath =documentsDirectory;
            NSURL *url=[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/1.png",documentsPath]];
            
            NSData * data=[NSData dataWithContentsOfURL:url];
            if ( data) {
               [cell.headImage setImage:[UIImage imageWithData:data]];
                
                
                
            [cell.headImage setImageWithURL:[NSURL URLWithString:_dic[@"headIconUrl"]] placeholderImage:[UIImage imageNamed:@"man_default_icon"]];
                

                
                
            }else{
            
            [cell.headImage setImageWithURL:[NSURL URLWithString:_dic[@"headIconUrl"]] placeholderImage:[UIImage imageNamed:@"man_default_icon"]];
            }
           
            
            

            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            return cell;
        }else if(indexPath.row==1){
        
            newOtherTableViewCell *cell=[newOtherTableViewCell cellWithTableView:tableView];
//            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell.headLabel.text=_dic[@"userName"];
            cell.headLabel.textColor=[UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1.0];
            cell.headLabel.frame=CGRectMake(0, 0, self.view.frame.size.width-20, 50);
            cell.selectionStyle=UITableViewCellSelectionStyleNone;

            return    cell;

        
        
        }else if(indexPath.row==3){
            
            newOtherTableViewCell *cell=[newOtherTableViewCell cellWithTableView:tableView];
            //            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            NSString * str=[NSString stringWithFormat:@"%@",_dic[@"gender"]];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
            cell.detailLabel.text=@"性别";
            if ([str isEqualToString:@"1"]) {
                cell.headLabel.text=@"男";
            }else{
            cell.headLabel.text=@"女";
            }
            
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;

            return    cell;
            
            
            
        }else if(indexPath.row==2){
            
            newOtherTableViewCell *cell=[newOtherTableViewCell cellWithTableView:tableView];
            
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
            cell.detailLabel.text=@"手机号";
            //            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell.headLabel.text=[NSString stringWithFormat:@"%@",_dic[@"phoneNumber"]];
            cell.headLabel.textColor=[UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1.0];
            cell.headLabel.frame=CGRectMake(0, 0, self.view.frame.size.width-20, 50);
            return    cell;
            
            
            
        }else if(indexPath.row==4){
            
            newOtherTableViewCell *cell=[newOtherTableViewCell cellWithTableView:tableView];
            //            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            
            cell.detailLabel.text=@"二维码";
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
           
            UIImageView * er=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-60, 15, 20, 20)];
            er.image=[UIImage imageNamed:@"newErWeiMa"];
            [cell.contentView addSubview:er];
            
            cell.headLabel.hidden=YES;
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            
            return  cell;
            
            
            
        }else if(indexPath.row==5){
            
            newOtherTableViewCell *cell=[newOtherTableViewCell cellWithTableView:tableView];
            //            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            
            cell.detailLabel.text=@"个性签名";
            
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
            cell.headLabel.text=_dic[@"newsFeed"];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            
            return    cell;
            
            
            
        }else{
        
        
            newOtherTableViewCell *cell=[newOtherTableViewCell cellWithTableView:tableView];
            //            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell.headLabel.text=_dic[@"userName"];
            cell.headLabel.textColor=[UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1.0];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.headLabel.frame=CGRectMake(0, 0, self.view.frame.size.width-20, 50);
            return    cell;
        
        }
    }else{
        
        if (indexPath.row==0) {
            
            newOtherTableViewCell *cell=[newOtherTableViewCell cellWithTableView:tableView];
            //            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell.detailLabel.text=@"公司";
            
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
            cell.headLabel.text=_dic[@"companyName"];
            cell.headLabel.textColor=[UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1.0];
            cell.headLabel.frame=CGRectMake(0, 0, self.view.frame.size.width-20, 50);
            return    cell;
        }else if(indexPath.row==1){
        
            newOtherTableViewCell *cell=[newOtherTableViewCell cellWithTableView:tableView];
            //            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell.detailLabel.text=@"部门";
            
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
            cell.headLabel.text=_dic[@"departmentName"];
            cell.headLabel.textColor=[UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1.0];
            cell.headLabel.frame=CGRectMake(0, 0, self.view.frame.size.width-20, 50);
            return    cell;
        }
        
        newOtherTableViewCell *cell=[newOtherTableViewCell cellWithTableView:tableView];
        //            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.detailLabel.text=@"职位";
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        
        cell.headLabel.text=_dic[@"positionName"];
        cell.headLabel.textColor=[UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1.0];
        cell.headLabel.frame=CGRectMake(0, 0, self.view.frame.size.width-20, 50);
        return    cell;
    
}
   
}
-(void)viewWillAppear:(BOOL)animated{

    self.navigationController.navigationBarHidden=NO;
    
//    self.tabBarController.tabBar.hidden=YES;
//    UIImageView * image=[self.tabBarController.view viewWithTag:130];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];

//    image.hidden=YES;
    self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor blackColor]}];

}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            return 60;
        }else{
        
            return 50;
        }
        
    }else{
        return 50;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{return 0;}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            UIActionSheet * ac=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍摄",@"从相册选择", nil];
            
            
            
            [ac showInView:self.view];
        }
        
        if (indexPath.row==3) {
            UIAlertView * av=[[UIAlertView alloc]initWithTitle:@"请选择" message:@"" delegate:self cancelButtonTitle:nil otherButtonTitles:@"男",@"女",@"取消" ,nil];
            
            [av show];
        }if (indexPath.row==4) {
            MyErWeiMaViewController * my=[[MyErWeiMaViewController alloc]init];
            my.name=_dic[@"userName"];
            my.phone=_dic[@"phoneNumber"];
            [self.navigationController pushViewController:my animated:YES];
        }
    }
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 2){
        return;
    }
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    
    imagePicker.delegate =self;
    
    // 设置允许编辑
    imagePicker.allowsEditing = YES;
    
    if (buttonIndex == 0) {//照相
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else{//相册
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    // 显示图片选择器
    [self presentViewController:imagePicker animated:YES completion:nil];

}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:@"" animated:YES];

    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    
    
    NSDictionary * userDic = [user objectForKey:@"aliyunOSS"];
    UIImage *image = info[UIImagePickerControllerEditedImage];

    self.image = image;
    // 隐藏当前模态窗口
    [self dismissViewControllerAnimated:YES completion:^{
        
        
        
        OSSPutObjectRequest * put = [OSSPutObjectRequest new];
        
        put.bucketName = userDic[@"bucket"];
        put.objectKey = [NSString stringWithFormat:@"%@.jpg",userDic[@"key"]];
        put.uploadingData= UIImageJPEGRepresentation(image, 0.5);
        // optional fields
        put.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
            NSLog(@"%lld, %lld, %lld", bytesSent, totalByteSent, totalBytesExpectedToSend);
        };

        
        OSSTask * putTask = [client putObject:put];
        
        [putTask continueWithBlock:^id(OSSTask *task) {
            NSLog(@"objectKey: %@", put.objectKey);
            if (!task.error) {
                NSLog(@"upload object success!");
                
                
                dispatch_sync(dispatch_get_main_queue(), ^(){
                    // 这里的代码会在主线程执行
                    
                    
                    
                    [hud dismiss:YES];
                    
                    [MBProgressHUD showSuccess:@"修改成功"];
                    
                    newheadViewTableViewCell * cell=[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
//                    [cell.headImage setImageWithURL:[NSURL URLWithString:change[@"new"]] placeholderImage:[UIImage imageNamed:@"man_default_icon"]];
                    cell.headImage.image=image;
                    
                });
                
                NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
                
                
                
                
                
                AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
                manager.responseSerializer=[AFJSONResponseSerializer serializer];
                
                [manager POST:[NSString stringWithFormat:@"%@/BagServer/updatePersionalInfoNew.mob?token=%@&iconURL=%@",URLDOMAIN,[user objectForKey:@"token"],put.objectKey] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                   
                    NSLog(@"%@",responseObject);
                    
                    
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    NSLog(@"%@",error);
                    dispatch_sync(dispatch_get_main_queue(), ^(){
                        // 这里的代码会在主线程执行
                       
                        
                        [MBProgressHUD showSuccess:@"修改失败"];
                        
                        
                        
                        
                    });
                }];
                
                
              
                
                
                
                
                
                
            } else {
                NSLog(@"upload object failed, error: %@" , task.error);
            }
            return nil;
        }];
        
    }];


    
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{

    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _teams.count;

}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:
(NSInteger)row inComponent:(NSInteger)component
{
    // 使用一个UIAlertView来显示用户选中的列表项

}
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
  
    
    return [_teams objectAtIndex:row];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        AFHTTPSessionManager * session=[AFHTTPSessionManager manager];
        session.responseSerializer=[AFJSONResponseSerializer serializer];
        NSString * url=[NSString stringWithFormat:@"%@/BagServer/updatePersionalInfo.mob?token=%@&gender=1&newsFeed=1",URLDOMAIN,[[NSUserDefaults standardUserDefaults] objectForKey:@"token"]];
        
        NSLog(@"%@",url);
        
        [session POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
              [self loadData];
            [MBProgressHUD showSuccess:@"修改成功"];
        }];

    }else if(buttonIndex==1){
        AFHTTPSessionManager * session=[AFHTTPSessionManager manager];
        session.responseSerializer=[AFJSONResponseSerializer serializer];
        NSString * url=[NSString stringWithFormat:@"%@/BagServer/updatePersionalInfo.mob?token=%@&gender=2&newsFeed=1",URLDOMAIN,[[NSUserDefaults standardUserDefaults] objectForKey:@"token"]];
          NSLog(@"%@",url);
        [session POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"%@",responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"%@",error);
            [self loadData];
            [MBProgressHUD showSuccess:@"修改成功"];
        }];

    
    }
  
    
}


@end
