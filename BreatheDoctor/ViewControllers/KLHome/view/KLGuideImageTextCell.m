//
//  KLGuideImageTextCell.m
//  BreatheDoctor
//
//  Created by liaowh on 16/6/6.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLGuideImageTextCell.h"
#import "KLGuideModel.h"

@interface KLGuideImageTextCell ()
@property (nonatomic, strong) UIImageView *contentImageView;
@property (nonatomic, strong) UILabel *guideTitleLabel;
@property (nonatomic, strong) UILabel *guideContentLabel;

@end

@implementation KLGuideImageTextCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = 0;
        [self setup];
    }
    return self;
}
- (void)setup{

    _contentImageView = [UIImageView new];
    
    _guideTitleLabel = [UILabel new];
    _guideTitleLabel.font = kNSPXFONT(32);
    _guideTitleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    
    _guideContentLabel = [UILabel new];
    _guideContentLabel.numberOfLines = 0;
    _guideContentLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    _guideTitleLabel.font = kNSPXFONT(28);
    
    [self.contentView sd_addSubviews:@[_contentImageView,_guideContentLabel,_guideTitleLabel]];
    
    _guideTitleLabel.sd_layout
    .leftSpaceToView(self.contentView,10)
    .rightSpaceToView(self.contentView,10)
    .topSpaceToView(self.contentView,10)
    .heightIs(20);
    
    _guideContentLabel.sd_layout
    .leftSpaceToView(self.contentView,40)
    .rightSpaceToView(self.contentView,15)
    .topSpaceToView(_guideTitleLabel,10)
    .autoHeightRatio(0);
    _guideContentLabel.isAttributedContent = YES;

    _contentImageView.sd_layout
    .leftSpaceToView(self.contentView,50)
    .widthIs(220*MULTIPLE)
    .topSpaceToView(_guideContentLabel,20)
    .heightIs((781/2)*MULTIPLE);
    
    [self setupAutoHeightWithBottomView:_contentImageView bottomMargin:25];
    
}
- (void)setModel:(id)model{

    _model = model;
    KLGuideModel *guideModel = _model;
    
    _guideTitleLabel.text = guideModel.title;
    [KLGuideModel setAttributedStringWithLabel:_guideTitleLabel];
    
    _guideContentLabel.text = guideModel.content;
    
    _contentImageView.image = guideModel.contentImage;
}


@end
