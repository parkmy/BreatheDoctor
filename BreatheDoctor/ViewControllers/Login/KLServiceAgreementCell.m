//
//  KLServiceAgreementCell.m
//  BreatheDoctor
//
//  Created by comv on 16/5/18.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLServiceAgreementCell.h"
#import "KLServiceAgreementModel.h"

@implementation KLServiceAgreementCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
       
        self.selectionStyle = 0;
        
        UIView *bg = [UIView new];
        [bg setCornerRadius:2.0f];
        bg.layer.borderColor = [UIColor colorWithHexString:@"#dddddd"].CGColor;
        bg.layer.borderWidth = .5;
        
        UIView *line = [UIView allocAppLineView];
        
        _agTitleLabel = [UILabel new];
        _agTitleLabel.textAlignment = 1;
        _agTitleLabel.textColor = [LWThemeManager shareInstance].navBackgroundColor;
        _agTitleLabel.font = kNSPXFONT(32);
        
        _agContentLabel = [UILabel new];
        _agContentLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _agContentLabel.font = kNSPXFONT(22);
        _agContentLabel.numberOfLines = 0;
        
        [bg addSubview:_agTitleLabel];
        [bg addSubview:line];
        [bg addSubview:_agContentLabel];
        
        _agTitleLabel.sd_layout
        .leftSpaceToView(bg,0)
        .rightSpaceToView(bg,0)
        .topSpaceToView(bg,0)
        .heightIs(30);
        
        line.sd_layout
        .leftSpaceToView(bg,0)
        .rightSpaceToView(bg,0)
        .topSpaceToView(_agTitleLabel,0)
        .heightIs(.5);
        
        _agContentLabel.sd_layout
        .leftSpaceToView(bg,15)
        .rightSpaceToView(bg,15)
        .topSpaceToView(line,10)
        .bottomSpaceToView(bg,10);
        
        [self.contentView addSubview:bg];
        
        bg.sd_layout
        .leftSpaceToView(self.contentView,10)
        .rightSpaceToView(self.contentView,10)
        .topSpaceToView(self.contentView,20)
        .bottomSpaceToView(self.contentView,15);
        
    }
    return self;
}

- (void)setModel:(KLServiceAgreementModel *)model{

    _model = model;
    
    self.agTitleLabel.text = model.title;
    self.agContentLabel.text = model.content;
}

@end
