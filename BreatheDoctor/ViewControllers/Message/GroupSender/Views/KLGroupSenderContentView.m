//
//  KLGroupSenderContentView.m
//  BreatheDoctor
//
//  Created by comv on 16/4/27.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLGroupSenderContentView.h"
#import "KLGroupSenderChatModel.h"
#import <UIImageView+WebCache.h>
#import "MJPhotoBrowser.h"
#import "KLGoodsCell.h"
#import "LWVoiceManager.h"

@interface KLGoodsTypeView : UIView

@property (nonatomic, strong) UIImageView *goodsIcon;
@property (nonatomic, strong) UILabel     *goodsName;
@property (nonatomic, strong) UIView      *tagsView;

@end

@implementation KLGoodsTypeView

- (id)initWithFrame:(CGRect)frame{
    
    if ([super initWithFrame:frame]) {
        
        _goodsIcon = [UIImageView new];
        _goodsIcon.layer.borderColor = [UIColor colorWithHexString:@"#dcdcdc"].CGColor;
        _goodsIcon.layer.borderWidth = .5f;
        _goodsIcon.image = kImage(@"defaultIconImage");
        
        _goodsName = [UILabel new];
        _goodsName.numberOfLines = 0;
        _goodsName.font = kNSPXFONT(24);
        _goodsName.textColor = [UIColor colorWithHexString:@"#333333"];
        
        
        _tagsView = [UIView new];
        
        [self sd_addSubviews:@[_goodsIcon,_goodsName,_tagsView]];
        
        _goodsIcon.sd_layout
        .topSpaceToView(self,9)
        .bottomSpaceToView(self,9)
        .leftSpaceToView(self,9)
        .widthEqualToHeight();
        
        _goodsName.sd_layout
        .topSpaceToView(self,14)
        .leftSpaceToView(_goodsIcon,5)
        .rightSpaceToView(self,5)
        .autoHeightRatio(0);
        
        _tagsView.sd_layout
        .leftSpaceToView(_goodsIcon,5)
        .rightSpaceToView(self,5)
        .bottomSpaceToView(self,14)
        .heightIs(15);
        
        [_goodsIcon updateLayout];
        
    }
    return self;
}
@end



@implementation KLVoiceTypeView

- (id)initWithFrame:(CGRect)frame{
    
    if ([super initWithFrame:frame]) {
        
        _voiceCountLabel = [UILabel new];
        _voiceCountLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _voiceCountLabel.font = kNSPXFONT(26);
        
        _bgView          = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bgView setImage:kImage(@"SenderTextNodeBkg.png") forState:UIControlStateNormal];
        
        
        
        _animationView   = [UIImageView new];
//        _animationView.userInteractionEnabled = YES;
        
        _animationView.image = kImage(@"jiankangzixun_62-06.png");
        _animationView.animationImages = [NSMutableArray arrayWithObjects:
                                                 [UIImage imageNamed:@"jiankangzixun_62-08.png"],
                                                 [UIImage imageNamed:@"jiankangzixun_62-07.png"],
                                                 [UIImage imageNamed:@"jiankangzixun_62-06.png"],
                                                 nil];
        
        _indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [self sd_addSubviews:@[_voiceCountLabel,_bgView,_animationView,_indicator]];
        
        _voiceCountLabel.sd_layout
        .leftSpaceToView(self,0)
        .topSpaceToView(self,0)
        .bottomSpaceToView(self,0)
        .widthIs(20);
        
        _bgView.sd_layout
        .leftSpaceToView(_voiceCountLabel,10)
        .topSpaceToView(self,0)
        .bottomSpaceToView(self,0)
        .widthIs(132/2);
        
        _animationView.sd_layout
        .leftSpaceToView(_voiceCountLabel,40)
        .topSpaceToView(self,15)
        .widthIs(11)
        .heightIs(15);
        
        _indicator.sd_layout
        .leftSpaceToView(_voiceCountLabel,40)
        .topSpaceToView(self,15)
        .widthIs(11)
        .heightIs(15);
        
    }
    return self;
}

- (void)benginLoadVoice
{
    self.animationView.hidden = YES;
    [self.indicator startAnimating];
}
- (void)didLoadVoice
{
    self.animationView.hidden = NO;
    [self.indicator stopAnimating];
    [self.animationView startAnimating];
}
-(void)stopPlay
{
    [self.indicator stopAnimating];
    if(self.animationView.isAnimating){
        [self.animationView stopAnimating];
    }
}
@end



@interface KLGroupSenderContentView ()

@property (nonatomic, strong) UILabel            *textTypeLabelView;
@property (nonatomic, strong) KLVoiceTypeView    *voiceTypeView;
@property (nonatomic, strong) UIImageView        *imageTypeView;
@property (nonatomic, strong) KLGoodsTypeView    *goodsTypeView;

@end

@implementation KLGroupSenderContentView
- (void)dealloc{
    
    [[LWVoiceManager shareInstance] stopVoice];
}
- (id)initWithFrame:(CGRect)frame{
    
    if ([super initWithFrame:frame]) {
        
        [self sd_addSubviews:@[self.textTypeLabelView,self.imageTypeView,self.voiceTypeView,self.goodsTypeView]];
        //10
        self.textTypeLabelView.sd_layout
        .leftSpaceToView(self,0)
        .rightSpaceToView(self,0)
        .topSpaceToView(self,0)
        .autoHeightRatio(0);
        //15
        self.imageTypeView.sd_layout
        .topSpaceToView(self,0)
        .centerYEqualToView(self)
        .centerXEqualToView(self)
        .widthIs(125*MULTIPLEVIEW)
        .heightIs(150*MULTIPLEVIEW);
        //0
        self.goodsTypeView.sd_layout
        .topSpaceToView(self,0)
        .leftSpaceToView(self,0)
        .rightSpaceToView(self,0)
        .heightIs((152/2)*MULTIPLEVIEW);
        //20
        self.voiceTypeView.sd_layout
        .topSpaceToView(self,0)
        .centerXEqualToView(self)
        .widthIs(150)
        .heightIs(54);
        
        //        self.textTypeLabelView.text = @"textTypeLabelViewtextTypeLabelViewtextTypeLabelView";
        
        [self setupAutoHeightWithBottomViewsArray:@[self.textTypeLabelView,self.imageTypeView,self.voiceTypeView,self.goodsTypeView] bottomMargin:0];
        
//        [self setupAutoHeightWithBottomView:self.voiceTypeView bottomMargin:20];
        
        [self racEvent];
    }
    return self;
}
- (void)racEvent{
    /**
     *  语音播放
     *
     */
    WEAKSELF
    [[self.voiceTypeView.bgView rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
                
        [KL_weakSelf voiceTapEvent:KL_weakSelf.model thePlayView:KL_weakSelf.voiceTypeView];
    }];
}
- (void)voiceTapEvent:(KLGroupSenderChatModel *)model thePlayView:(id)view{
}
- (void)setModel:(KLGroupSenderChatModel *)model{
    
    _model = model;
    
    self.textTypeLabelView.hidden = YES;
    self.voiceTypeView.hidden     = YES;
    self.imageTypeView.hidden     = YES;
    self.goodsTypeView.hidden     = YES;
    
    self.voiceTypeView.sd_layout.heightIs(0);
    self.imageTypeView.sd_layout.heightIs(0);
    self.goodsTypeView.sd_layout.heightIs(0);
    self.textTypeLabelView.sd_layout.heightIs(0);
    
    switch (model.groupSenderChatType) {
            
        case GroupSenderChatTypeText:
        {
            self.textTypeLabelView.hidden = NO;
            self.textTypeLabelView.text = _model.content;
            self.textTypeLabelView.sd_layout.autoHeightRatio(0);
        }
            break;
        case GroupSenderChatTypeVoice:
        {
            self.voiceTypeView.hidden     = NO;
            self.voiceTypeView.voiceCountLabel.text = [NSString stringWithFormat:@"%@″",kNSNumInteger(_model.voiceCount)];

            self.voiceTypeView.sd_layout.heightIs(54);
            
            if (_model.voiceIsPlay) {
                
                [self.voiceTypeView didLoadVoice];
            }else{
                
                [self.voiceTypeView stopPlay];
            }
            
        }
            break;

        case GroupSenderChatTypeImage:
        {
            self.imageTypeView.hidden     = NO;
            [self.imageTypeView sd_setImageWithURL:kNSURL([NSString stringJudgeNullInfoString:_model.content]) placeholderImage:kImage(@"defaultIconImage")];
            self.imageTypeView.sd_layout.heightIs(150*MULTIPLEVIEW);
        }
            break;

        case GroupSenderChatTypeGoods:
        {
            self.goodsTypeView.hidden     = NO;
            
            [self.goodsTypeView.goodsIcon sd_setImageWithURL:kNSURL([NSString stringJudgeNullInfoString:_model.productimageURL]) placeholderImage:kImage(@"defaultIconImage")];
            [self.goodsTypeView.goodsName setText:[NSString stringJudgeNullInfoString:_model.productName]];
            self.goodsTypeView.sd_layout.heightIs((152/2)*MULTIPLEVIEW);
//            [self setupAutoWidthWithRightView:self.goodsTypeView rightMargin:0];
            
            [KLGoodsCell addTagsLabelWithSuperView:self.goodsTypeView.tagsView andTages:[KLGoodsCell getTages:_model.tags]];
            
            [self.goodsTypeView layoutSubviews];

        }
            break;
        default:
            break;
    }
        
}


- (KLGoodsTypeView *)goodsTypeView{
    
    if (!_goodsTypeView) {
        _goodsTypeView = [KLGoodsTypeView new];
        _goodsTypeView.userInteractionEnabled = YES;
        UITapGestureRecognizer  *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGoodsTypeViewGestureEventClick:)];
        [_goodsTypeView addGestureRecognizer:tapGesture];
    }
    return _goodsTypeView;
}

- (UIImageView *)imageTypeView{
    
    if (!_imageTypeView) {
        _imageTypeView = [UIImageView new];
        _imageTypeView.image = kImage(@"defaultIconImage");
        _imageTypeView.userInteractionEnabled = YES;
        UITapGestureRecognizer  *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureEventClick:)];
        [_imageTypeView addGestureRecognizer:tapGesture];
    }
    return _imageTypeView;
}
- (KLVoiceTypeView *)voiceTypeView{
    
    if (!_voiceTypeView) {
        _voiceTypeView = [KLVoiceTypeView new];
    }
    return _voiceTypeView;
}

- (UILabel *)textTypeLabelView{
    
    if (!_textTypeLabelView) {
        _textTypeLabelView = [UILabel new];
        _textTypeLabelView.textColor = [UIColor colorWithHexString:@"#323232"];
        _textTypeLabelView.numberOfLines = 0;
    }
    return _textTypeLabelView;
}
#pragma mark -click
- (void)tapGoodsTypeViewGestureEventClick:(UITapGestureRecognizer *)sender{
    
    UIMenuController *menu = [UIMenuController sharedMenuController];
    if (menu.isMenuVisible) {
        [menu setMenuVisible:NO animated:YES];
        return;
    }
    [self tapGoodsTheGoodsID:self.model.productID];
}
- (void)tapGoodsTheGoodsID:(NSString *)goodsId{
    
}
- (void)tapGestureEventClick:(UITapGestureRecognizer *)sender{
    
    UIMenuController *menu = [UIMenuController sharedMenuController];
    if (menu.isMenuVisible) {
        [menu setMenuVisible:NO animated:YES];
    }else{
    
        [self showImage:[(UIImageView *)sender.view image]];
    }
    
    
}
- (void)showImage :(UIImage *)image{
    
    MJPhotoBrowser *photoBrowser = [[MJPhotoBrowser alloc] init];
    MJPhoto *photo = [[MJPhoto alloc] init];
    photo.image = image;
    photoBrowser.photos = @[photo];
    [photoBrowser show];
}
@end
