//
//  KLGroupSenderChatCell.m
//  BreatheDoctor
//
//  Created by comv on 16/4/27.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLGroupSenderChatCell.h"
#import "KLGroupSenderChatView.h"

@interface KLGroupSenderChatCell ()

@property (nonatomic, strong) UILabel  *timerLabel;
@property (nonatomic, strong) KLGroupSenderChatView *chatView;

@end

@implementation KLGroupSenderChatCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = 0;
        self.backgroundColor = [UIColor clearColor];
        
        _timerLabel = ({
        
            UILabel *label = [UILabel new];
            label.textColor = [UIColor colorWithHexString:@"#999999"];
            label.font = kNSPXFONT(22);
            label.textAlignment = 1;
            label;
        });
        _timerLabel.text = @"2016-11-11 12:45";
        
        _chatView = ({
        
            KLGroupSenderChatView *view = [KLGroupSenderChatView new];
            view;
        });

        [self sd_addSubviews:@[_timerLabel,_chatView]];
        
        _timerLabel.sd_layout
        .leftSpaceToView(self,0)
        .rightSpaceToView(self,0)
        .topSpaceToView(self,15)
        .heightIs(15);
        
        _chatView.sd_layout
        .leftSpaceToView(self,15)
        .rightSpaceToView(self,15)
        .topSpaceToView(_timerLabel,20);
        
        [self setupAutoHeightWithBottomView:_chatView bottomMargin:15];
        
        
    }
    return self;
}




@end
