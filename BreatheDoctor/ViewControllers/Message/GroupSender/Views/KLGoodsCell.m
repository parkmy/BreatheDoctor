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

@interface KLGoodsCell ()
{
    UIImageView *_goodsIcon;
    UILabel     *_goodsNameLabel;
    UILabel     *_goodsPriceLabel;
    KLLineLabel     *_goodsOriginalPriceLabe;
    
}
@end

@implementation KLGoodsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _goodsIcon = ({
            
            UIImageView *imageView = [UIImageView new];
            imageView.image = kImage(@"defaultIconImage");
            imageView;
        });
        
        _goodsNameLabel = ({
        
            UILabel *label = [UILabel new];
            label.numberOfLines = 2;
            label.font = kNSPXFONT(26);
            label.textColor = [UIColor colorWithHexString:@"#333333"];
            label;
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

        [self sd_addSubviews:@[_goodsIcon,
                               _goodsNameLabel,
                               _goodsPriceLabel,
                               _goodsOriginalPriceLabe]];
        
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
        
        
        _goodsNameLabel.text = @"_goodsNameLabel_goodsNameLabel_goodsNameLabel_goodsNameLabel";
        _goodsPriceLabel.attributedText = [KLGroupSenderOperation getGoodsPriceLabeString:@"￥1700"];
        _goodsOriginalPriceLabe.text = @"￥1900";
        
        [_goodsIcon updateLayout];
    }
    return self;
}



@end
