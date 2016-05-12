//
//  KLGroupSenderChatCell.m
//  BreatheDoctor
//
//  Created by comv on 16/4/27.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLGroupSenderChatCell.h"
#import "KLGroupSenderChatView.h"
#import "KLGroupSenderChatModel.h"
#import "KLGroupSenderContentView.h"

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
        
        _chatView = ({
        
            KLGroupSenderChatView *view = [KLGroupSenderChatView new];
            view;
        });

        [self.contentView sd_addSubviews:@[_timerLabel,_chatView]];
        
        _timerLabel.sd_layout
        .leftSpaceToView(self.contentView,0)
        .rightSpaceToView(self.contentView,0)
        .topSpaceToView(self.contentView,15)
        .heightIs(15);
        
        _chatView.sd_layout
        .leftSpaceToView(self.contentView,15)
        .rightSpaceToView(self.contentView,15)
        .topSpaceToView(_timerLabel,20);
        
        [self setupAutoHeightWithBottomView:_chatView bottomMargin:15];
        
        WEAKSELF
        [[_chatView.againSenderButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
            KL_weakSelf.againSenderEventBlock?KL_weakSelf.againSenderEventBlock():nil;
        }];
        [[_chatView rac_signalForSelector:@selector(removeItemClicked:)] subscribeNext:^(id x) {
            
            KL_weakSelf.removeEventBlock?KL_weakSelf.removeEventBlock(KL_weakSelf.model):nil;
        }];
        
        [[_chatView.contentView rac_signalForSelector:@selector(tapGoodsTheGoodsID:)] subscribeNext:^(id x) {
            
            RACTuple *tuple = x;
            KL_weakSelf.tapGoodsBlock?KL_weakSelf.tapGoodsBlock(tuple.first):nil;
        }];
        
        [[_chatView.contentView rac_signalForSelector:@selector(voiceTapEvent:thePlayView:)] subscribeNext:^(id x) {
            
            RACTuple *tuple = x;
            KL_weakSelf.voiceTapBlock?KL_weakSelf.voiceTapBlock(tuple.first,tuple.second):nil;
        }];
    }
    return self;
}
- (void)againSender{

}

- (void)setModel:(id)model{
    _model = model;
    KLGroupSenderChatModel *chatModel = model;
    _timerLabel.text = chatModel.createDt;
    _chatView.model = chatModel;
}



@end
