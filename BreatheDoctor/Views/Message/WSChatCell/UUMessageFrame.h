//
//  UUMessageFrame.h
//  UUChatDemoForTextVoicePicture
//
//  Created by shake on 14-8-26.
//  Copyright (c) 2014年 uyiuyao. All rights reserved.
//

#define ChatMargin 10       //间隔
#define ChatIconWH 44       //头像宽高height、width
#define ChatPicWH (150/2)    //图片宽高
#define ChatContentW 150    //内容宽度

#define ChatTimeMarginW 20  //时间文本与边框间隔宽度方向
#define ChatTimeMarginH 20  //时间文本与边框间隔高度方向

#define ChatContentTop 15   //文本内容与按钮上边缘间隔
#define ChatContentLeft 25  //文本内容与按钮左边缘间隔
#define ChatContentBottom 15 //文本内容与按钮下边缘间隔
#define ChatContentRight 15 //文本内容与按钮右边缘间隔

#define ChatTimeFont [UIFont systemFontOfSize:11]   //时间字体
#define ChatContentFont [UIFont systemFontOfSize:14]//内容字体

#import <Foundation/Foundation.h>
@class LWChatModel;

@interface UUMessageFrame : NSObject

@property (nonatomic, assign, readonly) CGRect nameF;
@property (nonatomic, assign, readonly) CGRect iconF;
@property (nonatomic, assign, readonly) CGRect timeF;
@property (nonatomic, assign, readonly) CGRect contentF;
@property (nonatomic, assign) CGFloat cardContentHigh;

@property (nonatomic, assign) CGFloat cellHeight;


@property (nonatomic, strong) LWChatModel *model;
@property (nonatomic, assign) BOOL showTime;

@end
