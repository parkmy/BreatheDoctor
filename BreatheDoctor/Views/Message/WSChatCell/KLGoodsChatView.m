//
//  KLGoodsChatView.m
//  BreatheDoctor
//
//  Created by comv on 16/4/27.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLGoodsChatView.h"
#import <UIImageView+WebCache.h>
#import "KLGoodsCell.h"

@interface KLGoodsChatView ()
{
    UIImageView *_goodsIcon;
    UILabel     *_goodsNameLabel;
    UIView      *_tagsView;
    UIImageView *_typeImageView;
}
@end

@implementation KLGoodsChatView

- (id)initWithFrame:(CGRect)frame{

    if ([super initWithFrame:frame]) {
        
        _goodsIcon      = [UIImageView new];
//        dcdcdc
        _goodsIcon.layer.borderColor = [UIColor colorWithHexString:@"#dcdcdc"].CGColor;
        _goodsIcon.layer.borderWidth = .5f;
        _goodsIcon.userInteractionEnabled = YES;
        _goodsIcon.image = kImage(@"defaultIconImage");

        _goodsNameLabel = [UILabel new];
        _goodsNameLabel.userInteractionEnabled = YES;
        _goodsNameLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _goodsNameLabel.font = kNSPXFONT(24);
        _goodsNameLabel.numberOfLines = 0;
        _goodsNameLabel.text = @"_goodsNameLabel_goodsNameLabel_goodsNameLabel_goodsNameLabel";

        _typeImageView  = [UIImageView new];
        _typeImageView.userInteractionEnabled = YES;
        _typeImageView.image = kImage(@"doctor_qunfa_noLook.png");
        _typeImageView.highlightedImage = kImage(@"doctor_qunfa_yesLook.png");
        
        _tagsView = [UIView new];
        
        [self sd_addSubviews:@[_goodsIcon,_goodsNameLabel,_typeImageView,_tagsView]];
        
    }
    return self;
}
- (void)setModel:(LWChatModel *)model{
    
    _model = model;
    NSLog(@"---%f",_model.isDispose);
    [_goodsIcon sd_setImageWithURL:kNSURL(_model.imageUrl) placeholderImage:kImage(@"")];
    _goodsNameLabel.text = [NSString stringJudgeNullInfoString:_model.productName];
    _typeImageView.highlighted = model.isDispose == 1?YES:NO;
    
    [KLGoodsCell addTagsLabelWithSuperView:_tagsView andTages:[KLGoodsCell getTages:_model.tags]];
}
#define bianju 9

- (void)layoutSubviews{
    
    CGFloat goodsiconWH = self.height - bianju*2;

    _typeImageView.frame = CGRectMake(0, 0, (_typeImageView.image.size.width), (_typeImageView.image.size.height));

    
    _goodsIcon.frame = CGRectMake(_typeImageView.maxX, bianju, goodsiconWH, goodsiconWH);
    
    CGFloat height = [[NSString stringJudgeNullInfoString:_goodsNameLabel.text] heightWithFont:_goodsNameLabel.font constrainedToWidth:self.width-goodsiconWH-5-18-bianju-_typeImageView.maxX];
    _goodsNameLabel.frame = CGRectMake(_goodsIcon.maxX+bianju, 14, self.width-goodsiconWH-5-18-bianju-_typeImageView.maxX, height);
    
    
    _tagsView.frame = CGRectMake(_goodsIcon.maxX+bianju,
                                 _goodsIcon.maxY - 20 - 2, _goodsNameLabel.width, 20);

}



@end
