//
//  DatePickerView.m
//  TempTest
//
//  Created by shixiang on 14-8-3.
//  Copyright (c) 2014年 SuperSX. All rights reserved.
//

#import "CDDatePickerView.h"
#import "CDMacro.h"

@implementation CDDatePickerView
@synthesize pickerView;
@synthesize dateString;
@synthesize path;
@synthesize dataPicker;
@synthesize leftData;
@synthesize rightData;
@synthesize middleData;
@synthesize titleLabels;
@synthesize componentsNum;
@synthesize decimalLab;
@synthesize xuetangData;
@synthesize xueyaData;

- (void)dealloc
{
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

//1:日期模式    2:时间模式   3:日期+时间模式
-(void)addDatePicker:(NSString *)type max:(BOOL)maxOpen
{
    
    UIToolbar *toolBar=[UIToolbar new];
    toolBar.frame=CGRectMake(0, 0, self.frame.size.width, 37);
    toolBar.tintColor=[UIColor darkGrayColor];
    [self addSubview:toolBar];
    
    UILabel *titleLabel= [[UILabel alloc] initWithFrame:CGRectMake(0, 0, toolBar.frame.size.width, toolBar.frame.size.height)];
    titleLabel.font = [UIFont fontWithName:FONT size:17.0f];
    titleLabel.textColor=[UIColor whiteColor];
    titleLabel.textAlignment=1;
    titleLabel.text = @"记录时间";
    [toolBar addSubview:titleLabel];
    
    UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                              target:nil
                                                                              action:nil];
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:@"    取消"
                                                                  style:UIBarButtonItemStyleBordered
                                                                 target:self
                                                                 action:@selector(cancelBtnAction:)];
    
    
    UIBarButtonItem *sureBtn = [[UIBarButtonItem alloc] initWithTitle:@"存储    "
                                                                style:UIBarButtonItemStyleBordered
                                                               target:self
                                                               action:@selector(sureBtnAction)];
    [cancelBtn setTintColor:[UIColor redColor]];
    [sureBtn setTintColor:[UIColor redColor]];
    titleLabel.textColor=[UIColor blackColor];
    
    UIView *toolLineView=[[UIView alloc]initWithFrame:CGRectMake(0, toolBar.frame.size.height, toolBar.frame.size.width, 0.5f)];
    toolLineView.backgroundColor=[UIColor blackColor];
    toolLineView.alpha=0.2f;
    [toolBar addSubview:toolLineView];
    
    NSArray *items = [NSArray arrayWithObjects: cancelBtn,flexItem,sureBtn, nil];
    [toolBar setItems:items animated:YES];
    
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    NSLocale *locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh-CN"];
    [dateformatter setDateFormat:@"YYYYMMdd"];
    pickerView = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 37, self.frame.size.width, 220)];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdds = [[NSDateComponents alloc] init];
    [componentsToAdds setYear:-120];
    //获取重置日期
    NSDate *dateAfterDay = [calendar dateByAddingComponents:componentsToAdds toDate:[NSDate date] options:0];
    if (maxOpen == YES)
    {
        [pickerView setMaximumDate:senddate];
        [pickerView setMinimumDate:dateAfterDay];
    }
    
    [pickerView setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Beijing"]];
    pickerView.locale = locale;
    if ([type isEqualToString:@"1"])
    {
        [pickerView setDatePickerMode:UIDatePickerModeDate];

    }else if([type isEqualToString:@"2"])
    {
        [pickerView setDatePickerMode:UIDatePickerModeTime];
    }else if([type isEqualToString:@"3"])
    {
        [pickerView setDatePickerMode:UIDatePickerModeDateAndTime];
    }
    [self addSubview:pickerView];
    
    
}

- (void)addDataDicker
{
    UIToolbar *toolBar=[UIToolbar new];
    toolBar.frame=CGRectMake(0, 0, self.frame.size.width, 37);
    toolBar.tintColor=[UIColor darkGrayColor];
    [self addSubview:toolBar];
    
    titleLabels= [[UILabel alloc] initWithFrame:CGRectMake(0, 0, toolBar.frame.size.width, toolBar.frame.size.height)];
    titleLabels.backgroundColor = [UIColor clearColor];
    titleLabels.font = [UIFont fontWithName:FONT size:17.0f];
    titleLabels.textColor=[UIColor whiteColor];
    titleLabels.textAlignment=1;
    [toolBar addSubview:titleLabels];
    
    UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                              target:nil
                                                                              action:nil];
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:@"  取消"
                                                                  style:UIBarButtonItemStyleBordered
                                                                 target:self
                                                                 action:@selector(cancelBtnAction)];
    
    
    UIBarButtonItem *sureBtn = [[UIBarButtonItem alloc] initWithTitle:@"存储  "
                                                                style:UIBarButtonItemStyleBordered
                                                               target:self
                                                               action:@selector(sureBtnAction)];
    [cancelBtn setTintColor:[UIColor redColor]];
    [sureBtn setTintColor:[UIColor redColor]];
    titleLabels.textColor=[UIColor blackColor];
    
    NSArray *items = [NSArray arrayWithObjects: cancelBtn,flexItem,sureBtn, nil];
    [toolBar setItems:items animated:YES];
    
    UIView *toolLineView=[[UIView alloc]initWithFrame:CGRectMake(0, toolBar.frame.size.height, toolBar.frame.size.width, 0.5f)];
    toolLineView.backgroundColor=[UIColor blackColor];
    toolLineView.alpha=0.2f;
    [toolBar addSubview:toolLineView];
    
    //设置小数点
    decimalLab= [[UILabel alloc] initWithFrame:CGRectMakeFit(210-45, 134, 185, 21)];
    decimalLab.backgroundColor = [UIColor clearColor];
    decimalLab.font = [UIFont fontWithName:FONT size:16.0f];
    decimalLab.textColor=[UIColor blackColor];
    decimalLab.textAlignment= NSTextAlignmentLeft;
    decimalLab.text=[NSString stringWithFormat:@"."];
    decimalLab.hidden = YES;
    [self addSubview:decimalLab];
    
    //自定义Picker
    dataPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 37, self.frame.size.width, 220)];
    dataPicker.backgroundColor = [UIColor clearColor];
    dataPicker.delegate = self;
    dataPicker.dataSource = self;
    [self addSubview:dataPicker];
}

//配置Title与Picker列数
- (void)setDataPickerTitle:(NSString*)title componentNum:(NSInteger)comp
{
    titleLabels.text = title;
    componentsNum = comp;
    //如果有两列则显示小数点，否则隐藏
    if (componentsNum == 2)
    {
        decimalLab.hidden = NO;
    }
    else
    {
        decimalLab.hidden = YES;
  
    }
}

- (void)addDecimal
{
    
}

- (void)sureBtnAction
{
    
    if (self.types==1)
    {
        if (componentsNum == 2)
        {
            NSString *integ = [leftData objectAtIndex:[dataPicker selectedRowInComponent:0]];
            NSString *decim = [rightData objectAtIndex:[dataPicker selectedRowInComponent:1]];
            xuetangData = [integ intValue] + [decim intValue] * 0.1;
        }
        else
        {
            xueyaData = [[middleData objectAtIndex:[dataPicker selectedRowInComponent:0]] intValue];
        }

    }
    else
    {
        NSDate *selected = [pickerView date];
        
        NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
        
        [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        NSString *  locationString=[dateformatter stringFromDate:selected];
        NSString *str=locationString;
        dateString = str;
    }
  
    [self.delegate selectSureAtiondatePickerView:self];
}

-(void)cancelBtnAction:(id)sender
{
    [self.delegate selectCancleAtionPickerView:self];
}

#pragma mark - pickerView代理
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return componentsNum;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (componentsNum < 2)
    {
        return middleData.count;
    }
    if (component == 0)
    {
        return leftData.count;
    }
    else
    {
        return rightData.count;
    }
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (componentsNum > 1)
    {
        if (component == 0)
        {
            return  leftData[row];
        }
        else
        {
            return  rightData[row];
        }
    }
    return middleData[row];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return 100;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}

- (void)cancelBtnAction
{
    [self.delegate selectCancleAtionPickerView:self];
}
-(void)setDefaultDate:(NSDate*)date
{
    [pickerView setDate:date];
}

@end
