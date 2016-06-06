//
//  KLGoodsCell.m
//  BreatheDoctor
//
//  Created by comv on 16/4/26.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLGoodsCell.h"
#import "KLGroupSenderOperation.h"
#import "KLLineLabel.h"
#import "KLGoodsModel.h"
#import <UIButton+WebCache.h>

@interface KLGoodsCell ()
{
    UIButton        *_goodsIcon;
    UILabel         *_goodsNameLabel;
    UILabel         *_goodsPriceLabel;
    KLLineLabel     *_goodsOriginalPriceLabe;
    UIView          *_contentTypeView;
}
@end

@implementation KLGoodsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //修改背景颜色
        UIView *backgroundViews = [[UIView alloc]initWithFrame:self.contentView.frame];
        backgroundViews.backgroundColor = [[UIColor colorWithHexString:@"#d4d4d4"] colorWithAlphaComponent:.7];
        self.selectedBackgroundView = backgroundViews;
        
        _goodsIcon = ({
            
            UIButton *imageView = [UIButton buttonWithType:UIButtonTypeCustom];
            imageView.enabled = false;
            imageView.layer.borderColor = [UIColor colorWithHexString:@"#dcdcdc"].CGColor;
            imageView.layer.borderWidth = .5f;
            [imageView setImage:kImage(@"defaultIconImage") forState:UIControlStateNormal];
            imageView;
        });
        
        _goodsNameLabel = ({
        
            UILabel *label = [UILabel new];
            label.numberOfLines = 2;
            label.font = kNSPXFONT(26);
            label.textColor = [UIColor colorWithHexString:@"#333333"];
            label;
        });
        
        _contentTypeView = ({
        
            UIView *view = [UIView new];
            view.backgroundColor = [UIColor whiteColor];
            view;
        });
        
        
        _goodsPriceLabel = ({
            
            UILabel *label = [UILabel new];
            label.textColor = [UIColor colorWithHexString:@"#dd2727"];
            label;
        });

        _goodsOriginalPriceLabe = ({
            
            KLLineLabel *label = [KLLineLabel new];
            label.textColor = [UIColor colorWithHexString:@"#cccccc"];
            label.strikeThroughEnabled = YES;
            label.strikeThroughColor = label.textColor;
            label.font = kNSPXFONT(18);
            label;
        });

        UIView *bottomLine = [UIView allocAppLineView];
        
        [self sd_addSubviews:@[_goodsIcon,
                               _goodsNameLabel,
                               _contentTypeView,
                               _goodsPriceLabel,
                               _goodsOriginalPriceLabe
                               ,bottomLine]];
        
        _goodsIcon.sd_layout
        .leftSpaceToView(self,10)
        .topSpaceToView(self,10)
        .bottomSpaceToView(self,10)
        .widthEqualToHeight();
        
        _goodsNameLabel.sd_layout
        .leftSpaceToView(_goodsIcon,10)
        .rightSpaceToView(self,20)
        .topSpaceToView(self,11)
        .heightIs(40);
        
        _contentTypeView.sd_layout
        .leftEqualToView(_goodsNameLabel)
        .rightEqualToView(_goodsNameLabel)
        .topSpaceToView(_goodsNameLabel,7)
        .bottomSpaceToView(_goodsPriceLabel,10);
        
        _goodsPriceLabel.sd_layout
        .bottomSpaceToView(self,12)
        .leftSpaceToView(_goodsIcon,10)
        .heightIs(15)
        .widthIs(60);
        
        _goodsOriginalPriceLabe.sd_layout
        .bottomEqualToView(_goodsPriceLabel)
        .leftSpaceToView(_goodsPriceLabel,8)
        .heightIs(10)
        .widthIs(50);
        
        bottomLine.sd_layout
        .bottomSpaceToView(self,0)
        .rightSpaceToView(self,0)
        .leftSpaceToView(self,0)
        .heightIs(.5);
        
        [_goodsIcon updateLayout];
    }
    return self;
}

- (void)setGoods:(id)goods{

    _goods = goods;
    
    KLGoodsModel *model = _goods;

    _goodsNameLabel.text = [NSString stringJudgeNullInfoString:model.productName];
    CGFloat height = [_goodsNameLabel.text heightWithFont:_goodsNameLabel.font constrainedToWidth:_goodsNameLabel.width];
    _goodsNameLabel.sd_layout.heightIs(MAX(height, 14));
    
    [_goodsIcon sd_setImageWithURL:kNSURL([NSString stringJudgeNullInfoString:model.imageUrl]) forState:UIControlStateNormal placeholderImage:kImage(@"defaultIconImage")];
    
    _goodsPriceLabel.text = [KLGroupSenderOperation priceFloatEqlistThePrice:[NSString stringWithFormat:@"￥%.2f",model.marketPrice/100]];

    CGFloat width = [_goodsPriceLabel.text widthWithFont:_goodsPriceLabel.font constrainedToHeight:_goodsPriceLabel.height];
    _goodsPriceLabel.sd_layout.widthIs(width);
    _goodsPriceLabel.attributedText = [KLGroupSenderOperation getGoodsPriceLabeString:_goodsPriceLabel.text];
    
    _goodsOriginalPriceLabe.text = [KLGroupSenderOperation priceFloatEqlistThePrice:[NSString stringWithFormat:@"￥%.2f",model.originalPrice/100]];
    
    NSArray *tags = [[self class] getTages:model.tags];
    
    [[self class] addTagsLabelWithSuperView:_contentTypeView andTages:tags];
    
    [_contentTypeView layoutSubviews];
    
    [self layoutSubviews];
}

+ (void)addTagsLabelWithSuperView:(UIView *)view andTages:(NSArray *)tags{

    [view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

    CGFloat x = 0;
    
    for (int j = 0; j < tags.count; j++)
    {
        NSString *tag = tags[j];
        UILabel *label = [self tagLabelWith:tag];
        if (label) {
            [view addSubview:label];
            CGFloat width = [tag widthWithFont:label.font constrainedToHeight:14*MULTIPLEVIEW];
            label.sd_layout
            .leftSpaceToView(view,x)
            .centerYEqualToView(view)
            .widthIs(width+10)
            .heightIs(14*MULTIPLEVIEW);
            
            x += (width+5+10);
        }
    }
    
}
+ (UILabel *)tagLabelWith:(NSString *)tag{
    
    if ([tag isEqualToString:@""])
    {
        return nil;
    }
    
    UILabel *label = [UILabel new];
    label.tag = 10086;
    label.textAlignment = 1;
    label.text = tag;
    label.font = kNSPXFONT(18);
    label.textColor = [UIColor colorWithHexString:@"#ff6565"];
    label.layer.borderWidth = .5;
    label.layer.borderColor = [UIColor colorWithHexString:@"#ff6565"].CGColor;
    [label setCornerRadius:4.0f];
    return label;
}

+ (NSArray *)getTages:(NSString *)tag{

    return [[NSString stringJudgeNullInfoString:tag] componentsSeparatedByString:@"@#@"];
}


@end
