//
//  EventInfoObj.h
//  DiabetesPatient
//
//  Created by 郑建武 on 15-2-27.
//  Copyright (c) 2015年 com.comvee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventInfoObj : NSObject

@property (nonatomic,strong) NSString *event_id;            //事件ID
@property (nonatomic,strong) NSString *time;                //产生时间
@property (nonatomic,strong) NSString *label;               //事件对应标签

@property (nonatomic,strong) NSString *startMils;           //开始时间
@property (nonatomic,strong) NSString *duration;            //时长
@property (nonatomic) int acc;                              //累加值
@property (nonatomic,strong) NSString *version;             //软件版本号

@end

