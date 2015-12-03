//
//  CommontConvenient.h
//  ComveeDoctor
//
//  Created by JYL on 14-7-31.
//  Copyright (c) 2014年 zhengjw. All rights reserved.
//公用便利方法

#import <Foundation/Foundation.h>
//#import "ZLPicker.h"
//#import "ZLCameraViewController.h"

@interface CDCommontConvenient : NSObject

+ (CDCommontConvenient*)shareCDcomment;
/**
 *	@brief	构建lable
 *  @param 	rect 尺寸
 *  @param 	text 显示文本
 *  @param 	color字体颜色
 *  @param 	font字体大小
 *  @param  Sv	所添加的父视图
 *	 */

- (UILabel*)creatLable:(CGRect)rect text:(NSString*)text Color:(UIColor*)color Font:(UIFont*)font textAliment:(int)aliment Sv:(UIView*)view;

/**
 *	@brief	构建文本输入框
 *  @param 	rect   尺寸
 *  @param 	text   默认提示语
 *  @param  color  字体颜色
 *  @param  aliment对齐方式
 *  @param  Sv	   所添加的父视图
 *  @param  img    图片名
 *	 */
- (UITextField*)creatTextField:(CGRect)rect Place:(NSString*)text TextColor:(UIColor*)color TextAliment:(NSTextAlignment)aliment Sv:(UIView*)view  delegate:(id<UITextFieldDelegate>)delegate;

- (UIButton*)creatButton:(CGRect)rect Title:(NSString*)title textColor:(UIColor*)color  NormalBackImage:(NSString*)backImageName SelectlBackImage:(NSString*)selectBackImageName Ation:(SEL)ation SubView:(UIView*)subView AtionTarget:(id)target;

- (NSMutableArray*)bubblingSort:(NSMutableArray*)arry With:(NSMutableArray*)arry1;

- (NSMutableArray*)bubblingSort:(NSMutableArray*)arry WithType:(int)type;

-(NSString*)getCurrentTime;

-(NSString*)getFurtureTime:(CGFloat)furtureMinute;

- (NSString*)getAppointTime:(int)day WithCurrtntTime:(NSString*)locationString;
- (NSString*)getAppointTime:(int)day withHour:(int)hour withMinute:(int)minute WithCurrtntTime:(NSString*)locationString;

//-(void)inputLimitMethedWithTextField:(UITextField*)text length:(int)leng;
//-(void)inputLimitMethedWithTextView:(UITextView*)text length:(int)leng;
/**
 *	@brief	判断所输内容是否为表情
 *  @param 	text   输入内容
 *	 */
- (NSString*)disable_emoji:(NSString *)text WithView:(UIView*)view;
/**
 *	@brief	NSUTF8StringEncoding转为中文
 *  @param 	text   输入内容
 *	 */
- (NSString*)nsutf8StringEncodingWithString:(NSString*)string;

/**
 *	@brief	获取某月的第一天或最后一天day=0获取最后一天，day=1获取第一天
 *
 
 *	 */
-(NSString*)getMonthWithString:(NSString*)times IfFirstDay:(BOOL)firstDay OrLastDay:(BOOL)lastDay WithDay:(int)day;
/**
 *	@brief	获取某月具体的某一天(获取到的时分秒不是我们这边的)
 *  @param 	date为某月的当前日期
 
 *	 */
-(NSString*)getLastMonthFirst:(NSDate*)date day:(int)days;

///获取传入日期的凌晨
- (NSString*)getCurrentTimeWithSpecifyTime:(NSString*)string WeatherStart:(BOOL)start;
/**
 *	@brief 字符转时间
 
 *  @param 	date为某月的当前日期
 
 *	 */

- (NSDate*)getDateForString:(NSString*)dateString;

/**
 *	@brief preTime，RecentTime 时间差与time作比较
 *  @param 	date为某月的当前日期
 
 *	 */

-(BOOL)IsShowTime:(NSString*)preTime  SecondTime:(NSString*)RecentTime TheTimeInterval:(int)time;

- (UIImage*)the_tensileImage:(NSString*)imgName With:(float)with Height:(float)height;
- (UIImage*)stretchableImage:(NSString*)imgName With:(int)with Height:(int)height;
- (UIImage*)resizableImageByEdgeInset:(NSString*)imgName UIEdgeInset:(UIEdgeInsets)inset;
/**
 *	@brief	构建聊天回话lable
 *  @param 	date为某月的当前日期
 *  @param 	type为1左 2为右
 *	 */

- (void)adjustChatLableFramewithType:(int)type backImg:(NSString*)backImgs EdgeInset:(UIEdgeInsets)inset WithLable:(UILabel*)lableS backImgView:(UIImageView*)tImage BackViewFrame:(CGRect)backViewFrame WithSubView:(UIView*)view ViewFrame:(CGRect)viewFrame WithHight:(CGFloat)iconH;

/**
 *	@brief	相片多选
 *  @param 	minCount 最大值
 *  @param 	type为1拍照 2为相册
 *	 */
-(NSMutableArray*)mutablePhotoWithMinCount:(NSInteger)minCount ViewController:(UIViewController*)control Types:(NSInteger)type;

@end
