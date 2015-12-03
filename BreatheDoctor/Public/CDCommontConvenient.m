//
//  CommontConvenient.m
//  ComveeDoctor
//
//  Created by JYL on 14-7-31.
//  Copyright (c) 2014年 zhengjw. All rights reserved.
//

#import "CDCommontConvenient.h"
#import "CDMacro.h"
//#import "ShareFun.h"

static CDCommontConvenient * comment;
@implementation CDCommontConvenient


+ (CDCommontConvenient*)shareCDcomment
{
    if (!comment)
    {
        comment = [[CDCommontConvenient alloc]init];
    }
    
    return comment;
}

/**
 *	@brief	构建lable
 *  @param 	rect 尺寸
 *  @param 	text 显示文本
 *  @param 	color字体颜色
 *  @param  Sv	所添加的父视图
 *	 */
- (UILabel*)creatLable:(CGRect)rect text:(NSString*)text Color:(UIColor*)color Font:(UIFont*)font textAliment:(int)aliment Sv:(UIView*)view
{
    UILabel * lable = [[UILabel alloc]initWithFrame:rect];
    lable.backgroundColor = [UIColor clearColor];
    lable.font = font;
    lable.text = text;
    lable.textAlignment = aliment;
    lable.textColor = color;
    [view addSubview:lable];
    return lable;
}

- (UILabel*)createChatLable:(CGRect)rect text:(NSString*)text Color:(UIColor*)color Font:(UIFont*)font textAliment:(int)aliment Sv:(UIView*)view withType:(int)type backImg:(NSString*)backImgs scanH:(float)scanH scanW:(float)scanW
{
    
    CGSize content_size = [[self nsutf8StringEncodingWithString:text] sizeWithFont:font constrainedToWidth:view.width-110];
    
    UIImage *  image =[UIImage imageNamed:backImgs];

    //图片框
    UIImageView *tImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    
    [view addSubview:tImage];
    
    CGFloat height = content_size.height+20;
    height = MIN(height, 42);
   
    CGFloat with =content_size.width+30;
    with = MAX(with, 79);
   
    tImage.frame = CGRectMake(0,0, with,height);
    
   // 左端盖宽度
    NSInteger leftCapWidth = scanW;
    // 顶端盖高度
    NSInteger topCapHeight = scanH;
    // 重新赋值
    image = [image stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
    tImage.image=image;
    
    tImage.frame = CGRectMake(0,0, tImage.frame.size.width, tImage.frame.size.height);
    [view addSubview:tImage];
    
    UILabel * lable = [self creatLable:rect text:text Color:color Font:font textAliment:aliment Sv:view];
    lable.numberOfLines = 0;

    return lable;
}

/**
 *	@brief	构建文本输入框
 *  @param 	rect 尺寸
 *  @param 	text 默认提示语
 *  @param  Sv	所添加的父视图
 *  @param  img 图片名
 *	 */
- (UITextField*)creatTextField:(CGRect)rect Place:(NSString*)text TextColor:(UIColor*)color TextAliment:(NSTextAlignment)aliment Sv:(UIView*)view  delegate:(id<UITextFieldDelegate>)delegate

{
    UITextField * textfield = [[UITextField alloc]initWithFrame:rect];
    textfield.delegate =delegate;
    textfield.textAlignment = aliment;
    textfield.placeholder=text;
    textfield.textColor = color;
    textfield.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    [view addSubview:textfield];

    return textfield;

}

- (UIButton*)creatButton:(CGRect)rect Title:(NSString*)title textColor:(UIColor*)color  NormalBackImage:(NSString*)backImageName SelectlBackImage:(NSString*)selectBackImageName Ation:(SEL)ation SubView:(UIView*)subView AtionTarget:(id)target
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = rect;
    btn.exclusiveTouch = YES;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:backImageName] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:selectBackImageName] forState:UIControlStateSelected];
    [btn addTarget:target action:ation forControlEvents:UIControlEventTouchUpInside];
    [subView addSubview:btn];
    
    return btn;
}

- (NSString*)getAppointTime:(int)day withHour:(int)hour withMinute:(int)minute WithCurrtntTime:(NSString*)locationString
{
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *senddate=[format dateFromString:locationString];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdds = [[NSDateComponents alloc] init];
    //重新设置日期-day获取到月份的上月最后一天,-day+1获取到月份第一天
    [componentsToAdds setDay:day];
    [componentsToAdds setHour:8+hour];
    [componentsToAdds setMinute:minute];
    //获取重置日期
    NSDate *dateAfterDay = [calendar dateByAddingComponents:componentsToAdds toDate:senddate options:0];

    NSString * s =[dateAfterDay.description substringWithRange:NSMakeRange(0, 19)];
    
    return s;
}

#pragma mark_冒泡排序
- (NSMutableArray*)bubblingSort:(NSMutableArray*)arry With:(NSMutableArray*)arry1
{
    
    NSMutableArray * sortArr = [[NSMutableArray alloc]init];
    for (int i = 0; i<[arry1 count]; i++)
    {
        for (int j=i+1; j<[arry1 count]; j++)
        {
            int a = [[arry1 objectAtIndex:i] intValue];
            
            int b = [[arry1 objectAtIndex:j] intValue];
            
            if (a > b)
            {
                [arry1 replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%d",b]];
                [arry1 replaceObjectAtIndex:j withObject:[NSString stringWithFormat:@"%d",a]];
            }
            
        }
        
    }
    for (NSString * s in arry1)
    {
        NSString * string = s;
        
        for (NSString * obj in arry)
        {
            NSString * struls= [obj stringByReplacingOccurrencesOfString:@"_" withString:@""];
            if ([s isEqualToString:struls])
            {
                string = obj;
                break;
            }
            
        }
        
        [sortArr addObject:string];
    }
    
    return sortArr;
}

#pragma  mark 字符串排序时间
- (NSMutableArray*)bubblingSort:(NSMutableArray*)arry WithType:(int)type
{
    NSMutableArray * sortArr = [[NSMutableArray alloc]init];
    SEL sel = @selector(localizedCompare:);
    arry = (NSMutableArray*)[arry sortedArrayUsingSelector:sel];
    if (type==1)
    {
        for (int i = 0; i<arry.count; i++)
        {
            NSString * s = arry[i];
            [sortArr addObject:s];
        }
    }
    else
    {
        for (int i = (int)arry.count-1; i>=0; i--)
        {
            NSString * s = arry[i];
            [sortArr addObject:s];
        }
    }
    
    
    return sortArr;
    
}

//-(void)inputLimitMethedWithTextField:(UITextField*)text length:(int)leng
//{
//    
//    
//    NSString *toBeString = text.text;
//    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
//    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
//        UITextRange *selectedRange = [text markedTextRange];
//        //获取高亮部分
//        UITextPosition *position = [text positionFromPosition:selectedRange.start offset:0];
//        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
//        if (!position) {
//            
//            if (toBeString.length > leng) {
//                text.text = [toBeString substringToIndex:leng];
//            }
//        }
//        // 有高亮选择的字符串，则暂不对文字进行统计和限制
//        else{
//            
//        }
//    }
//    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
//    else{
//        if (toBeString.length > leng) {
//            text.text = [toBeString substringToIndex:leng];
//        }
//    }
// 
//}

//-(void)inputLimitMethedWithTextView:(UITextView*)text length:(int)leng
//{
//    NSString *toBeString = text.text;
//    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
//    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
//        UITextRange *selectedRange = [text markedTextRange];
//        //获取高亮部分
//        UITextPosition *position = [text positionFromPosition:selectedRange.start offset:0];
//        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
//        if (!position) {
//            
//            if (toBeString.length > leng) {
//                text.text = [toBeString substringToIndex:leng];
//            }
//        }
//        // 有高亮选择的字符串，则暂不对文字进行统计和限制
//        else{
//            
//        }
//    }
//    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
//    else{
//        if (toBeString.length > leng) {
//            text.text = [toBeString substringToIndex:leng];
//        }
//    }
//
//}

- (NSString*)disable_emoji:(NSString *)text WithView:(UIView*)view
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    //替换的位置
    NSTextCheckingResult * resgut= [regex firstMatchInString:text options:0 range:NSMakeRange(0,[text length])];
    if (resgut)
    {
        
       // [ShareFun showALAlertBannerWithView:view Style:SALAlertBannerStyleWarning  Position:SALAlertBannerPositionTop Subtitle:@"不支持特殊字符输入" WithBtn:nil];
        
        NSString *dataUTF8 = [text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        return dataUTF8;
        
    }
    else
    {
        return text;
    }
    
}

- (NSString*)nsutf8StringEncodingWithString:(NSString*)string
{
    return  [string  stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

/**
 *	@brief	获取某月具体的某一天(获取到的时分秒不是我们这边的)
 *  @param 	date为某月的当前日期
 *  @param  future 未来几分钟内
 *	 */
-(NSString*)getFurtureTime:(CGFloat)furtureMinute
{
    
    NSDate *currentDate = [NSDate date];
    
    NSTimeInterval  interval =furtureMinute*60*1; //1:天数
    static NSString *GLOBAL_TIMEFORMAT = @"yyyy-MM-dd HH:mm:ss";
   
    NSDate* endDate = [currentDate initWithTimeIntervalSinceNow:+interval];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:GLOBAL_TIMEFORMAT];
  
    NSString *  locationString=[dateFormatter stringFromDate:endDate];
    
    return locationString;
    
}
/**
 *	@brief	获取某月具体的某一天(获取到的时分秒不是我们这边的)
 *  @param 	date为某月的当前日期
 
 *	 */
-(NSString*)getCurrentTime
{
    
    NSDate *senddate = [NSDate date];
    static NSString *GLOBAL_TIMEFORMAT = @"yyyy-MM-dd HH:mm:ss";
    NSTimeZone* localzone = [NSTimeZone localTimeZone];
    NSTimeZone* GTMzone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:GLOBAL_TIMEFORMAT];
    [dateFormatter setTimeZone:GTMzone];
    NSDate *Theday = [NSDate dateWithTimeInterval:(0 + [localzone secondsFromGMT]) sinceDate:senddate];
    NSString *  locationString=[dateFormatter stringFromDate:Theday];

    return locationString;

}

- (NSString*)getAppointTime:(int)day WithCurrtntTime:(NSString*)locationString
{
    NSMutableString * string = [[NSMutableString alloc]init];
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *senddate=[format dateFromString:locationString];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdds = [[NSDateComponents alloc] init];
    //重新设置日期-day获取到月份的上月最后一天,-day+1获取到月份第一天
    [componentsToAdds setDay:day];
    //获取重置日期
    NSDate *dateAfterDay = [calendar dateByAddingComponents:componentsToAdds toDate:senddate options:0];
    NSString * s =[dateAfterDay.description substringWithRange:NSMakeRange(0, 10)];
    [string appendString:s];
    [string appendString:[NSString stringWithFormat:@" %@",[locationString substringFromIndex:11]]];
    
    return string;
}

/**
 *	@brief	获取某月的第一天或最后一天day=0获取最后一天，day=1获取第一天
 *
 
 *	 */
-(NSString*)getMonthWithString:(NSString*)times IfFirstDay:(BOOL)firstDay OrLastDay:(BOOL)lastDay WithDay:(int)day
{
    
    NSDateFormatter*df = [[NSDateFormatter alloc]init];//格式化
    [df setDateFormat:@"yyyy-MM-dd"];
    [df setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
    NSDate * date = [NSDate date];
    NSString * years =[times substringWithRange:NSMakeRange(0, 4)];
    NSString * cuyears =[[df stringFromDate:date] substringWithRange:NSMakeRange(0, 4)];
    NSString * monts =[times substringWithRange:NSMakeRange(5, 2)];
    NSString * cumonts =[[df stringFromDate:date] substringWithRange:NSMakeRange(5, 2)];
    int days = 0;
    int nextDay = 1;
    if ([years isEqualToString:cuyears])
    {
        days = [monts intValue]-[cumonts intValue];
        nextDay = days+1;
    }
    else if([years intValue]<[cuyears intValue])
    {
        days = [monts intValue]-([cumonts intValue]+(([cuyears intValue]-[years intValue])*12));
        nextDay = days+1;
    }
    else if([years intValue]>[cuyears intValue])
    {
        days = ([monts intValue]+(([years intValue]-[cuyears intValue])*12))-[cumonts intValue];
        nextDay = days+1;
    }
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    //0为当前月
    if (firstDay==YES)
    {
       [componentsToAdd setMonth:days];
    }
    else
    {
        [componentsToAdd setMonth:nextDay];
    }
    NSDate *dateAfterMonth = [calendar dateByAddingComponents:componentsToAdd toDate:date options:0];
    
    
    return [self getLastMonthFirst:dateAfterMonth day:day];
}
/**
 *	@brief	获取某月具体的某一天(获取到的时分秒不是我们这边的)
 *  @param 	date为某月的当前日期
 
 *	 */
-(NSString*)getLastMonthFirst:(NSDate*)date day:(int)days
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dayComponents = [calendar components:(NSDayCalendarUnit) fromDate:date];
    //对应号：如3号
    NSUInteger day= [dayComponents day];
    NSDateComponents *componentsToAdds = [[NSDateComponents alloc] init];
    //重新设置日期-day获取到月份的上月最后一天,-day+1获取到月份第一天
    
    [componentsToAdds setDay:-day+days];
    //获取重置日期
    NSDate *dateAfterDay = [calendar dateByAddingComponents:componentsToAdds toDate:date options:0];
    //截取出所需日期如:20140404
    NSString * s =[dateAfterDay.description substringWithRange:NSMakeRange(0, 10)];
    return s;
    
}

- (NSString*)getCurrentTimeWithSpecifyTime:(NSString*)string WeatherStart:(BOOL)start
{
    
    NSMutableString * time = [[NSMutableString alloc]init];
    //2014-02-11
    if (start==YES)
    {
      NSString * str = [string substringWithRange:NSMakeRange(0, 10)];
        [time appendString:[NSString stringWithFormat:@"%@ 00:00:00",str]];
    }
    else
    {
        NSString * str = [string substringWithRange:NSMakeRange(0, 10)];
        [time appendString:[NSString stringWithFormat:@"%@ 23:59:59",str]];
    }

    return time;
}

- (NSDate*)getDateForString:(NSString*)dateString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate* inputDate = [formatter dateFromString:dateString];
    
    return inputDate;
}

-(BOOL)IsShowTime:(NSString*)preTime  SecondTime:(NSString*)RecentTime TheTimeInterval:(int)time
{
    
    BOOL result = false;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString * starTime =preTime;
    NSString * endTime =RecentTime;
    
    NSInteger t = [starTime compare:endTime];
    
    NSDate *date1 = [formatter dateFromString:starTime];
    NSDate *date2 = [formatter dateFromString:endTime];
    
    if (t>=0)
    {
        NSTimeInterval aTimer = [date1 timeIntervalSinceDate:date2];
        int hour = (int)(aTimer/3600);
        int minute = (int)(aTimer - hour*3600)/60;
        if ((minute+hour*60)>=time)
        {
            result = YES;
        }
        
    }
    else
    {
        NSTimeInterval aTimer = [date2 timeIntervalSinceDate:date1];
        int hour = (int)(aTimer/3600);
        int minute = (int)(aTimer - hour*3600)/60;
        
        if ((minute+hour*60)>=time)
        {
            result = YES;
        }
        
        
    }
    
    return result;
}

- (UIImage*)the_tensileImage:(NSString*)imgName With:(float)with Height:(float)height
{
    UIImage *backImg = [UIImage imageNamed:imgName];
    NSInteger leftCapWidth = backImg.size.width*with;
    NSInteger topCapHeight = backImg.size.height*height;
    backImg = [backImg stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
    return backImg;
}

- (UIImage*)stretchableImage:(NSString*)imgName With:(int)with Height:(int)height
{
    UIImage *backImg = [UIImage imageNamed:imgName];
    NSInteger leftCapWidth = with;
    NSInteger topCapHeight = height;
    backImg = [backImg stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
    return backImg;
}

- (UIImage*)resizableImageByEdgeInset:(NSString*)imgName UIEdgeInset:(UIEdgeInsets)inset
{
    UIImage *backImg = [UIImage imageNamed:imgName];

    backImg = [backImg resizableImageWithCapInsets:inset resizingMode:UIImageResizingModeStretch];
    return backImg;
}

- (void)adjustChatLableFramewithType:(int)type backImg:(NSString*)backImgs EdgeInset:(UIEdgeInsets)inset WithLable:(UILabel*)lableS backImgView:(UIImageView*)tImage BackViewFrame:(CGRect)backViewFrame WithSubView:(UIView*)view ViewFrame:(CGRect)viewFrame WithHight:(CGFloat)iconH
{

    
    CGSize sizes = [lableS.text sizeWithFont:lableS.font constrainedToHeight:CGFLOAT_MAX];
    
    CGFloat plusOffset = iPhone6Plus?175:((40+10)*2+12*2+9+8);
    
    float weight=  MIN(sizes.width,screenWidth-plusOffset);//9是气泡尖角宽度，10是尖角到头像的距离
    
    
    CGSize content_size = [lableS.text sizeWithFont:lableS.font constrainedToWidth:weight];
    
    CGFloat height = content_size.height;
    
    CGFloat with =content_size.width;
    
    int LabelMinWith = MAX(with + 20, 55);
    
    UIImage *  image =[UIImage imageNamed:backImgs];
    
    tImage.image=[image resizableImageWithCapInsets:inset resizingMode:UIImageResizingModeStretch];
    
    CGRect lableSFrame = CGRectMake(14, 10, with,height);
    
//    [lableS sizeToFit];
    
    int offset = (iconH - sizes.height);//头像的高度减去单行文字的高度为lables的上下间距
    
    if (type==1)
    {
        tImage.frame = CGRectMake(backViewFrame.origin.x,backViewFrame.origin.y,
                                  MAX(lableSFrame.size.width+ 12*2+9, LabelMinWith),MAX(lableSFrame.size.height+offset, iconH));
        
        lableS.frame =CGRectMake((tImage.frame.size.width-lableSFrame.size.width)/2+4,
                                 offset/2, lableSFrame.size.width,lableSFrame.size.height);
    }
    else
    {
        tImage.frame = CGRectMake(viewFrame.size.width-MAX(lableSFrame.size.width+ 12*2+9, LabelMinWith)-iconH-8,
                                  backViewFrame.origin.y,
                                  MAX(lableSFrame.size.width+ 12*2+9,
                                  LabelMinWith),MAX(lableSFrame.size.height+offset, iconH));
        
        lableS.frame =CGRectMake((tImage.frame.size.width-lableSFrame.size.width)/2-4,
                                 offset/2, lableSFrame.size.width,lableSFrame.size.height);
        
    }
    
    view.frame = CGRectMake(viewFrame.origin.x, viewFrame.origin.y,viewFrame.size.width,MAX(tImage.frame.size.height+backViewFrame.origin.y, iconH));
    
}

-(NSMutableArray*)mutablePhotoWithMinCount:(NSInteger)minCount ViewController:(UIViewController*)control Types:(NSInteger)type
{
    NSMutableArray * imgArry = [[NSMutableArray alloc]init];
//    ZLCameraViewController *cameraVc = [[ZLCameraViewController alloc] init];
//    cameraVc.minCount = minCount;
//    [cameraVc startCameraOrPhotoFileWithViewController:control complate:^(id object)
//     {
//         
//         [object enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
//             
//             if ([obj isKindOfClass:[NSDictionary class]])
//             {
//                 [imgArry addObjectsFromArray:[obj allValues]];
//             }
//             else
//             {
//                 [imgArry addObject:obj];
//             }
//         }];
//
//     }type:type];
    
    return imgArry;
}

@end
