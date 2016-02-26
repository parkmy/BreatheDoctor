//
//  PickerDateViewController.m
//  PickerViewProduct
//
//  Created by SanJin on 16-1-8.
//  Copyright (c) 2016年 SanJin. All rights reserved.
//

#import "PickerDateViewController.h"

#define kFirstComponent 0
#define kSubComponent 1

#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height

@interface PickerDateViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>


@property(strong,nonatomic)UIPickerView * pickerView;
@property(strong,nonatomic)NSString * selectedDateString;
@property(strong,nonatomic)NSArray * arrayMonth;
@property(strong,nonatomic)NSMutableArray * arrayYear;

@end

@implementation PickerDateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor =[UIColor colorWithRed:128/255.0f green:128/255.0f blue:128/255.0f alpha:0.65];
    
    UIView * backGroudView =[[UIView alloc]init];
    backGroudView.frame = CGRectMake(0, Height - 250, Width, 250);
    backGroudView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:backGroudView];
    
    UIButton * cancelButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.65] forState:UIControlStateNormal];
    cancelButton.frame = CGRectMake(5, 0, 64, 44);
//    [cancelButton setTitleColor:[UIColor colorWithRed:13/255.0f green:95/255.0f blue:253/255.0f alpha:1.0] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [backGroudView addSubview:cancelButton];
    
    UILabel * titleLable =[[UILabel alloc]init];
    titleLable.text = @"日期选择";
    titleLable.textColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.65];
    titleLable.frame = CGRectMake(70, 0, Width-140, 44);
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.font =[UIFont systemFontOfSize:20];
    [backGroudView addSubview:titleLable];
    
    UIButton * DoneButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [DoneButton setTitle:@"确定" forState:UIControlStateNormal];
    [DoneButton setTitleColor:[UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.65] forState:UIControlStateNormal];

    DoneButton.frame = CGRectMake(Width-69, 0, 64, 44);
//    [DoneButton setTitleColor:[UIColor colorWithRed:13/255.0f green:95/255.0f blue:253/255.0f alpha:1.0] forState:UIControlStateNormal];
    [DoneButton addTarget:self action:@selector(DoneButton) forControlEvents:UIControlEventTouchUpInside];
    [backGroudView addSubview:DoneButton];

    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents *components = [calendar components:unitFlags fromDate:[NSDate date]];
    NSInteger year = [components year];  //当前的年份
    NSInteger month = [components month];  //当前的月份
    
    _arrayYear =[[NSMutableArray alloc]initWithCapacity:0];
    //   [[arrayYear reverseObjectEnumerator] allObjects];//数组倒序排列
//    for (NSInteger k = year - 1980 ; k > 0; k --) {
//        [_arrayYear addObject:[NSString stringWithFormat:@"%ld年",year-k]];
//    }
    [_arrayYear addObject:[NSString stringWithFormat:@"%ld年",year]];
    [_arrayYear addObject:[NSString stringWithFormat:@"%ld年",year-1]];
    
//    for (int i= 0; i < 4; i++ ) {
//        [_arrayYear addObject:[NSString stringWithFormat:@"%ld年",year+i]];
//    }
    
    _arrayMonth = [[NSArray alloc]initWithObjects:@"1月", @"2月",@"3月",@"4月",@"5月",@"6月",@"7月",@"8月",@"9月",@"10月",@"11月",@"12月",nil];
    self.pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 44, Width, 200)];
    self.pickerView.delegate =self;
    self.pickerView.dataSource = self;
    [backGroudView addSubview:self.pickerView];
    
    [self.pickerView selectRow:[_arrayYear indexOfObject:[NSString stringWithFormat:@"%ld年",year]] inComponent:0 animated:YES];
    [self.pickerView selectRow:[_arrayMonth indexOfObject:[NSString stringWithFormat:@"%ld月",month]] inComponent:1 animated:YES];
    _selectedDateString = [NSString stringWithFormat:@"%ld年%ld月",year,month];
    
}

- (void)cancelButtonClick {
    
    _dismissBlock?_dismissBlock():nil;
    
    [self.view removeFromSuperview];
    self.view = nil;
    
}
- (void)DoneButton {
    if (self.selectedBlock) {
        self.selectedBlock(_selectedDateString);
    }

}
//返回几列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

//返回列的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == kFirstComponent) {
        return _arrayYear.count;
    }else{
        return _arrayMonth.count;
    }
}

//显示的标题
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (component==kFirstComponent){
        NSString *provinceStr = [_arrayYear objectAtIndex:row];
        return provinceStr;
    }else{
        NSString *provinceStr = [_arrayMonth objectAtIndex:row];
        return provinceStr;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (component == kFirstComponent) {//刷新
        [pickerView selectRow:kFirstComponent inComponent:kSubComponent animated:YES];
        [pickerView reloadComponent:kSubComponent];
    }
    NSInteger yearComponent = [pickerView selectedRowInComponent:kFirstComponent];
    NSInteger monthComponent = [pickerView selectedRowInComponent:kSubComponent];
    NSString * yearString = [_arrayYear objectAtIndex:yearComponent];
    NSString * monthString = [_arrayMonth objectAtIndex:monthComponent];
    _selectedDateString = [NSString stringWithFormat:@"%@%@",yearString,monthString];
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
