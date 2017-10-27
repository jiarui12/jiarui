    //
//  ChatViewController.m
//  teamCollection
//
//  Created by 八九点 on 16/3/1.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "ChatViewController.h"
#import "Message.h"
#import "ChatTableViewCell.h"
#import "MessageFrame.h"
#import <CoreData/CoreData.h>
#import "ChatTool.h"
#import "UIImage+GIF.h"
#import "UIView+Extension.h"
#import "UIImage+GIF.h"
#import "LiuqsTextAttachment.h"
#import "NSAttributedString+EmojiExtension.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define screenW [UIScreen mainScreen].bounds.size.width
#define screenH [UIScreen mainScreen].bounds.size.height
#define pages 7
#define emojiCount 21
#define rowCount 7
#define emotionW screenW * 0.104
#define rows 3
#define emotionBtnsCount 2
#define gifW screenW * 0.15625
#define gifH screenW * 0.22
#define gifCount 24
#define gifRowCount 4
/*
 
 */

@interface ChatViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UIScrollViewDelegate,NSFetchedResultsControllerDelegate>
@property(nonatomic,strong)UIView * toolView;
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSArray * dataArray;
@property(nonatomic,strong)NSManagedObjectContext * context;
@property(nonatomic,strong)UIView * oneView;
@property(nonatomic,strong)UIView * twoView;
@property(nonatomic,strong)UIView * threeView;
@property(nonatomic,strong)UIView * fourView;
@property(nonatomic,strong)UIView * fiveView;
@property(nonatomic,strong)UIView * sixView;
@end

@implementation ChatViewController
{
    NSMutableArray * _allMessageFrame;
    UIView * _bgView;
    UIPageControl * _pageControlBottom;
    UITextView * _field;
    NSString * _emojiStr;
    NSFetchedResultsController *_resultsContr;
    NSString * temp;
    CGFloat _allHeigh;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _allMessageFrame=[NSMutableArray new];
    _dataArray=[NSArray new];
    
    
    
    if ([self.name isKindOfClass:[NSString class]]) {
         self.navigationItem.title=self.name;
    }
    
   
    
    

 
   
    [self configerView];
    _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH,WIDTH*170/375)];
    //分页控制器
    
    
    UIScrollView * scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, WIDTH*160/375)];
    
    scrollView.contentSize=CGSizeMake(6*WIDTH, WIDTH*160/375);
    scrollView.pagingEnabled=YES;
    scrollView.delegate=self;
    scrollView.showsVerticalScrollIndicator=NO;
    scrollView.showsHorizontalScrollIndicator=NO;
    _bgView.backgroundColor=[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    
    
    [_bgView addSubview:scrollView];
    _pageControlBottom = [[UIPageControl alloc]initWithFrame:CGRectMake(0,WIDTH* 140/375, WIDTH, 20)];
    _pageControlBottom.numberOfPages=6;
    _pageControlBottom.currentPageIndicatorTintColor=[UIColor colorWithRed:3/255.0 green:169/255.0 blue:244/255.0 alpha:1.0];
    _pageControlBottom.pageIndicatorTintColor=[UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1.0];
    
    [_bgView addSubview:_pageControlBottom];


     [scrollView addSubview:_oneView];
 
     [scrollView addSubview:_twoView];
     [scrollView addSubview:_threeView];
     [scrollView addSubview:_fourView];
     [scrollView addSubview:_fiveView];
     [scrollView addSubview:_sixView];
    
    UIButton * button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(0, 0, 10, 20);
    
    [button setBackgroundImage:[UIImage imageNamed:@"icon_nav_ retult_defult_2x"] forState:UIControlStateNormal];
    UIBarButtonItem * left=[[UIBarButtonItem alloc]initWithCustomView:button];
    [button addTarget:self action:@selector(Back:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setLeftBarButtonItem:left];
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    UIGestureRecognizer * gesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(endEditing:)];
    self.view.backgroundColor=[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64-WIDTH * 42.5/375) style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.allowsSelection=NO;
    self.tableView.dataSource=self;
    [self.tableView addGestureRecognizer:gesture];
    self.tableView.backgroundColor=[UIColor colorWithRed:244/255.0 green:251/255.0 blue:255/255.0 alpha:1];
    [self.view addSubview:self.tableView];

    self.toolView=[[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-WIDTH*42.5/375, WIDTH,WIDTH*42.5/375)];
    self.toolView.backgroundColor=[UIColor colorWithRed:243/255.0 green:244/255.0 blue:245/255.0 alpha:1.0];
    self.toolView.layer.borderWidth=0.5;
    self.toolView.layer.borderColor=(__bridge CGColorRef _Nullable)([UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0]);
    
     UIGestureRecognizer * gesture1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(beginEditing)];
    _field=[[UITextView alloc]initWithFrame:CGRectMake(WIDTH *15/375, WIDTH*6/375,WIDTH*305/375 ,WIDTH* 30/375)];
    _field.delegate=self;
    _field.returnKeyType=UIReturnKeySend;
    _field.layer.borderWidth=0.5;
    _field.font=[UIFont systemFontOfSize:WIDTH*15/375];
    [_field addGestureRecognizer:gesture1];
    _field.layer.borderColor=(__bridge CGColorRef _Nullable)([UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0]);
    _field.layer.cornerRadius=WIDTH *4/375;

    [self.toolView addSubview:_field];
    
    
    UIButton * button1=[UIButton buttonWithType:UIButtonTypeSystem];
    button1.backgroundColor=[UIColor clearColor];
    button1.frame=CGRectMake(WIDTH *15/375, WIDTH*6/375,WIDTH*305/375 ,WIDTH* 30/375);
    [button1 addTarget:self action:@selector(beginEditing) forControlEvents:UIControlEventTouchUpInside];
    
    [self.toolView addSubview:button1];
    
    
    
    UIButton * sedBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    
    sedBtn.frame=CGRectMake(WIDTH*659/750, WIDTH*10/375, WIDTH*37/375, WIDTH*24/375);
    
    sedBtn.backgroundColor=[UIColor colorWithRed:41/255.0 green:180/255.0 blue:237/255.0 alpha:1.0];
    
    sedBtn.layer.cornerRadius=WIDTH*4/375;
    [sedBtn addTarget:self action:@selector(sendMessage:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
//    [self.toolView addSubview:sedBtn];
    
    
    UIButton * emojiButton=[UIButton buttonWithType:UIButtonTypeCustom];
    emojiButton.frame=CGRectMake(WIDTH * 335/375, WIDTH *10/375,WIDTH*24/375, WIDTH*24/375);
    
    emojiButton.tag=1000;
    
    [emojiButton addTarget:self action:@selector(inputEmoji:) forControlEvents:UIControlEventTouchUpInside];
    [emojiButton setImage:[UIImage imageNamed:@"icon_biaoqing_defult@2x"] forState:UIControlStateNormal];
    [emojiButton setImage:[UIImage imageNamed:@"icon_jianpan_defult@2x"] forState:UIControlStateSelected];
    [self.toolView addSubview:emojiButton];
    
  
    [self.view addSubview:_toolView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [self loadMsg];
}
-(void)loadMsg{
    NSManagedObjectContext * context=[ChatTool sharedChatTool].msgStorage.mainThreadManagedObjectContext;
   
    
    

    
  
    if (context) {
        
        
        NSFetchRequest * request=[NSFetchRequest fetchRequestWithEntityName:@"XMPPMessageArchiving_Message_CoreDataObject"];
        
        
        NSString * str=[NSString stringWithFormat:@"%@@bagserver",[[NSUserDefaults standardUserDefaults]objectForKey:@"userID"]];
        NSPredicate * pre=[NSPredicate predicateWithFormat:@"streamBareJidStr = %@ AND bareJidStr = %@",str,[NSString stringWithFormat:@"%@@bagserver",self.friendJid] ];
       
        
        request.predicate=pre;
        NSSortDescriptor * timeSort=[NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:YES];
        
        request.sortDescriptors=@[timeSort];
        _resultsContr=[[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
        NSError * err=nil;
        _resultsContr.delegate=self;
        [_resultsContr performFetch:&err];
        
        [self changeMsg];
        [self scrollToTableBottom];
        
        if (err) {
            NSLog(@"%@",err);
        }


    
    }
    
}





-(void)sendMessage:(UIButton *)button{
    
    
    
    
  


}
-(void)configerView{
    _oneView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, WIDTH*160/375)];

    int row = 1;
    
    CGFloat space = (WIDTH - rowCount * emotionW) / (rowCount + 1);
    
    for (int i = 0; i < emojiCount; i ++) {
        
        
      
        
        
        row = i / rowCount + 1;
        
        UIButton *btn = [[UIButton alloc]init];
//        btn.backgroundColor=[UIColor greenColor];
        btn.frame = CGRectMake((1 + i - (rowCount * (row - 1))) * space + (i - (rowCount * (row - 1))) * emotionW, WIDTH*6/375 * row + (row - 1) * emotionW, emotionW, emotionW);
        
        btn.tag = i + 1;
        
        if (i == emojiCount - 1) {
            
            btn.tag = 211;
            
            [btn setImage:[UIImage imageNamed:@"emotion_del_down@2x"] forState:UIControlStateNormal];
            
//            btn.size = CGSizeMake(emotionW + space, emotionW + space);
            
//            CGFloat X = btn.x;
//            
//            CGFloat Y = btn.y;
//            
//            btn.x = X - space / 3;
//            
//            btn.y = Y - space / 3;
            
            [btn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }else
        {
            
            
            
                    if (i+1<=10) {
                        temp=[NSString stringWithFormat:@"f00%d",i];
                    }else if (i+1<=100){
            
                    temp=[NSString stringWithFormat:@"f0%d",i];
                    }else{
            
                    temp=[NSString stringWithFormat:@"f%d",i];
                    }
                    
     
       
            
            [btn setBackgroundImage:[UIImage sd_animatedGIFNamed:temp] forState:UIControlStateNormal];
            
//            [btn setImage:[UIImage sd_animatedGIFNamed:temp] forState:UIControlStateNormal];
            
            [btn addTarget:self action:@selector(insertEmoji:) forControlEvents:UIControlEventTouchUpInside];
        }
        [self.oneView addSubview:btn];
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    _twoView=[[UIView alloc]initWithFrame:CGRectMake(WIDTH, 0, WIDTH, WIDTH*160/375)];
    for (int i = 0; i < emojiCount; i ++) {
        
        row = i / rowCount + 1;
        
        UIButton *btn = [[UIButton alloc]init];
        btn.frame = CGRectMake((1 + i - (rowCount * (row - 1))) * space + (i - (rowCount * (row - 1))) * emotionW, WIDTH*6/375 * row + (row - 1) * emotionW, emotionW, emotionW);
        
        btn.tag = i + 21;
        
        if (i == emojiCount - 1) {
            
            btn.tag = 212;
            
            [btn setImage:[UIImage imageNamed:@"emotion_del_down@2x"] forState:UIControlStateNormal];
            
//            btn.size = CGSizeMake(emotionW + space, emotionW + space);
            
//            CGFloat X = btn.x;
//            
//            CGFloat Y = btn.y;
//            
//            btn.x = X - space / 3;
//            
//            btn.y = Y - space / 3;
            
            [btn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }else
        {
            
            NSString * a;
            int b=i+20;
        
                
                a=[NSString stringWithFormat:@"f0%d",b];
         
            
            
            
            [btn setBackgroundImage:[UIImage sd_animatedGIFNamed:a] forState:UIControlStateNormal];
            
//            [btn setImage:[UIImage sd_animatedGIFNamed:a] forState:UIControlStateNormal];
            
            [btn addTarget:self action:@selector(insertEmoji:) forControlEvents:UIControlEventTouchUpInside];
        }
        [self.twoView addSubview:btn];
    }

    
    
    
    
    
    
    
    
    
    _threeView=[[UIView alloc]initWithFrame:CGRectMake(2*WIDTH, 0, WIDTH, WIDTH*160/375)];
//    _threeView.backgroundColor=[UIColor yellowColor];
    for (int i = 0; i < emojiCount; i ++) {
        
        row = i / rowCount + 1;
        
        UIButton *btn = [[UIButton alloc]init];
        btn.frame = CGRectMake((1 + i - (rowCount * (row - 1))) * space + (i - (rowCount * (row - 1))) * emotionW, WIDTH*6/375 * row + (row - 1) * emotionW, emotionW, emotionW);
        
        btn.tag = i + 41;
        
        if (i == emojiCount - 1) {
            
            btn.tag = 213;
            
            [btn setImage:[UIImage imageNamed:@"emotion_del_down@2x"] forState:UIControlStateNormal];
            
            //            btn.size = CGSizeMake(emotionW + space, emotionW + space);
            
            //            CGFloat X = btn.x;
            //
            //            CGFloat Y = btn.y;
            //
            //            btn.x = X - space / 3;
            //
            //            btn.y = Y - space / 3;
            
            [btn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }else
        {
            
            NSString * a;
            int b=i+40;
            
            
            a=[NSString stringWithFormat:@"f0%d",b];
            
            
            
            
            
            
//            [btn setImage:[UIImage sd_animatedGIFNamed:a] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage sd_animatedGIFNamed:a] forState:UIControlStateNormal];

            [btn addTarget:self action:@selector(insertEmoji:) forControlEvents:UIControlEventTouchUpInside];
        }
        [self.threeView addSubview:btn];
    }

    
    
    
    _fourView=[[UIView alloc]initWithFrame:CGRectMake(3*WIDTH, 0, WIDTH, WIDTH*160/375)];
//    _fourView.backgroundColor=[UIColor greenColor];
    for (int i = 0; i < emojiCount; i ++) {
        
        row = i / rowCount + 1;
        
        UIButton *btn = [[UIButton alloc]init];
        btn.frame = CGRectMake((1 + i - (rowCount * (row - 1))) * space + (i - (rowCount * (row - 1))) * emotionW, WIDTH*6/375 * row + (row - 1) * emotionW, emotionW, emotionW);
        
        btn.tag = i + 61;
        
        if (i == emojiCount - 1) {
            
            btn.tag = 214;
            
            [btn setImage:[UIImage imageNamed:@"emotion_del_down@2x"] forState:UIControlStateNormal];
            
            //            btn.size = CGSizeMake(emotionW + space, emotionW + space);
            
            //            CGFloat X = btn.x;
            //
            //            CGFloat Y = btn.y;
            //
            //            btn.x = X - space / 3;
            //
            //            btn.y = Y - space / 3;
            
            [btn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }else
        {
            
            NSString * a;
            int b=i+60;
            
            
            a=[NSString stringWithFormat:@"f0%d",b];
            
            
            
            
            
            
//            [btn setImage:[UIImage sd_animatedGIFNamed:a] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage sd_animatedGIFNamed:a] forState:UIControlStateNormal];

            [btn addTarget:self action:@selector(insertEmoji:) forControlEvents:UIControlEventTouchUpInside];
        }
        [self.fourView addSubview:btn];
    }
    
    
    
    
    
    
    _fiveView=[[UIView alloc]initWithFrame:CGRectMake(4*WIDTH, 0, WIDTH, WIDTH*160/375)];
//    _fiveView.backgroundColor=[UIColor blueColor];
    for (int i = 0; i < emojiCount; i ++) {
        
        row = i / rowCount + 1;
        
        UIButton *btn = [[UIButton alloc]init];
        btn.frame = CGRectMake((1 + i - (rowCount * (row - 1))) * space + (i - (rowCount * (row - 1))) * emotionW, WIDTH*6/375 * row + (row - 1) * emotionW, emotionW, emotionW);
        
        btn.tag = i + 81;
        
        if (i == emojiCount - 1) {
            
            btn.tag = 215;
            
            [btn setImage:[UIImage imageNamed:@"emotion_del_down@2x"] forState:UIControlStateNormal];
            
            //            btn.size = CGSizeMake(emotionW + space, emotionW + space);
            
            //            CGFloat X = btn.x;
            //
            //            CGFloat Y = btn.y;
            //
            //            btn.x = X - space / 3;
            //
            //            btn.y = Y - space / 3;
            
            [btn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }else
        {
            
            NSString * a;
            int b=i+80;
            
            
            a=[NSString stringWithFormat:@"f0%d",b];
            
            
            
            
            
            
//            [btn setImage:[UIImage sd_animatedGIFNamed:a] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage sd_animatedGIFNamed:a] forState:UIControlStateNormal];

            [btn addTarget:self action:@selector(insertEmoji:) forControlEvents:UIControlEventTouchUpInside];
        }
        [self.fiveView addSubview:btn];
    }
    
    
    
    
    
    _sixView=[[UIView alloc]initWithFrame:CGRectMake(5*WIDTH, 0, WIDTH, WIDTH*160/375)];
//    _sixView.backgroundColor=[UIColor grayColor];
    for (int i = 0; i < 8; i ++) {
        
        row = i / rowCount + 1;
        
        UIButton *btn = [[UIButton alloc]init];
        btn.frame = CGRectMake((1 + i - (rowCount * (row - 1))) * space + (i - (rowCount * (row - 1))) * emotionW, WIDTH*6/375 * row + (row - 1) * emotionW, emotionW, emotionW);
        
        btn.tag = i + 101;
        
        if (i == 8 - 1) {
            
            btn.tag = 216;
            
            [btn setImage:[UIImage imageNamed:@"emotion_del_down@2x"] forState:UIControlStateNormal];
            
            //            btn.size = CGSizeMake(emotionW + space, emotionW + space);
            
            //            CGFloat X = btn.x;
            //
            //            CGFloat Y = btn.y;
            //
            //            btn.x = X - space / 3;
            //
            //            btn.y = Y - space / 3;
            
            [btn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }else
        {
            
            NSString * a;
            int b=i+100;
            
            
            a=[NSString stringWithFormat:@"f%d",b];
            
            
            
            
            
            
//            [btn setImage:[UIImage sd_animatedGIFNamed:a] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage sd_animatedGIFNamed:a] forState:UIControlStateNormal];

            [btn addTarget:self action:@selector(insertEmoji:) forControlEvents:UIControlEventTouchUpInside];
        }
        [self.sixView addSubview:btn];
    }

    
    
    
    
}

-(void)deleteBtnClick:(UIButton *)button{
 [_field deleteBackward];

}
-(void)insertEmoji:(UIButton *)button{
    NSLog(@"%ld",(long)button.tag);
    
    long temp1=button.tag-1;
    
    
    
    
    
    if (temp1+1<10) {
        temp=[NSString stringWithFormat:@"f00%ld",temp1];
    }else if (temp1+1<100){
        
        temp=[NSString stringWithFormat:@"f0%ld",temp1];
    }else{
        
        temp=[NSString stringWithFormat:@"f%ld",temp1];
    }
        NSString * s=@"[呲牙],[调皮],[流汗],[偷笑],[再见],[敲打],[擦汗],[猪头],[玫瑰],[流泪],[大哭],[嘘],[酷],[抓狂],[委屈],[便便],[炸弹],[菜刀],[可爱],[色],[害羞],[得意],[吐],[微笑],[发怒],[尴尬],[惊恐],[冷汗],[爱心],[示爱],[白眼],[傲慢],[难过],[惊讶],[疑问],[睡],[亲亲],[憨笑],[爱情],[衰],[撇嘴],[阴险],[奋斗],[发呆],[右哼哼],[拥抱],[坏笑],[飞吻],[鄙视],[晕],[大兵],[可怜],[强],[弱],[握手],[胜利],[抱拳],[凋谢],[饭],[蛋糕],[西瓜],[啤酒],[飘虫],[勾引],[OK],[爱你],[咖啡],[钱],[月亮],[美女],[刀],[发抖],[差劲],[拳头],[心碎],[太阳],[礼物],[足球],[骷髅],[挥手],[闪电],[饥饿],[困],[咒骂],[折磨],[抠鼻],[鼓掌],[糗大了],[左哼哼],[哈欠],[快哭了],[吓],[篮球],[乒乓球],[NO],[跳跳],[怄火],[转圈],[磕头],[回头],[跳绳],[激动],[街舞],[献吻],[左太极],[右太极],[闭嘴]";
        NSArray * arr111=[s componentsSeparatedByString:@","];
    
    NSString * content=arr111[temp1];
//    LiuqsTextAttachment *emojiTextAttachment = [LiuqsTextAttachment new];
    //    给附件设置tag值(用来对照图片；通过前边从plist中加载到的数组_emojiTags中取到按钮对应的字符串)
    
//    NSString *imageName;
    //下边这个判断可以不管，是我在测试新加载方案的调试代码。下边方法就是要取到当前按钮对应的图片名字
  
        
//        NSString *shortName = [_emojiStaticImages objectForKey:_emojiTags[(NSUInteger) btn.tag - 1]];
    
//        imageName = [NSString stringWithFormat:@"%@.gif",temp];
    
  
    //给附件设置图片
//    emojiTextAttachment.image = [UIImage imageWithData:[content dataUsingEncoding:NSUTF8StringEncoding]];
//    emojiTextAttachment.contents=[content dataUsingEncoding:NSUTF8StringEncoding];
    //    给附件设置尺寸,会在自定义附件内部重写方法用这个值来设置附件尺寸
//    emojiTextAttachment.emojiSize = CGSizeMake(20, 20);
    //textview插入富文本，用创建的附件初始化富文本
//    NSAttributedString
    
// NSMutableAttributedString * attri =  [[NSMutableAttributedString alloc]initWithString:content];
    
//    [NSAttributedString attributedStringWithAttachment:emojiTextAttachment]
//    [_field.textStorage insertAttributedString:attri atIndex:_field.selectedRange.location];
    
    
//    _field.selectedRange.length
    
//    _field.selectedRange = NSMakeRange(_field.selectedRange.location + _field.selectedRange.length+1,content.length );
    
//    NSLog(@"%@",NSMakeRange(_field.selectedRange.location + 1, _field.selectedRange.length));

    //调用这个方法是为了响应代理方法，目的是触发输入框改变时候的事件，比如表情输入时候需要改变输入框的高度等，设计的比较多！
//    [self emotionBtnDidClick:btn];
    //重设输入框
//    [self resetTextStyle];
    
    
    _field.text = [_field.text stringByAppendingString:content];
    if (_field.text.length>0) {
    
    }
    
}

-(void)Back:(UIBarButtonItem *)button{
    
    NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:self.friendJid,@"opID", nil];
    //创建通知
    NSNotification *notification =[NSNotification notificationWithName:@"isRead" object:nil userInfo:dict];
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
   
    
    
    [self.navigationController popViewControllerAnimated:YES];
  
}
-(void)changeMsg{
      NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    _allMessageFrame=[NSMutableArray new];
    
    for (int i=0; i<_resultsContr.fetchedObjects.count; i++) {
        
       
        MessageFrame * mf=[[MessageFrame alloc]init];
        Message*msg=[[Message alloc]init];
        XMPPMessageArchiving_Message_CoreDataObject * Msg=_resultsContr.fetchedObjects[i];
        
        
        
        if (Msg.body.length>0) {
             msg.content=Msg.body;
        }
       
       
        msg.date=Msg.timestamp;

        NSDate *currentDate = Msg.timestamp;//获取当前时间，日期
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM月dd日 hh:mm"];
        NSString *dateString = [dateFormatter stringFromDate:currentDate];
        
        
        
        msg.time=dateString;
    
        NSDictionary *responseObject=[user objectForKey:@"responseObject"];
        
        
        if ([Msg.outgoing boolValue]) {//自己发
            msg.type=MessageTypeMe;
            msg.icon=[user objectForKey:@"headImageViewURL"];
        }else{
            msg.type=MessageTypeOther;
            msg.icon=responseObject[@"headIconUrl"];
            msg.icon=self.headImage;
        }
        mf.message=msg;
        [_allMessageFrame addObject:mf];
        
        
    }


}
-(void)keyBoardWillShow:(NSNotification *)note{
        CGRect rect=[note.userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue];
        CGFloat ty=-rect.size.height;
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue] animations:^{
        self.view.transform=CGAffineTransformMakeTranslation(0, ty);
    }];
    
    
    
//    _allHeigh=0;

//    for (int i=0; i<_allMessageFrame.count; i++) {
//        _allHeigh+=[_allMessageFrame[i] cellHeight];
//    }
//    
//    if (_allHeigh-ty<[UIScreen mainScreen].bounds.size.height-64-WIDTH*42.5/375) {
//        [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue] animations:^{
//            self.view.transform=CGAffineTransformMakeTranslation(0, 0);
//            self.toolView.transform=CGAffineTransformMakeTranslation(0, ty);
//        }];
//    }else{
//        
//        
//}
    
}
-(void)keyBoardWillHide:(NSNotification*)note{
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
        self.view.transform = CGAffineTransformIdentity; self.toolView.transform = CGAffineTransformIdentity;
    }];

}
-(void)textViewDidChange:(UITextView *)textView{
    
   


}
-(BOOL)textViewShouldReturn:(UITextField *)textField
{
    
    if(textField.text.length!=0){
    
      [self addMessageWithContent:textField.text time:nil];
      textField.text=nil;
    }else{
    
        NSLog(@"22");
    
   }
    return YES;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
-(void)addMessageWithContent:(NSString *)content time:(NSString *)time{

    NSString * str=[NSString stringWithFormat:@"%@@bagserver",self.friendJid];
    XMPPMessage *msg=[XMPPMessage messageWithType:@"chat" to:[XMPPJID jidWithString:str]];
    [msg addAttributeWithName:@"bodyType" stringValue:@"text"];
    [msg addBody:content];

    [[ChatTool sharedChatTool].xmppStream sendElement:msg];
}
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    [self.view endEditing:YES];
//}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _allMessageFrame.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
  static NSString * iden=@"iden";
    ChatTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:iden];
    if (cell==nil) {
        cell=[[ChatTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
    }
  
    
    cell.messageFrame=_allMessageFrame[indexPath.row];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
   
   
    
    return [_allMessageFrame[indexPath.row]cellHeight];
}
-(void)endEditing:(UIGestureRecognizer*)ge{
    [self.view endEditing:YES];
    UIButton * button=[self.view viewWithTag:1000];
     button.selected=NO;
    
    _field.inputView=nil;
    
}
-(void)beginEditing{
    [_field becomeFirstResponder];
    
    UIButton * button=[self.view viewWithTag:1000];
    button.selected=NO;
    
    _field.inputView=nil;
    [_field reloadInputViews];
    

}

-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    
   
    [self changeMsg];
    [self.tableView reloadData];
    [self scrollToTableBottom];
}



-(void)scrollToTableBottom{
    
   
    NSInteger lastRow = _allMessageFrame.count - 1;
    
    if (lastRow < 0) {
        //行数如果小于0，不能滚动
        return;
    }
    NSIndexPath *lastPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
    
    [self.tableView scrollToRowAtIndexPath:lastPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
}

-(void)inputEmoji:(UIButton * )button{
    


    
    if (![_field isFirstResponder]) {
        [_field becomeFirstResponder];
        _field.inputView=_bgView;
        [_field reloadInputViews];
    }
    if (button.selected==NO) {
        button.selected=YES;
        //呼出表情
//        [button setBackgroundImage:[UIImage imageNamed:@"chatting_setmode_keyboard_btn_normal"] forState:UIControlStateSelected];
        _field.inputView=_bgView;
        [_field reloadInputViews];
    }else{
        button.selected=NO;
//        [button setBackgroundImage:[UIImage imageNamed:@"chatting_biaoqing_btn_normal"]forState:UIControlStateNormal] ;
        _field.inputView=nil;
        [_field reloadInputViews];
    }
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (((_dataArray.count/28)+(_dataArray.count%28==0?0:1))!=section+1) {
        return 28;
    }else{
        return _dataArray.count-28*((_dataArray.count/28)+(_dataArray.count%28==0?0:1)-1);
    }
    
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return (_dataArray.count/28)+(_dataArray.count%28==0?0:1);
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * iden=@"biaoqing";
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:iden forIndexPath:indexPath];
    
    
    for (NSInteger i=cell.contentView.subviews.count; i>0; i--) {
        [cell.contentView.subviews[i-1] removeFromSuperview];
    }
//    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
//    label.font = [UIFont systemFontOfSize:25];
//    label.text =_dataArray[indexPath.row+indexPath.section*28] ;
//    
//    
//    [cell.contentView addSubview:label];
    UIImageView * imageV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,30, 30)];
    
    
    if (indexPath.item+1<10) {
        temp=[NSString stringWithFormat:@"f00%d",(int)indexPath.item+1];
    }else if (indexPath.item+1<100){
        
        temp=[NSString stringWithFormat:@"f0%d",(int)indexPath.item+1];
    }else{
        
        temp=[NSString stringWithFormat:@"f%d",(int)indexPath.item
              +1];
    }

    
    
    
    
    imageV.image=[UIImage sd_animatedGIFNamed:temp];
    
    [cell.contentView addSubview:imageV];
    cell.backgroundColor=[UIColor greenColor];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
   NSMutableString * str = _dataArray[indexPath.section*28+indexPath.row];
    
    
    
  _field.text = [_field.text stringByAppendingString:str];
   
    
}
//翻页后对分页控制器进行更新
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat contenOffset = scrollView.contentOffset.x;
    int page = contenOffset/scrollView.frame.size.width+((int)contenOffset%(int)scrollView.frame.size.width==0?0:1);
    _pageControlBottom.currentPage = page;
    
}
-(void)viewWillAppear:(BOOL)animated{

//    self.tabBarController.tabBar.hidden=YES;
//    UIImageView * image=[self.tabBarController.view viewWithTag:130];
//    image.hidden=YES;
    
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    
    
    
    
    
    [user setObject:nil forKey:@"messageDate"];
    
    
    
    
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        
      
// NSString *messageText = [[_field.textStorage getPlainString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        if (_field.text.length>0) {
            [self addMessageWithContent:_field.text time:nil];
            
            
            
            _field.text=nil;
        }
       
        return NO;
    }
    return YES;
}

@end
