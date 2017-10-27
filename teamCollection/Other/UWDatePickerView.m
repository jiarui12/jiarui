//
//  UWDatePickerView.h
//  UWDatePickerView
//


#import "UWDatePickerView.h"

@interface UWDatePickerView ()

@property (nonatomic, strong) NSString *selectDate;
@property (weak, nonatomic) IBOutlet UIButton *cannelBtn;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UIView *backgVIew;
@property (weak, nonatomic) IBOutlet UIButton *backGroundBtn;


@end

@implementation UWDatePickerView

+ (UWDatePickerView *)instanceDatePickerView
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"UWDatePickerView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}


- (void)awakeFromNib
{
    [super awakeFromNib];
    /**背景*/
    self.backgVIew.layer.cornerRadius = 5;
    self.backgVIew.layer.borderWidth = 1;
    self.backgVIew.layer.borderColor = [[UIColor whiteColor]CGColor];
    self.backgVIew.layer.masksToBounds = YES;
    self.backgVIew.layer.borderColor=[[UIColor clearColor] CGColor];
    /**确定*/
    self.sureBtn.layer.cornerRadius = 3;
    self.sureBtn.layer.borderWidth = 1;
    self.sureBtn.layer.borderColor = [[UIColor colorWithRed:44/255.0 green:140/255.0 blue:251/255.0 alpha:1.0] CGColor];
    self.sureBtn.layer.masksToBounds = YES;
    
    /**取消按钮*/
    self.cannelBtn.layer.cornerRadius = 3;
    self.cannelBtn.layer.borderWidth = 1;
    self.cannelBtn.layer.borderColor = [[UIColor grayColor] CGColor];
    self.cannelBtn.layer.masksToBounds = YES;
    
    self.datePickerView.datePickerMode=UIDatePickerModeDateAndTime;
    
    NSDate *maxDate = [[NSDate alloc]initWithTimeIntervalSinceNow:365*24*60*60];
    self.datePickerView.maximumDate = maxDate;
    NSDate *minDate = [NSDate date];
    self.datePickerView.minimumDate = minDate;
    
}

/**
 *  设置时间格式，可更改HH、hh改变日期的显示格式，有12小时和24小时制
 *
 *  @return 时间格式
 */
- (NSString *)timeFormat
{
    NSDate *selected = [self.datePickerView date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *currentOlderOneDateStr = [dateFormatter stringFromDate:selected];
    return currentOlderOneDateStr;
}

- (void)animationbegin:(UIView *)view
{
    // 设定为缩放
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    // 动画选项设定
    animation.duration = 0.1; // 动画持续时间
    animation.repeatCount = -1; // 重复次数
    animation.autoreverses = YES; // 动画结束时执行逆动画
    
    // 缩放倍数
    animation.fromValue = [NSNumber numberWithFloat:1.0]; // 开始时的倍率
    animation.toValue = [NSNumber numberWithFloat:0.9]; // 结束时的倍率
    
    // 添加动画
    [view.layer addAnimation:animation forKey:@"scale-layer"];
}

/**
 *  取消按钮点击
 */
- (IBAction)removeBtnClick:(id)sender {
    // 开始动画
    [self animationbegin:sender];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

/**
 *  确定按钮点击,会触发代理事件
 */
- (IBAction)sureBtnClick:(id)sender {
    // 开始动画
    [self animationbegin:sender];
    self.selectDate = [self timeFormat];
    [self.delegate getSelectDate:self.selectDate type:self.type];
    [self removeBtnClick:nil];
}

/**
 *  点击其他地方移除时间选择器
 */
- (IBAction)backGroundBtnClicked:(id)sender
{
    [self removeBtnClick:nil];
}
@end
