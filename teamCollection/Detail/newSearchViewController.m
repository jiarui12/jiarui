//
//  newSearchViewController.m
//  teamCollection
//
//  Created by 八九点 on 16/5/18.
//  Copyright © 2016年 八九点. All rights reserved.
//
#import "MTA.h"
#import "TheVideoClassViewController.h"
#import "newSearchViewController.h"
#import "PrefixHeader.pch"
#import "AFNetworking.h"
#import "O2OdetailTableViewCell.h"
#import "SearchDetailViewController.h"
#import "MBProgressHUD+HM.h"
#import "iflyMSC/IFlyRecognizerViewDelegate.h"
#import "iflyMSC/IFlyRecognizerView.h"
#import "iflyMSC/IFlySpeechConstant.h"
#import "biaoganViewController.h"
#import "JRStudyScreenViewController.h"
#import "JRSegmentViewController.h"
#import "introduceKnowledgeViewController.h"
#import "AboutKnowledgeTableViewController.h"
#import "NewCommentListTableViewController.h"
#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height
#define history  @"searchHistory"


@interface newSearchViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,IFlyRecognizerViewDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)UITableView * searchTableView;
@property(nonatomic,strong)NSMutableArray * titleArray;
@property(nonatomic,strong)NSMutableArray * kpIDArray;
@property(nonatomic,strong)NSMutableArray * hotArray;
@property(nonatomic,strong)NSMutableString * mutableString;
@property(nonatomic,strong)NSString * detailText;
@property(nonatomic,strong)UITextField * field;
@property(nonatomic,strong)UIView * topBtn;
@property(nonatomic,strong)NSMutableArray * historyData;
@property(nonatomic,strong)UIView * headView;
@end

@implementation newSearchViewController
{
IFlyRecognizerView      *_iflyRecognizerView;
}
-(void)start{
    
    [_iflyRecognizerView start];

    
    
}
- (void)onResult: (NSArray *)resultArray isLast:(BOOL) isLast
{
    

    
    NSMutableString *result = [[NSMutableString alloc] init];
    NSDictionary *dic = [resultArray objectAtIndex:0];
    
    for (NSString *key in dic) {
        
        
        if ([key isKindOfClass:[NSString class]]) {
            NSData *jsonData = [key dataUsingEncoding:NSUTF8StringEncoding];
            
            NSError *err;
            
            NSDictionary *Dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                 
                                                                options:NSJSONReadingMutableContainers  
                                 
                                                                  error:&err];
            NSLog(@"结果字符:%@",Dic[@"ws"][0][@"cw"][0][@"w"]);
            NSString * a=Dic[@"ws"][0][@"cw"][0][@"w"];
            if (a.length>0) {
                [result appendFormat:@"%@",a];
            }
            
            
        NSLog(@"类型%@",[NSString stringWithUTF8String:object_getClassName(Dic[@"ws"])]);
        }
        
        
    }
    if (_mutableString.length>0) {
        
        _mutableString =  [NSMutableString stringWithFormat:@"%@%@",_mutableString,result] ;

    }else{
    _mutableString =  [NSMutableString stringWithFormat:@"%@",result];
    }
    
    NSLog(@"识别结果：%@",_mutableString);
    
    
    
}
- (void)onError: (IFlySpeechError *) error
{
  
    if (_mutableString.length>0) {
        NSMutableArray * History=[NSMutableArray new];
    
        NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
        
        //    NSMutableArray * arr=(NSMutableArray *)[user objectForKey:history];
        NSMutableArray * arr=[NSMutableArray new];
        
        
        [arr addObjectsFromArray:[user objectForKey:history]];
        if (arr.count>0) {
            
            if ([arr containsObject:_mutableString]) {
                [arr removeObject:_mutableString];
                [arr insertObject:_mutableString atIndex:0];
            }else{
                
                if (arr.count==10) {
                    [arr removeLastObject];
                }
                
                [arr insertObject:_mutableString atIndex:0];
                
            }
            
            [user setObject:arr forKey:history];
        }else{
            
            
            [History addObject:_mutableString];
            [user setObject:History forKey:history];
            
        }

    
        
        _historyData=[NSMutableArray new];
        
        [_historyData addObjectsFromArray:[user objectForKey:history]];
        
        [self.searchTableView reloadData];
    
        JRStudyScreenViewController * jr=[[JRStudyScreenViewController alloc]init];
        [self addChildViewController:jr];
        
        
        
        jr.view.frame=CGRectMake(0, 0, WIDTH, HEIGHT);
        jr.view.tag=1111;
        jr.keyWord=_mutableString;
        jr.nodeName=[NSMutableString stringWithFormat:@"全部知识"];
        [self.view addSubview:jr.view];
        self.field.text=_mutableString;
        
        UIButton * claerBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        claerBtn.frame=CGRectMake(WIDTH*565/750, 0, 32, 32);
        
        [claerBtn setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        claerBtn.tag=333333;
        [claerBtn addTarget:self action:@selector(deleteFeildText:) forControlEvents:UIControlEventTouchUpInside];
        [_headView addSubview:claerBtn];
        
        [self.field resignFirstResponder];
        _mutableString=nil;
    }
    
    
    
    if (_historyData.count>0) {
        
        UIButton * fotterV=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 44)];
        
        [fotterV setTitle:@"  清除搜索记录" forState:UIControlStateNormal];
        [fotterV setTitleColor:[UIColor colorWithRed:44/255.0 green:180/255.0 blue:237/255.0 alpha:1.0] forState:UIControlStateNormal];
        fotterV.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [fotterV addTarget:self action:@selector(clearHistory:) forControlEvents:UIControlEventTouchUpInside];
        fotterV.backgroundColor=[UIColor whiteColor];
        fotterV.titleLabel.font=[UIFont systemFontOfSize:WIDTH *14/375];
        self.searchTableView.tableFooterView=fotterV;
    }else{
        UILabel * fotterV=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 44)];
        fotterV.text=@"  暂无搜索记录";
        
        fotterV.font=[UIFont systemFontOfSize:WIDTH *14/375];
        fotterV.textColor=[UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1.0];
        fotterV.backgroundColor=[UIColor whiteColor];
        self.searchTableView.tableFooterView=fotterV;
        
        
    }
    [self.searchTableView reloadData];
    
    

    
    
    
    
//        AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
//        manager.responseSerializer=[AFJSONResponseSerializer serializer];
//        NSDictionary * dic=@{@"content":_mutableString,@"pageIndex":@"1"};
//        NSString * url=[NSString stringWithFormat:@"%@/WeChat/just_search.wc",URLDOMAIN];
//        [manager POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
//            
//            NSDictionary * dic=(NSDictionary *)responseObject;
//            if (dic.count) {
//                
//                
//                if ([dic[@"ret"]isEqualToString:@"success"]) {
//                    
//                    
//                    [MTA trackCustomEvent:@"search_by_xunfei" args:[NSArray arrayWithObject:@"arg0"]];
//
//                    SearchDetailViewController * detail=[[SearchDetailViewController alloc]init];
//                    detail.data=dic;
//                    detail.String=_mutableString;
//                    [self.navigationController pushViewController:detail animated:NO];
//                     _mutableString=nil;
//                }
//                
//            }
//            if ([dic[@"ret"]isEqualToString:@"not_match"]) {
//                
//                [MBProgressHUD showError:@"没有相关内容"];
//                _mutableString=nil;
//            }
//            
//            
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            
//            [MBProgressHUD showError:@"服务器开小差了~"];
//        }];
//       
//    }else{
//    
//    
//    [MBProgressHUD showError:@"未检测到语音"];
//    
//    }
//    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.view.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];

    
    
    [self setNavigationBar];
    
    
    
    
    [self setHotSearch];
    
    [self setupXunfei];
    
    
    [self addXunfeiBtn];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
    
    self.searchTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.searchTableView.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    
    self.searchTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    
 
    
}




-(void)setHotSearch{


    _titleArray=[NSMutableArray new];
    _kpIDArray=[NSMutableArray new];
    
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    
    _searchTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64)style:UITableViewStylePlain];
    
    _searchTableView.delegate=self;
    _searchTableView.dataSource=self;
    
    [self.view addSubview:_searchTableView];

    
    
    
    
    UILabel * search=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH*10/375, 80, WIDTH, 30)];
    
    
    search.text=@"热门搜索";
    search.font=[UIFont systemFontOfSize:14];
    search.textColor=[UIColor colorWithRed:164/255.0 green:164/255.0 blue:164/255.0 alpha:1.0];
    
//    [self.view addSubview:search];
    
    
    
    
    
    
    
    _hotArray=[NSMutableArray new];
    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    NSString * url=[NSString stringWithFormat:@"%@/WeChat/get_history_word.wc?page_index=1",URLDOMAIN];
    [manager POST:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSDictionary * dic=(NSDictionary *)responseObject;
        if ([dic[@"ret"] isEqualToString:@"success"]) {
            NSData * data=[dic[@"list"] dataUsingEncoding:NSUTF8StringEncoding];
            NSArray *Dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            for (NSDictionary * dic in Dic) {
                [_hotArray addObject:dic[@"search_word"]];
                
            }
            
            CGFloat w = 0;//保存前一个button的宽以及前一个button距离屏幕边缘的距离
            CGFloat h = 10;//用来控制button距离父视图的高
            O2OdetailTableViewCell * cell=[self.searchTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            for (int i = 0; i < _hotArray.count; i++) {
                UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
                button.tag = 100 + i;
                
                [button addTarget:self action:@selector(handleClick:) forControlEvents:UIControlEventTouchUpInside];
                [button setTitleColor:[UIColor colorWithRed:33/255.0 green:33/255.0 blue:33/255.0 alpha:1.0] forState:UIControlStateNormal];        //根据计算文字的大小
                button.layer.cornerRadius=12;
                NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
                CGFloat length = [_hotArray[i] boundingRectWithSize:CGSizeMake(WIDTH, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width;
                //为button赋值
                button.titleLabel.font=[UIFont systemFontOfSize:WIDTH *12/375];
                [button setTitle:_hotArray[i] forState:UIControlStateNormal];
                //设置button的frame
                button.frame = CGRectMake(10 + w, h, length + 15 , 30);
                //当button的位置超出屏幕边缘时换行 320 只是button所在父视图的宽度
                if(10 + w + length + 15 > WIDTH){
                    w = 0; //换行时将w置为0
                    h = h + button.frame.size.height + 13;//距离父视图也变化
                    button.frame = CGRectMake(10 + w, h, length + 15, 30);//重设button的frame
                }
                w = button.frame.size.width + button.frame.origin.x;
                CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
                // 新建一个红色的ColorRef，用于设置边框（四个数字分别是 r, g, b, alpha）
                CGColorRef borderColorRef = CGColorCreate(colorSpace,(CGFloat[]){ 220/255.0, 220/255.0, 220/255.0, 1 });
                button.layer.borderWidth=0.5;
                button.layer.borderColor=borderColorRef;
                
                
                
                
                [cell.contentView addSubview:button];
                
//                [self.view addSubview:button];
            }
            
            
            
        }
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
        
        
    }];



}



-(void)setupXunfei{


    _iflyRecognizerView = [[IFlyRecognizerView alloc] initWithCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2-90)];
    _iflyRecognizerView.delegate = self;
    [_iflyRecognizerView setParameter: @"iat" forKey: [IFlySpeechConstant IFLY_DOMAIN]];
    //asr_audio_path保存录音文件名，如不再需要，设置value为nil表示取消，默认目录是documents
    [_iflyRecognizerView setParameter:@"asrview.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
    //启动识别服务
    [_iflyRecognizerView setParameter:[IFlySpeechConstant ASR_PTT_NODOT] forKey:[IFlySpeechConstant ASR_PTT]];
    



}



-(void)setNavigationBar{

    
    
    UIButton * button1=[UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setBackgroundImage:[UIImage imageNamed:@"icon_nav_ retult_defult_2x"] forState:UIControlStateNormal];
    UIBarButtonItem * left=[[UIBarButtonItem alloc]initWithCustomView:button1];
    [self.navigationItem setLeftBarButtonItem:left];
    

    
    
    
    UIButton * Btn=[UIButton buttonWithType:UIButtonTypeSystem];
    [Btn setTitle:@"取消" forState:UIControlStateNormal];
    [Btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    Btn.frame=CGRectMake(3, 0, 40, 20);
    
    UIView * view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 20)];
    
    
    [view addSubview:Btn];
    
    UIBarButtonItem * right=[[UIBarButtonItem alloc]initWithCustomView:view];
    [Btn addTarget:self action:@selector(Back:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setRightBarButtonItem:right];
    
    UIView * mainView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH*625/750, 32)];
    
    
    
    _headView=[[UIView alloc]initWithFrame:CGRectMake(-10, 0, WIDTH*625/750, 32)];
    
    _headView.backgroundColor=[UIColor whiteColor];
    
    UIImageView * imageVIew=[[UIImageView alloc]initWithFrame:CGRectMake(HEIGHT*6/667, HEIGHT*7.5/667, 14,  14)];
    
    imageVIew.image=[UIImage imageNamed:@"search_top"];
    UIColor *color = [UIColor colorWithRed:164/255.0 green:164/255.0 blue:164/255.0 alpha:1.0];
    _field=[[UITextField alloc]initWithFrame:CGRectMake(28, 0, WIDTH*546/750, 32)];
    _field.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"请输入知识关键字" attributes:@{NSForegroundColorAttributeName:color}];
    _field.tag=300;
    _field.font=[UIFont systemFontOfSize:14];
    [_field addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    _field.returnKeyType=UIReturnKeySearch;
    _field.delegate=self;
    _field.enablesReturnKeyAutomatically = YES;
    
    
    [_headView addSubview:_field];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             [_field becomeFirstResponder];
        });
    _headView.layer.cornerRadius=WIDTH*5/375;
    [_headView addSubview:imageVIew];
    
    [mainView addSubview:_headView];
    
    self.navigationItem.titleView=mainView;


}


-(void)addXunfeiBtn{


    _topBtn=[[UIView alloc]init];
    _topBtn.frame=CGRectMake(0, HEIGHT,WIDTH,HEIGHT* 50/667);
    _topBtn.backgroundColor=UIColorFromRGB(0xf8f8f8);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    // 新建一个红色的ColorRef，用于设置边框（四个数字分别是 r, g, b, alpha）
    CGColorRef borderColorRef = CGColorCreate(colorSpace,(CGFloat[]){ 223/255.0, 223/255.0, 223/255.0, 1 });
    _topBtn.layer.borderWidth=0.5;
    _topBtn.layer.borderColor=borderColorRef;
    
    
    UIButton * xunfei=[UIButton buttonWithType:UIButtonTypeCustom];
    xunfei.frame=CGRectMake(WIDTH* 15/375, HEIGHT*8/667, WIDTH*345/375, HEIGHT*34/667);
    
    xunfei.backgroundColor=UIColorFromRGB(0xf9f9f9);
    xunfei.layer.borderWidth=0.5;
    xunfei.layer.borderColor=borderColorRef;
    xunfei.layer.cornerRadius=5;
    [xunfei setImage:[UIImage imageNamed:@"icon_voice_defult@2x"] forState:UIControlStateNormal];
    [xunfei setTitle:@"语音输入" forState:UIControlStateNormal];
    [xunfei setTitleColor:UIColorFromRGB(0x777777) forState:UIControlStateNormal];
    xunfei.titleLabel.font=[UIFont systemFontOfSize:WIDTH* 16/375];
    [xunfei setBackgroundImage:[UIImage imageNamed:@"image_button_background@2x"] forState:UIControlStateHighlighted];
    xunfei.titleEdgeInsets=UIEdgeInsetsMake(HEIGHT* 10/667,WIDTH*135/375, HEIGHT* 10/667,WIDTH* 123/375);
    [xunfei addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    
    [_topBtn addSubview:xunfei];
    
    
    
    
    [self.view addSubview:_topBtn];



}
-(void)textFieldDidChange:(UITextField*)field{

    [_titleArray removeAllObjects];
    [_kpIDArray removeAllObjects];
    [_tableView reloadData];
    
    
    
    
    
    UIButton * butt=[self.headView viewWithTag:333333];
    
    [butt removeFromSuperview];
    
    butt=nil;
    
    
    UIView * view=[self.view viewWithTag:1111];
    
    
    [view removeFromSuperview];
    view=nil;
    
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    NSString * token=[user objectForKey:@"token"];
    
    
    
    NSString *strUrl = [field.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    
    if (strUrl.length==0) {
        
        
        
        [_tableView removeFromSuperview];
        
        
        UIButton * butt=[self.headView viewWithTag:333333];
        
        [butt removeFromSuperview];
        
        butt=nil;
        
    }
    if (strUrl.length>0) {
        
        UIButton * butt=[self.headView viewWithTag:333333];
        
        [butt removeFromSuperview];
        
        butt=nil;
        
        
        UIButton * claerBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        claerBtn.frame=CGRectMake(WIDTH*565/750, 0, 32, 32);
        
        [claerBtn setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        claerBtn.tag=333333;
        [claerBtn addTarget:self action:@selector(deleteFeildText:) forControlEvents:UIControlEventTouchUpInside];
        [_headView addSubview:claerBtn];
        
        AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
        manager.responseSerializer=[AFJSONResponseSerializer serializer];
        NSString * str=[NSString stringWithFormat:@"%@/WeChat/just_search.wc",URLDOMAIN];
         NSDictionary * dic=@{@"content":field.text,@"pageIndex":@"1",@"token":token};
        
        [manager POST:str parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [_tableView removeFromSuperview];
            NSDictionary *  dic=(NSDictionary*)responseObject;
            if (dic.count!=0) {
                
                
                NSArray * arr=dic[@"list"];
                if ([dic[@"list"] count]>0) {
                    
                
                    [_titleArray removeAllObjects];
                    [_kpIDArray removeAllObjects];
                
                if ([dic[@"list"] count]>10) {
                    
                   
                    
                    arr=[arr subarrayWithRange:NSMakeRange(0, 10)];
                }
               
                for (NSDictionary * subDic in arr) {
                    NSLog(@"%@",arr);
                    
                    
                    [_titleArray addObject:subDic[@"title"]];
                    [_kpIDArray addObject:subDic];
                    
                    
                }
                
               
            }
                
            }
            
        
            [self.view addSubview:_tableView];

            [self.tableView reloadData];
           
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            
            NSLog(@"%@",error);
        }];
        

    }


}
-(void)deleteFeildText:(UIButton*)button{

    _field.text=nil;

    UIButton * butt=[self.headView viewWithTag:333333];
    
    [butt removeFromSuperview];
    
    butt=nil;

    [_tableView removeFromSuperview];
    UIView * view=[self.view viewWithTag:1111];
    
    [view removeFromSuperview];
    
    view=nil;
    
}
-(void)cancelSearch:(UIBarButtonItem * )button{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)Back:(UIBarButtonItem *)button{
    [self.navigationController popViewControllerAnimated:NO];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{


    if (_searchTableView==tableView) {
        
        if (indexPath.section==0) {
          return 100;
        }else{
            
            return 44;
        }
        
    }else{
        
        return 44;
        
    }

    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView==_tableView) {
        
    

    O2OdetailTableViewCell * cell=[O2OdetailTableViewCell cellWithTableView:tableView ];
    cell.TitleLabel.text=_titleArray[indexPath.row];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
        
    }else{
        
    
        O2OdetailTableViewCell * cell=[O2OdetailTableViewCell cellWithTableView:tableView ];
        UIView * view=[cell.contentView viewWithTag:22222];
        [view removeFromSuperview];
        view=nil;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.TitleLabel.font=[UIFont systemFontOfSize:WIDTH *14/375];
        cell.TitleLabel.textColor=[UIColor colorWithRed:33/255.0 green:33/255.0 blue:33/255.0 alpha:1.0];
        
        UIView * buttomView=[[UIView alloc]initWithFrame:CGRectMake(0,99, WIDTH, 0.5)];
        
        
        buttomView.backgroundColor=[UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1.0];
        buttomView.tag=22222;
        [cell.contentView addSubview:buttomView];
        
        UIButton * BUUU=[cell.contentView viewWithTag:indexPath.row+1000];
        
        [BUUU removeFromSuperview];
    
        BUUU=nil;
        if (indexPath.section==1) {
            UIView * view=[cell.contentView viewWithTag:22222];
            [view removeFromSuperview];
            view=nil;
            cell.TitleLabel.text=_historyData[indexPath.row];
            UIButton * claerBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            claerBtn.frame=CGRectMake(WIDTH-44, 0, 44, 44);
            
            [claerBtn setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
            claerBtn.tag=indexPath.row+1000;
            [claerBtn addTarget:self action:@selector(deleteOneHistory:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:claerBtn];
            
        }
        return cell;
    }
}
-(void)deleteOneHistory:(UIButton *)button{
  
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    
    _historyData=[NSMutableArray arrayWithArray:_historyData];
  
   
    
    if (_historyData.count>1) {
        
        NSLog(@"%s",object_getClassName(_historyData));
        
        
        NSLog(@"%@",_historyData);
        
        
        
        
        [_historyData removeObjectAtIndex:button.tag-1000];
        
        
        
        
    }else{
        
        
        _historyData = nil;
        
        
        
    }
    
    
    
    if (_historyData.count==0) {
        UILabel * fotterV=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 44)];
        fotterV.text=@"  暂无搜索记录";
        
        fotterV.font=[UIFont systemFontOfSize:WIDTH *14/375];
        fotterV.textColor=[UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1.0];
        fotterV.backgroundColor=[UIColor whiteColor];
        self.searchTableView.tableFooterView=fotterV;
        
        NSMutableArray * a=[NSMutableArray new];
        [user setObject:a forKey:history];
    }else{
    
    [user setObject:_historyData forKey:history];
    }
    
    
    
    
    
    [_searchTableView reloadData];
    


}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView==_searchTableView) {
        
        if (section==0) {
          return 1;
        }else{
        
            return _historyData.count;
        }
        
    }else if(tableView==_tableView){
    
    
        return _titleArray.count;
    }else{
    
        return 0;
    }
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    if (tableView==_searchTableView) {
        
        
        
        return 2;
    }else{

    return 1;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (_tableView==tableView) {
        return 0;
    }
    return (WIDTH *44/375);//自定义高度
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UIView * view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, WIDTH * 44/375)];
    view.backgroundColor=[UIColor whiteColor];
    
    UIButton * imageV=[[UIButton alloc]initWithFrame:CGRectMake(-10, 0, WIDTH * 44/375, WIDTH * 44/375)];
    
//    [imageV setContentMode:UIViewContentModeScaleToFill];

    
    
    UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH *25/375, 0, WIDTH, WIDTH*44/375)];
    if (section==0) {
        
        [imageV setImage:[UIImage imageNamed:@"hot_search"] forState:UIControlStateNormal];
        label.text=@"热门搜索";
    }else{
        [imageV setImage:[UIImage imageNamed:@"recent_search"]forState:UIControlStateNormal];
    label.text=@"最近搜索";
    }
    
    label.font=[UIFont systemFontOfSize:WIDTH *15/375];
    
    label.textColor=[UIColor colorWithRed:127/255.0 green:127/255.0 blue:127/255.0 alpha:1.0];
    
    
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    // 新建一个红色的ColorRef，用于设置边框（四个数字分别是 r, g, b, alpha）
    CGColorRef borderColorRef = CGColorCreate(colorSpace,(CGFloat[]){ 255/255.0, 255/255.0, 255/255.0, 1 });
    view.layer.borderWidth=0.5;
    view.layer.borderColor=borderColorRef;

    
    [view addSubview:label];
    
    
    
    
    
    
    [view addSubview:imageV];
    return view;
    



}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];

    if (tableView==_tableView) {
        
        UIView * view=[self.view viewWithTag:1111];
        [view removeFromSuperview];
        view=nil;
        
        
        NSString * cate=[NSString stringWithFormat:@"%@",_kpIDArray[indexPath.row][@"catagoryName"]];
        NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
        
        
        NSString * token=[user objectForKey:@"token"];
        NSString * kpID=[NSString stringWithFormat:@"%@",_kpIDArray[indexPath.row][@"kpID"]];
        
        JRSegmentViewController *vc = [[JRSegmentViewController alloc] init];
        vc.segmentBgColor = [UIColor clearColor];
        vc.indicatorViewColor = [UIColor whiteColor];
        vc.titleColor = [UIColor whiteColor];
        introduceKnowledgeViewController * a=[[introduceKnowledgeViewController alloc]init];
        
        AboutKnowledgeTableViewController * b=[[AboutKnowledgeTableViewController alloc]init];
        
        
        NewCommentListTableViewController * c=[[NewCommentListTableViewController alloc]init];
        
        a.kpId=kpID;
        b.kpID=kpID;
        
        //        a.kpId=@"4751";
        c.kpID=kpID;
        if (token.length<8) {
            
        
        [vc setViewControllers:@[a]];
            
        }else{
        [vc setViewControllers:@[a,b,c]];
            
        }
        
        [vc setTitles:@[@"介绍", @"相关知识", @"评论"]];
        vc.kpID=kpID;
        vc.kTitle=_kpIDArray[indexPath.row][@"title"];
        vc.kContent=_kpIDArray[indexPath.row][@"summary"];
        vc.kIconUrl=_kpIDArray[indexPath.row][@"iconUrl"];
        vc.hidesBottomBarWhenPushed=YES;
        if ([cate isEqualToString:@"微课"]) {
            
            TheVideoClassViewController * video=[[TheVideoClassViewController alloc]init];
            video.kTitle=_kpIDArray[indexPath.row][@"title"];
            video.kContent=_kpIDArray[indexPath.row][@"summary"];
            video.kIconUrl=_kpIDArray[indexPath.row][@"iconUrl"];
            video.kpId=kpID;
            video.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:video animated:YES];
            
        }else{
            
            
            
            
            [self.navigationController pushViewController:vc animated:YES];
            
            
        }
        
        

        
        
    }else{
    
        
        
        
        JRStudyScreenViewController * jr=[[JRStudyScreenViewController alloc]init];
        [self addChildViewController:jr];
        
        
        
        jr.view.frame=CGRectMake(0, 0, WIDTH, HEIGHT);
        jr.view.tag=1111;
        jr.keyWord=_historyData[indexPath.row];
        
        NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
        
        NSString * String1=[NSString stringWithFormat:@"%da%da%d",0,-1,-1];
        [user setObject:String1 forKey:@"selectedArray"];

        
        jr.nodeName=[NSMutableString stringWithFormat:@"全部知识"];
        [self.view addSubview:jr.view];
        self.field.text=_historyData[indexPath.row];
        UIButton * claerBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        claerBtn.frame=CGRectMake(WIDTH*565/750, 0, 32, 32);
        
        [claerBtn setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        claerBtn.tag=333333;
        [claerBtn addTarget:self action:@selector(deleteFeildText:) forControlEvents:UIControlEventTouchUpInside];
        [_headView addSubview:claerBtn];
        [self.field resignFirstResponder];
    
//        AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
//        manager.responseSerializer=[AFJSONResponseSerializer serializer];
//        NSDictionary * dic=@{@"content":_historyData[indexPath.row],@"pageIndex":@"1",@"token":[user objectForKey:@"token"]};
//        NSString * url=[NSString stringWithFormat:@"%@/WeChat/just_search.wc",URLDOMAIN];
//        [manager POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            NSDictionary * dic=(NSDictionary *)responseObject;
//            
//            
//            if (dic.count) {
//                if ([dic[@"ret"]isEqualToString:@"success"]) {
//                    SearchDetailViewController * detail=[[SearchDetailViewController alloc]init];
//                    detail.data=dic;
//                    detail.String=_historyData[indexPath.row];
//                    [self.navigationController pushViewController:detail animated:NO];
//                    
//                }
//                
//                
//                
//                
//            }
//            
//            if ([dic[@"ret"] isEqualToString:@"not_match"]) {
//                
//                [MBProgressHUD showError:@"没有相关内容"];
//                
//                
//            }
//            
//            
//            
//            
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            
//            
//            [MBProgressHUD showError:@"服务器开小差了~"];
//        }];
//
    
    
    
    }
}
-(void)handleClick:(UIButton*)button{
   
    
    
    [MTA trackCustomEvent:@"search_by_key" args:[NSArray arrayWithObject:@"arg0"]];

    
    
    
    
    NSMutableArray * History=[NSMutableArray new];
    
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    
//    NSMutableArray * arr=(NSMutableArray *)[user objectForKey:history];
    NSMutableArray * arr=[NSMutableArray new];
    
    
    [arr addObjectsFromArray:[user objectForKey:history]];
    if (arr.count>0) {
        
        if ([arr containsObject:button.titleLabel.text]) {
            [arr removeObject:button.titleLabel.text];
            [arr insertObject:button.titleLabel.text atIndex:0];
        }else{
            
            if (arr.count==10) {
                [arr removeLastObject];
            }
            
            [arr insertObject:button.titleLabel.text atIndex:0];
            
        }
        
        [user setObject:arr forKey:history];
    }else{
        
        
        [History addObject:button.titleLabel.text];
        [user setObject:History forKey:history];
        
    }
    
    
    
    _historyData=[NSMutableArray new];
    
    [_historyData addObjectsFromArray:[user objectForKey:history]];
    
    [self.searchTableView reloadData];
    
    JRStudyScreenViewController * jr=[[JRStudyScreenViewController alloc]init];
    
    NSString * String1=[NSString stringWithFormat:@"%da%da%d",0,-1,-1];
    [user setObject:String1 forKey:@"selectedArray"];
    [self addChildViewController:jr];
    
    
    
    jr.view.frame=CGRectMake(0, 0, WIDTH, HEIGHT);
    jr.view.tag=1111;
    jr.keyWord=_hotArray[button.tag-100];
    jr.nodeName=[NSMutableString stringWithFormat:@"全部知识"];
    [self.view addSubview:jr.view];
    
    
    self.field.text=_hotArray[button.tag-100];
    UIButton * claerBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    claerBtn.frame=CGRectMake(WIDTH*565/750, 0, 32, 32);
    [claerBtn setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
    claerBtn.tag=333333;
    [claerBtn addTarget:self action:@selector(deleteFeildText:) forControlEvents:UIControlEventTouchUpInside];
    [_headView addSubview:claerBtn];
    [self.field resignFirstResponder];
    
    
    
    if (_historyData.count>0) {
        
        UIButton * fotterV=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 44)];
        
        [fotterV setTitle:@"  清除搜索记录" forState:UIControlStateNormal];
        [fotterV setTitleColor:[UIColor colorWithRed:44/255.0 green:180/255.0 blue:237/255.0 alpha:1.0] forState:UIControlStateNormal];
        fotterV.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [fotterV addTarget:self action:@selector(clearHistory:) forControlEvents:UIControlEventTouchUpInside];
        fotterV.backgroundColor=[UIColor whiteColor];
        fotterV.titleLabel.font=[UIFont systemFontOfSize:WIDTH *14/375];
        self.searchTableView.tableFooterView=fotterV;
    }else{
        UILabel * fotterV=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 44)];
        fotterV.text=@"  暂无搜索记录";
        
        fotterV.font=[UIFont systemFontOfSize:WIDTH *14/375];
        fotterV.textColor=[UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1.0];
        fotterV.backgroundColor=[UIColor whiteColor];
        self.searchTableView.tableFooterView=fotterV;
        
        
    }
    [self.searchTableView reloadData];
    
    

    
//    
//    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
//    manager.responseSerializer=[AFJSONResponseSerializer serializer];
//    NSDictionary * dic=@{@"content":_hotArray[button.tag-100],@"pageIndex":@"1",@"token":[user objectForKey:@"token"]};
//    NSString * url=[NSString stringWithFormat:@"%@/WeChat/just_search.wc",URLDOMAIN];
//    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSDictionary * dic=(NSDictionary *)responseObject;
//        
//        
//        if (dic.count) {
//            if ([dic[@"ret"]isEqualToString:@"success"]) {
////                SearchDetailViewController * detail=[[SearchDetailViewController alloc]init];
////                detail.data=dic;
////                detail.String=_hotArray[button.tag-100];
////                [self.navigationController pushViewController:detail animated:NO];
//                
//                
//                
//              
//            }
//
//            
//           
//            
//        }
//        
//        if ([dic[@"ret"] isEqualToString:@"not_match"]) {
//            
//             [MBProgressHUD showError:@"没有相关内容"];
//            
//            
//        }
//        
//        
//        
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//        
//         [MBProgressHUD showError:@"服务器开小差了~"];
//    }];

}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    NSMutableArray * History=[NSMutableArray new];
    
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    
    NSMutableArray * arr=[NSMutableArray new];
    NSString *strUrl = [_field.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    [arr addObjectsFromArray:[user objectForKey:history]];
    if (strUrl.length>0) {
        
    
    if (arr.count>0) {
        
        if ([arr containsObject:strUrl]) {
            [arr removeObject:strUrl];
            [arr insertObject:strUrl atIndex:0];
        }else{
        
            if (arr.count==10) {
                [arr removeLastObject];
            }
            
            
            
            
            [arr insertObject:strUrl atIndex:0];
        
        }
        
        [user setObject:arr forKey:history];
    }else{
     
        
        [History addObject:strUrl];
        [user setObject:History forKey:history];
        
    }
    
    
    _historyData=[NSMutableArray new];
    
    [_historyData addObjectsFromArray:[user objectForKey:history]];
        
        
        
        
        
        
    
    [self.searchTableView reloadData];
}
    
    
    
    
    
    
    
    if (_historyData.count>0) {
        
        UIButton * fotterV=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 44)];
        
        [fotterV setTitle:@"  清除搜索记录" forState:UIControlStateNormal];
        [fotterV setTitleColor:[UIColor colorWithRed:44/255.0 green:180/255.0 blue:237/255.0 alpha:1.0] forState:UIControlStateNormal];
        fotterV.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [fotterV addTarget:self action:@selector(clearHistory:) forControlEvents:UIControlEventTouchUpInside];
        fotterV.backgroundColor=[UIColor whiteColor];
        fotterV.titleLabel.font=[UIFont systemFontOfSize:WIDTH *14/375];
        self.searchTableView.tableFooterView=fotterV;
    }else{
        UILabel * fotterV=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 44)];
        fotterV.text=@"  暂无搜索记录";
        
        fotterV.font=[UIFont systemFontOfSize:WIDTH *14/375];
        fotterV.textColor=[UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1.0];
        fotterV.backgroundColor=[UIColor whiteColor];
        self.searchTableView.tableFooterView=fotterV;
        
        
    }
    [self.searchTableView reloadData];
    
    

    
    
    
    
    
    
    
    
    [MTA trackCustomEvent:@"search_by_write" args:[NSArray arrayWithObject:@"arg0"]];

    
    
    
    
    
    JRStudyScreenViewController * jr=[[JRStudyScreenViewController alloc]init];
    [self addChildViewController:jr];
    jr.view.frame=CGRectMake(0, 0, WIDTH, HEIGHT);
    jr.keyWord=[NSMutableString stringWithFormat:@"%@",_field.text];
    jr.nodeName=[NSMutableString stringWithFormat:@"全部知识"];
    jr.view.tag=1111;
    [self.view addSubview:jr.view];

    [textField resignFirstResponder];
//    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
//    manager.responseSerializer=[AFJSONResponseSerializer serializer];
//    NSDictionary * dic=@{@"content":textField.text,@"pageIndex":@"1",@"token":[user objectForKey:@"token"]};
//    NSString * url=[NSString stringWithFormat:@"%@/WeChat/just_search.wc",URLDOMAIN];
//    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
//        NSDictionary * dic=(NSDictionary *)responseObject;
//        if (dic.count) {
//            
//            
//            if ([dic[@"ret"]isEqualToString:@"success"]) {
//                
//                [MTA trackCustomEvent:@"search_effective" args:[NSArray arrayWithObject:@"arg0"]];
//                
////                SearchDetailViewController * detail=[[SearchDetailViewController alloc]init];
////                detail.data=dic;
////                detail.String=textField.text;
////                [self.navigationController pushViewController:detail animated:NO];
//                
//                
//                
////                textField.text=nil;
//            }
//
//        }
//        if ([dic[@"ret"]isEqualToString:@"not_match"]) {
//            [MTA trackCustomEvent:@"search_invalid" args:[NSArray arrayWithObject:@"arg0"]];
//            [_tableView removeFromSuperview];
//            [MBProgressHUD showError:@"没有相关内容"];
//        }
//        
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//        [MBProgressHUD showError:@"服务器开小差了~"];
//    }];
   
   return YES;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    

    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    _historyData=[NSMutableArray new];
    _historyData=[user objectForKey:history];
    if ([_historyData isKindOfClass:[NSArray class]]) {
        
    
    if (_historyData.count>0) {
       
        UIButton * fotterV=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 44)];
        
        [fotterV setTitle:@"  清除搜索记录" forState:UIControlStateNormal];
        [fotterV setTitleColor:[UIColor colorWithRed:44/255.0 green:180/255.0 blue:237/255.0 alpha:1.0] forState:UIControlStateNormal];
        fotterV.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [fotterV addTarget:self action:@selector(clearHistory:) forControlEvents:UIControlEventTouchUpInside];
        fotterV.backgroundColor=[UIColor whiteColor];
        fotterV.titleLabel.font=[UIFont systemFontOfSize:WIDTH *14/375];
        self.searchTableView.tableFooterView=fotterV;
    }else{
        UILabel * fotterV=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 44)];
        fotterV.text=@"  暂无搜索记录";
        
        fotterV.font=[UIFont systemFontOfSize:WIDTH *14/375];
        fotterV.textColor=[UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1.0];
        fotterV.backgroundColor=[UIColor whiteColor];
        self.searchTableView.tableFooterView=fotterV;

    
    }
                [self.searchTableView reloadData];

    
    }if (!_historyData) {
        UILabel * fotterV=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 44)];
        fotterV.text=@"  暂无搜索记录";
        
        fotterV.font=[UIFont systemFontOfSize:WIDTH *14/375];
        fotterV.textColor=[UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1.0];
        fotterV.backgroundColor=[UIColor whiteColor];
        self.searchTableView.tableFooterView=fotterV;
        [self.searchTableView reloadData];

    }

    
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//         [_field becomeFirstResponder];
//    });
   
    
}
-(void)clearHistory:(UIButton *)btn{
    
     NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    
    NSMutableArray * a=[NSMutableArray new];
    [user setObject:a forKey:history];

    _historyData=[NSMutableArray new];
    
    
    [_searchTableView reloadData];
    UILabel * fotterV=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 44)];
    fotterV.text=@"  暂无搜索记录";
    
    fotterV.font=[UIFont systemFontOfSize:WIDTH *14/375];
    fotterV.textColor=[UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1.0];
    fotterV.backgroundColor=[UIColor whiteColor];
    self.searchTableView.tableFooterView=fotterV;

}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    

    UITextField * field=[self.view viewWithTag:300];
    
    field.text=nil;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

   


}
-(void)keyBoardWillShow:(NSNotification *)note{
    
    
    
    CGRect rect=[note.userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue];
    CGFloat ty=rect.size.height;
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue] animations:^{
        _topBtn.frame=CGRectMake(0, HEIGHT-ty-HEIGHT* 50/667, WIDTH,HEIGHT* 50/667);
        
        
    }];
   
}
-(void)keyBoardWillHide:(NSNotification*)note{
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
//        self.view.transform = CGAffineTransformIdentity;
       _topBtn.frame=CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 50);
        
        
    }];
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{


    [_field resignFirstResponder];

}
-(void)viewDidLayoutSubviews {
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
}
@end
