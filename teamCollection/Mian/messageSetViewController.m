//
//  messageSetViewController.m
//  teamCollection
//
//  Created by 八九点 on 2016/11/24.
//  Copyright © 2016年 八九点. All rights reserved.
//

#import "messageSetViewController.h"
#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height
@interface messageSetViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property(nonatomic,strong)UIView * view1;
@property (nonatomic,strong)UIPickerView * pickerView;//自定义pickerview
@property (nonatomic,strong)NSMutableArray * letter;//保存要展示的字母
@property (nonatomic,strong)NSMutableArray * number;//保存要展示的数字
@end

@implementation messageSetViewController
{
    NSString * title;
    NSString * Title;
    NSInteger a;
    NSInteger b;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _letter=[NSMutableArray new];
    _number=[NSMutableArray new];
//    self.view.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
self.view.backgroundColor=[UIColor colorWithRed:244/255.0 green:251/255.0 blue:255/255.0 alpha:1];
    
    self.navigationItem.title=@"消息设置";
    
    
    UIButton * button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(0, 0, 10, 20);
    [button setBackgroundImage:[UIImage imageNamed:@"icon_nav_ retult_defult_2x"] forState:UIControlStateNormal];
    UIBarButtonItem * left=[[UIBarButtonItem alloc]initWithCustomView:button];
    [button addTarget:self action:@selector(Back:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setLeftBarButtonItem:left];
    
    
    UIView * headView=[[UIView alloc]initWithFrame:CGRectMake(0, WIDTH *10/375+64, WIDTH, WIDTH*43/375)];
    
    headView.backgroundColor=[UIColor whiteColor];
    UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH *10/375, 0, WIDTH/2, WIDTH*43/375)];
    label.text=@"免打扰设置";
    label.font=[UIFont systemFontOfSize:WIDTH* 17/375];
    label.textColor=[UIColor colorWithRed:30/255.0 green:29/255.0 blue:29/255.0 alpha:1.0];
    
    
    [headView addSubview:label];
    
    
    
    [self.view addSubview:headView];
    
    UISwitch * fristSlider=[[UISwitch alloc]initWithFrame:CGRectMake(self.view.frame.size.width-70, 10, 40, 1)];
    //   fristSlider.s
    fristSlider.center=CGPointMake(WIDTH *340/375, headView.frame.size.height/2);
    NSLog(@"%f",fristSlider.frame.size.height);
    
    
    
    
    
    [fristSlider addTarget:self action:@selector(fristSwitch:) forControlEvents:UIControlEventValueChanged];
    
    [headView addSubview:fristSlider];
    
    _view1=[[UIView alloc]initWithFrame:CGRectMake(0, WIDTH *63/375+64, WIDTH, WIDTH*43/375)];
    
    UILabel * label1=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH *10/375, 0, WIDTH/2, WIDTH*43/375)];
    label1.text=@"免打扰时间";
    label1.font=[UIFont systemFontOfSize:WIDTH* 17/375];
    label1.textColor=[UIColor colorWithRed:30/255.0 green:29/255.0 blue:29/255.0 alpha:1.0];

    UIButton * Btn=[UIButton buttonWithType:UIButtonTypeSystem];
    
    Btn.frame=CGRectMake(0, 0, WIDTH, WIDTH*43/375);
    [Btn addTarget:self action:@selector(picker) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * totleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0,WIDTH *365/375 , WIDTH *43/375)];
    totleLabel.tag=10000;
    totleLabel.textAlignment=NSTextAlignmentRight;
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    if ([[user objectForKey:@"shijianduan"] length]>0) {
        totleLabel.text = [user objectForKey:@"shijianduan"];
    }else{
    
    totleLabel.text=@"每日20:00-次日08:00";
    }
   
    totleLabel.textColor=[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0];
    [_view1 addSubview:totleLabel];
    
    
    [_view1 addSubview:label1];
    _view1.backgroundColor=[UIColor whiteColor];
    _view1.hidden=YES;
    
    [_view1 addSubview:Btn];

    [self.view addSubview:_view1];
    [self loadData];
    
    // 初始化pickerView
    
    
    //   fristSlider.s
    NSString * s1=[user objectForKey:@"witch1"];
    if ([s1 isEqualToString:@"1"]) {
        fristSlider.on=YES;
        _view1.hidden=NO;
        
    }else{
        fristSlider.on=NO;
        _view1.hidden=YES;
        
    }
    
    UIView * bottom=[[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT +WIDTH*260/375, WIDTH, WIDTH*260/375)];
    bottom.tag=100;
    bottom.backgroundColor=[UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1.0];
    
    UILabel * timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH*10/375, 0, WIDTH/2, WIDTH*43/375)];
    timeLabel.font=[UIFont systemFontOfSize:WIDTH* 14/375];
    timeLabel.textColor=[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0];
    timeLabel.text=@"无";
    timeLabel.tag=1000;
    
    if ([[user objectForKey:@"shijianduan"] length]>0) {
        timeLabel.text = [user objectForKey:@"shijianduan"];
    }else{
        
        timeLabel.text=@"每日20:00-次日08:00";
    }
    
    [bottom addSubview:timeLabel];
    
    UIButton *finishbutton=[UIButton buttonWithType:UIButtonTypeSystem];
    finishbutton.frame=CGRectMake(WIDTH *305/375, 0, WIDTH *70/375, WIDTH *43/375);
    [finishbutton setTitle:@"完成" forState:UIControlStateNormal];
    [finishbutton setTitleColor:[UIColor colorWithRed:0/255.0 green:122/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];
    [finishbutton addTarget:self action:@selector(finish) forControlEvents:UIControlEventTouchUpInside];
    [bottom addSubview:finishbutton];
    
    self.pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0,WIDTH*43/375, WIDTH,WIDTH*215/375 )];
    
    
    
    _pickerView.backgroundColor=[UIColor whiteColor];
//    _pickerView.showsSelectionIndicator=YES;
    //指定数据源和委托
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    if ([[user objectForKey:@"component1"] length]>0) {
        [_pickerView selectRow:[[user objectForKey:@"component1"] integerValue] inComponent:0 animated:YES];
    }
    if ([[user objectForKey:@"component2"] length]>0) {
        [_pickerView selectRow:[[user objectForKey:@"component2"] integerValue] inComponent:1 animated:YES];
    }
    
     [bottom addSubview:self.pickerView];
    
    [self.view addSubview:bottom];
    
}
-(void)finish{
    UIView * botton=[self.view viewWithTag:100];
    [UIView animateWithDuration:0.5 animations:^{
        
        //        UIView * bottom=[[UIView alloc]initWithFrame:CGRectMake(0, WIDTH *350/375+64, WIDTH, WIDTH*260/375)];
        botton.frame=CGRectMake(0, HEIGHT +WIDTH*260/375, WIDTH, WIDTH*260/375);
    }];
    UILabel * totle=[_view1 viewWithTag:10000];
    UILabel * boom=[self.view viewWithTag:1000];
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    [user setObject:boom.text forKey:@"shijianduan"];
    [user setObject:[NSString stringWithFormat:@"%ld",(long)a] forKey:@"component1"];
    [user setObject:[NSString stringWithFormat:@"%ld",(long)b] forKey:@"component2"];
    totle.text=boom.text;
    
}
-(void)loadData{
    //需要展示的数据以数组的形式保存
    for (int i=0; i<24; i++) {
        
        if (i<10) {
             NSString * s=[NSString stringWithFormat:@"0%d:00",i];
            [_letter addObject:s];
            [_number addObject:s];
        }else{
         NSString * s=[NSString stringWithFormat:@"%d:00",i];
            [_letter addObject:s];
            [_number addObject:s];
    
        }
       
        
       
        
        
    }
  
}
-(void)picker{
    UIView * botton=[self.view viewWithTag:100];
    [UIView animateWithDuration:0.5 animations:^{
        

        botton.frame=CGRectMake(0, WIDTH *350/375+64, WIDTH, WIDTH*260/375);
    }];
    

}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;//第一个展示字母、第二个展示数字
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSInteger result = 0;
    switch (component) {
        case 0:
            result = self.letter.count;//根据数组的元素个数返回几行数据
            break;
        case 1:
            result = self.number.count;
            break;
            
        default:
            break;
    }
    return result;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString * title1 = nil;
    switch (component) {
        case 0:
            title1 = self.letter[row];
            break;
        case 1:
            title1 = self.number[row];
            break;
        default:
            break;
    }
    return title1;
}
-(void)fristSwitch:(UISwitch *)s{

    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    
    if (s.isOn==YES) {
        
        [user setObject:@"1" forKey:@"witch1"];
        UIView * botton=[self.view viewWithTag:100];
        [UIView animateWithDuration:0.5 animations:^{
            
            
            botton.frame=CGRectMake(0, WIDTH *350/375+64, WIDTH, WIDTH*260/375);
        }];
        _view1.hidden=NO;
    }else{
        _view1.hidden=YES;
     
        [user setObject:@"0" forKey:@"witch1"];
        UIView * botton=[self.view viewWithTag:100];
        [UIView animateWithDuration:0.5 animations:^{
            
            //        UIView * bottom=[[UIView alloc]initWithFrame:CGRectMake(0, WIDTH *350/375+64, WIDTH, WIDTH*260/375)];
            botton.frame=CGRectMake(0, HEIGHT +WIDTH*260/375, WIDTH, WIDTH*260/375);
        }];
    }



}
-(void)Back:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
//    self.tabBarController.tabBar.hidden=YES;
//    
//    UIImageView * image=[self.tabBarController.view viewWithTag:130];
//    
//    image.hidden=YES;
    

}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
  
    if (component==0) {
    title = self.letter[row];
        a=row;
        
    }else{
    Title=self.number[row];
        b=row;
    }
    UILabel * label=[self.view viewWithTag:1000];
    
    
    if (a>b) {
        if (title.length==0) {
            title=@" ";
        }if (Title.length==0) {
            Title=@" ";
        }
        
        
        NSString * totle=[NSString stringWithFormat:@"每日%@-次日%@",title,Title];
        label.text=totle;
    }else if(a==b){
        
//        NSString * totle=[NSString stringWithFormat:@"每日%@-%@",title,Title];
        label.text=@"全天";
    }else{
        if (title.length==0) {
            title=@" ";
        }if (Title.length==0) {
            Title=@" ";
        }
        NSString * totle=[NSString stringWithFormat:@"每日%@-%@",title,Title];
        label.text=totle;
    }
    
    
    
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
