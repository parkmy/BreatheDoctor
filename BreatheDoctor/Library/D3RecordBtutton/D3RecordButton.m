//
//  D3RecordButton.m
//  D3RecordButtonDemo
//
//  Created by bmind on 15/7/28.
//  Copyright (c) 2015年 bmind. All rights reserved.
//

#import "D3RecordButton.h"
#import "RecordHUD.h"

@implementation D3RecordButton

-(void)initRecord:(id<D3RecordDelegate>)delegate maxtime:(int)_maxTime title:(NSString *)_title{
    self.delegate = delegate;
    maxTime = _maxTime;
    title = _title;
    mp3 = [[Mp3Recorder alloc]initWithDelegate:self];
    
    [self addTarget:self action:@selector(startRecord) forControlEvents:UIControlEventTouchDown];
    [self addTarget:self action:@selector(stopRecord) forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(cancelRecord) forControlEvents:UIControlEventTouchUpOutside | UIControlEventTouchCancel];
    [self addTarget:self action:@selector(RemindDragExit:) forControlEvents:UIControlEventTouchDragExit];
    [self addTarget:self action:@selector(RemindDragEnter:) forControlEvents:UIControlEventTouchDragEnter];
}

-(void)initRecord:(id<D3RecordDelegate>)delegate maxtime:(int)_maxTime{
    [self initRecord:delegate maxtime:_maxTime title:nil];
}


//开始录音
-(void)startRecord{
    
    if ([_delegate respondsToSelector:@selector(starRecord)]) {
        [_delegate starRecord];
    }
    [self setTitle:@"松开发送" forState:UIControlStateNormal];
    self.backgroundColor = RGBA(49, 109, 255, .5);
    count = 0;
    [mp3 startRecord];
    [RecordHUD show];
    [self setHUDTitle];
}

//正常停止录音，开始转换数据
-(void)stopRecord{
    self.backgroundColor = [UIColor clearColor];
    [self setTitle:@"按住说话" forState:UIControlStateNormal];
    [mp3 stopRecord];
    [RecordHUD dismiss];
}

//取消录音
-(void)cancelRecord{
    if ([_delegate respondsToSelector:@selector(endRecord)]) {
        [_delegate endRecord];
    }
    self.backgroundColor = [UIColor clearColor];
    [self setTitle:@"按住说话" forState:UIControlStateNormal];
    [mp3 cancelRecord];
    [RecordHUD dismiss];
    [RecordHUD setTitle:@"已取消录音"];
}

//离开按钮范围
- (void)RemindDragExit:(UIButton *)button
{
    [self setTitle:@"松手取消发送" forState:UIControlStateNormal];

    self.backgroundColor = [UIColor clearColor];
    [RecordHUD setTitle:@"松手取消录音"];
    if ([_delegate respondsToSelector:@selector(dragExit)]) {
        [_delegate dragExit];
    }
}

//进入按钮范围
- (void)RemindDragEnter:(UIButton *)button
{
    [self setTitle:@"松开发送" forState:UIControlStateNormal];
    self.backgroundColor = RGBA(49, 109, 255, .5);
    [self setHUDTitle];
    if ([_delegate respondsToSelector:@selector(dragEnter)]) {
        [_delegate dragEnter];
    }
}

-(void)setHUDTitle{
    if (title != nil) {
        [RecordHUD setTitle:title];
    }
    else{
        [RecordHUD setTitle:@"离开按钮取消录音"];
    }
}


#pragma mark Mp3RecordDelegate
-(void)beginConvert{
}

//录音失败
- (void)failRecord
{
}


//回调录音资料
- (void)endConvertWithData:(NSData *)voiceData
{
    if ([_delegate respondsToSelector:@selector(endRecord)]) {
        [_delegate endRecord];
    }
    [RecordHUD setTitle:@"录音成功"];
    if ([_delegate respondsToSelector:@selector(endRecord:timeCount:)]) {
        [_delegate endRecord:voiceData timeCount:count];
    }
}

-(void)recording:(float)recordTime volume:(float)volume{
    if (recordTime>=maxTime) {
        [self stopRecord];
    }
    count = recordTime;
    int t = recordTime;    
    [RecordHUD setImage:[NSString stringWithFormat:@"mic_%d.png",t%4]];
    [RecordHUD setTimeTitle:[NSString stringWithFormat:@"录音: %.0f\"",recordTime]];
}
@end
