//
//  KLGuideTextCell.m
//  BreatheDoctor
//
//  Created by liaowh on 16/6/6.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLGuideTextCell.h"
#import "KLGuideModel.h"

@interface KLGuideTextCell ()
@property (nonatomic, strong) UILabel *contextTextLabel;
@end

@implementation KLGuideTextCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = 0;
        [self setup];
    }
    return self;
}
- (void)setup{
    
    _contextTextLabel = [UILabel new];
    _contextTextLabel.numberOfLines = 0;
    _contextTextLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    _contextTextLabel.font = kNSPXFONT(28);
    
    [self.contentView addSubview:_contextTextLabel];
    
    _contextTextLabel.sd_layout
    .leftSpaceToView(self.contentView,25)
    .topSpaceToView(self.contentView,10)
    .rightSpaceToView(self.contentView,10)
    .autoHeightRatio(0);
    _contextTextLabel.isAttributedContent = YES;
    
    [self setupAutoHeightWithBottomView:_contextTextLabel bottomMargin:22];
    
}
- (void)setModel:(id)model{
    
    _model = model;
    KLGuideModel *guideModel = _model;
    
    _contextTextLabel.text = guideModel.content;
    [KLGuideModel setAttributedStringWithLabel:_contextTextLabel];

    
}
@end
