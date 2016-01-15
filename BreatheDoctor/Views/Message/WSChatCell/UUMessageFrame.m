//
//  UUMessageFrame.m
//  UUChatDemoForTextVoicePicture
//
//  Created by shake on 14-8-26.
//  Copyright (c) 2014年 uyiuyao. All rights reserved.
//

#import "UUMessageFrame.h"
#import "LWChatModel.h"
#import "LWTool.h"

@implementation UUMessageFrame

- (void)setShowTime:(BOOL)showTime
{
    _showTime = showTime;
    
    [self setModel:_model];
}
- (void)setModel:(LWChatModel *)model
{
    _model = model;
    
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;

    // 1、计算时间的位置
    if (_showTime){
        CGFloat timeY = ChatMargin;
        CGSize timeSize = [_model.insertDt sizeWithFont:ChatTimeFont constrainedToHeight:15];
        
        CGFloat timeX = (screenW - timeSize.width) / 2;
        _timeF = CGRectMake(timeX, timeY, timeSize.width + ChatTimeMarginW, timeSize.height + ChatTimeMarginH);
    }
    
    
    // 2、计算头像位置
    CGFloat iconX = ChatMargin;
    if (model.ownerType) {
        iconX = screenW - ChatMargin - ChatIconWH;
    }
    CGFloat iconY = CGRectGetMaxY(_timeF) + ChatMargin;
    _iconF = CGRectMake(iconX, iconY, ChatIconWH, ChatIconWH);
    
    // 3、计算ID位置
    _nameF = CGRectMake(iconX, iconY+ChatIconWH, ChatIconWH, 20);
    
    // 4、计算内容位置
    CGFloat contentX = CGRectGetMaxX(_iconF)+ChatMargin;
    CGFloat contentY = iconY;

    //根据种类分
    CGSize contentSize;
    switch (_model.chatCellType) {
        case WSChatCellType_Text:
            contentSize = [_model.msgContent sizeWithFont:ChatContentFont constrainedToWidth:screenW - ChatIconWH*3 -10];
            
            break;
        case WSChatCellType_Image:
            contentSize = CGSizeMake(ChatPicWH, ChatPicWH);
            break;
        case WSChatCellType_Audio:
            contentSize = CGSizeMake(70, 20);
            break;
        case WSChatCellType_Card:
            break;
        case WSChatCellType_Agreed:
            
            break;
        default:
            break;
    }

    if (_model.ownerType) {
        contentX = iconX - contentSize.width - ChatContentLeft - ChatContentRight - ChatMargin;
    }
    _contentF = CGRectMake(contentX, contentY, contentSize.width + ChatContentLeft + ChatContentRight, contentSize.height + ChatContentTop + ChatContentBottom);

    _cellHeight = MAX(CGRectGetMaxY(_contentF), CGRectGetMaxY(_nameF))  + ChatMargin;

    if (model.chatCellType == WSChatCellType_Card) {
        
        NSDictionary *dic = [LWTool chatMessageCardModel:_model];
        
        CGFloat height = [dic[@"content"] sizeWithFont:[UIFont systemFontOfSize:14] constrainedToWidth:[UIScreen mainScreen].bounds.size.width-50].height+30;
        height = MAX(height, 30);
        _cardContentHigh = height;
        _cellHeight = height+110 + 35;
        _contentF = CGRectZero;
        
    }else if (model.chatCellType == WSChatCellType_Agreed)
    {
        _cellHeight = 75;
        _contentF = CGRectZero;
    }
}


@end
