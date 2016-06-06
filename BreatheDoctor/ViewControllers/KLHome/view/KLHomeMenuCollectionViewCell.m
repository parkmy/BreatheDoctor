//
//  KLHomeMenuCollectionViewCell.m
//  COButton
//
//  Created by liaowh on 16/6/2.
//  Copyright © 2016年 comv. All rights reserved.
//

#import "KLHomeMenuCollectionViewCell.h"
#import "FL_Button.h"
#import "KLHomeItmModel.h"

@interface KLHomeMenuCollectionViewCell ()

@property (nonatomic, strong) FL_Button *btn;

@end

@implementation KLHomeMenuCollectionViewCell

- (id)initWithFrame:(CGRect)frame{

    if ([super initWithFrame:frame]) {
        
        _btn = [[FL_Button alloc] initWithAlignmentStatus:FLAlignmentStatusTop];
        _btn.enabled = false;
        [_btn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        _btn.titleLabel.numberOfLines = 0;
        _btn.titleLabel.textAlignment = 1;
        _btn.titleLabel.font = kNSPXFONT(28);
        [self addSubview:_btn];
        _btn.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));

        _badgeLabel = [UILabel new];
        _badgeLabel.textAlignment = 1;
        _badgeLabel.textColor = [UIColor whiteColor];
        _badgeLabel.font = kNSPXFONT(22);
        _badgeLabel.backgroundColor = RGBA(244, 53, 48, 1);
        _badgeLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_badgeLabel];
        
        _badgeLabel.sd_layout
        .centerYIs(50)
        .rightSpaceToView(self,25*MULTIPLEVIEW)
        .widthIs(18*MULTIPLEVIEW)
        .heightIs(18*MULTIPLEVIEW);
        [_badgeLabel setCornerRadius:(18*MULTIPLEVIEW)/2];
    }
    return self;
}
- (void)setPatientCountWith:(NSInteger)count{

    NSString *string = [NSString stringWithFormat:@"患者咨询\n\n患者总数%@",kNSNumInteger(count)];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:string];
    [attr addAttributes:@{NSFontAttributeName:kNSPXFONT(24),NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#aaaaaa"]} range:NSMakeRange(4, string.length-4)];
    [_btn setAttributedTitle:attr forState:UIControlStateNormal];
    
}

- (void)setModel:(id)model{

    _model = model;
    KLHomeItmModel *homeModel = _model;
    
    [_btn setImage:homeModel.itmImage forState:UIControlStateNormal];
    
    if ([homeModel.itmTitle isEqualToString:@"患者咨询"]) {
        
        NSString *string = [NSString stringWithFormat:@"患者咨询\n\n患者总数%@",kNSNumInteger(homeModel.patientCount)];
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:string];
        [attr addAttributes:@{NSFontAttributeName:kNSPXFONT(24),NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#aaaaaa"]} range:NSMakeRange(4, string.length-4)];
        [_btn setAttributedTitle:attr forState:UIControlStateNormal];
        _badgeLabel.hidden = YES;
    }else{
    
        [_btn setTitle:homeModel.itmTitle forState:UIControlStateNormal];
        _badgeLabel.hidden = YES;
    }
    
}




@end
