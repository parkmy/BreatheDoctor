//
//  DatePickerView.h
//  TempTest
//
//  Created by shixiang on 14-8-3.
//  Copyright (c) 2014年 SuperSX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CDDatePickerView;

@protocol CDDatePickerViewDelegate <NSObject>

@optional

- (void)selectSureAtiondatePickerView:(CDDatePickerView*)datePickerView;
- (void)selectCancleAtionPickerView:(CDDatePickerView*)datePickerView;

@end

@interface CDDatePickerView : UIView<CDDatePickerViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong)UIDatePicker *pickerView;//时间获取器
@property (nonatomic, strong)NSString * dateString;
@property (nonatomic, assign) id <CDDatePickerViewDelegate>delegate;
@property (nonatomic, strong) NSIndexPath * path;
////
@property (nonatomic,strong) UIPickerView *dataPicker;
@property (nonatomic,strong) NSMutableArray *leftData;
@property (nonatomic,strong) NSMutableArray *rightData;
@property (nonatomic,strong) NSMutableArray *middleData;
@property (nonatomic,strong) UILabel *titleLabels;
@property (nonatomic,assign) NSInteger componentsNum;
@property (nonatomic,strong) UILabel *decimalLab;
@property (nonatomic,assign) float xuetangData;
@property (nonatomic,assign) int xueyaData;
///类型1：升高体重
@property (nonatomic, assign) int types;

-(void)addDatePicker:(NSString *)type max:(BOOL)maxOpen;
- (void)addDataDicker;      //初始化添加
- (void)addDecimal;         //添加小数点视图
- (void)setDataPickerTitle:(NSString*)title componentNum:(NSInteger)comp;   //设置标题及组数
-(void)setDefaultDate:(NSDate*)date;
@end
