//
//  KLGoodsDetailedIntroductionCell.m
//  BreatheDoctor
//
//  Created by comv on 16/4/29.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLGoodsDetailedIntroductionCell.h"
#import "SDCycleScrollView.h"
#import "KLGoodsDetailedModel.h"
#import "KLGoodsDetailedImageUrlList.h"
#import "KLGroupSenderOperation.h"

@interface KLGoodsDetailedIntroductionCell ()

@property (nonatomic, strong) SDCycleScrollView  *goodsScrollView;
@property (nonatomic, strong) UILabel *goodsNameLabel;
@property (nonatomic, strong) UILabel *goodsPriceLabel;
@property (nonatomic, strong) UILabel *goodsFreightInventoryLabel;

@property (nonatomic, strong) UIView  *line;
@end

@implementation KLGoodsDetailedIntroductionCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = 0;
        
        _goodsScrollView = ({
        
            SDCycleScrollView *view = [SDCycleScrollView new];
            view.isSp = YES;
            view.autoScroll = NO;
            view.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
            view.currentPageDotColor = [UIColor colorWithHexString:@"#ff9402"];
            view.placeholderImage = kImage(@"defaultIconImage");
            view.autoScrollTimeInterval = 4.0f;
            view.pageControlDotSize = CGSizeMake(5, 5);
            view;
        });
        
        _goodsNameLabel = ({
            
            UILabel *label = [UILabel new];
            label.font = kNSPXFONT(30);
            label.textColor = [UIColor colorWithHexString:@"#333333"];
            label;
        });
        
        _goodsPriceLabel = ({
            
            UILabel *label = [UILabel new];
            label.textColor = [UIColor colorWithHexString:@"#ff0000"];
            label.font = kNSPXFONT(48);
            label.textAlignment = NSTextAlignmentRight;
            label;
        });
        
        _goodsFreightInventoryLabel = ({
            
            UILabel *label = [UILabel new];
            label.font = kNSPXFONT(26);
            label.textColor = [UIColor colorWithHexString:@"#999999"];
            label.adjustsFontSizeToFitWidth = YES;
            label;
        });
        
        _line = [UIView allocAppLineView];
        
        
        [self.contentView sd_addSubviews:@[_goodsScrollView,
                                           _goodsNameLabel,
                                           _line,
                                           _goodsPriceLabel,
                                           _goodsFreightInventoryLabel]];
        
        
        
        _goodsScrollView.sd_layout
        .leftSpaceToView(self.contentView,0)
        .rightSpaceToView(self.contentView,0)
        .topSpaceToView(self.contentView,0)
        .heightIs(162*MULTIPLEVIEW);
        
        _goodsPriceLabel.sd_layout
        .rightSpaceToView(self.contentView,15)
        .heightIs(20*MULTIPLE);
        
        _line.sd_layout
        .rightSpaceToView(_goodsPriceLabel,15)
        .topSpaceToView(_goodsScrollView,11)
        .bottomSpaceToView(self.contentView,11)
        .widthIs(.5);
        
        _goodsNameLabel.sd_layout
        .leftSpaceToView(self.contentView,10)
        .rightSpaceToView(_line,15)
        .topSpaceToView(_goodsScrollView,11)
        .autoHeightRatio(0);
        
        _goodsFreightInventoryLabel.sd_layout
        .leftSpaceToView(self.contentView,10)
        .rightSpaceToView(_line,15)
        .topSpaceToView(_goodsNameLabel,9)
        .heightIs(15);
        
        [self setupAutoHeightWithBottomView:_goodsFreightInventoryLabel bottomMargin:9];
        
    }
    return self;
}
- (void)setModel:(KLGoodsDetailedModel *)model{

    _model = model;
    
    self.goodsScrollView.imageURLStringsGroup = [self goodsImageUrlListWithList:_model.imageUrlList];
    
    self.goodsNameLabel.text = [NSString stringJudgeNullInfoString:_model.productName];

    NSString *Freight = _model.productFreight <= 0?@"免运费":[NSString stringWithFormat:@"￥%.2f",_model.productFreight/100];
    NSString *Inventory = _model.productInventoryCount <= 0?@"暂缺":[NSString stringWithFormat:@"%@",kNSNumInteger(_model.productInventoryCount)];
    self.goodsFreightInventoryLabel.text = [NSString stringWithFormat:@"运费:  %@        库存:  %@",Freight,Inventory];
    
    _goodsPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",_model.marketPrice/100];
    _goodsPriceLabel.text =[KLGroupSenderOperation priceFloatEqlistThePrice:_goodsPriceLabel.text];
    _goodsPriceLabel.attributedText = [self marketPriceWithString:_goodsPriceLabel.text];
    CGFloat priceLabelWidth = [_goodsPriceLabel.text widthWithFont:_goodsPriceLabel.font constrainedToHeight:20]+10;
    
    [_line updateLayout];
    
    self.goodsPriceLabel.sd_layout.topSpaceToView(self.goodsScrollView,_line.height*.5+1).widthIs(priceLabelWidth);;

}

- (NSMutableArray *)goodsImageUrlListWithList:(NSArray *)list{

    NSMutableArray *array = [NSMutableArray array];
    for (KLGoodsDetailedImageUrlList *listModel in list) {
        if (listModel.type == 1) {
            [array addObject:listModel.imageUrl];
        }
    }
    return array;
}

- (NSMutableAttributedString *)marketPriceWithString:(NSString *)string{
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    [attributedString addAttributes:@{NSFontAttributeName:kNSPXFONT(42)} range:NSMakeRange(0, 1)];
    
    return attributedString;
}

@end
