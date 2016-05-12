//
//  KLGroupSenderContentView.h
//  BreatheDoctor
//
//  Created by comv on 16/4/27.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KLGroupSenderChatModel;


@interface KLVoiceTypeView : UIView

@property (nonatomic, strong) UILabel *voiceCountLabel;
@property (nonatomic, strong) UIButton *bgView;
@property (nonatomic, strong) UIImageView *animationView;
@property (nonatomic, strong) UIActivityIndicatorView *indicator;
- (void)benginLoadVoice;
- (void)didLoadVoice;
- (void)stopPlay;
@end

@interface KLGroupSenderContentView : UIView

@property (nonatomic, strong) KLGroupSenderChatModel *model;

- (void)tapGoodsTheGoodsID:(NSString *)goodsId;
- (void)voiceTapEvent:(KLGroupSenderChatModel *)model thePlayView:(id)view;

@end
