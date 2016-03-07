//
//  LWTheFormView.m
//  BreatheDoctor
//
//  Created by comv on 15/12/30.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWTheFormView.h"
#import "LWTheFormTypeView.h"

@interface LWTheFormView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) LWTheFormTypeView  *typesView;
@property (nonatomic, strong) UILabel *starLabel;
@end

@implementation LWTheFormView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self addSubview:self.titleLabel];
        
        [self addSubview:self.typesView];
        
        [self addSubview:self.starLabel];
        
        self.titleLabel.sd_layout.leftSpaceToView(self,10).widthIs(100).topSpaceToView(self,20).heightIs(15);
        self.typesView.sd_layout.leftSpaceToView(self,5).topSpaceToView(self.titleLabel,0).rightSpaceToView(self,0).bottomSpaceToView(self,10);
        self.starLabel.sd_layout.leftSpaceToView(self.titleLabel,10).topSpaceToView(self,20).widthIs(35).heightIs(15);
        
    }
    return self;
}
- (LWTheFormTypeView *)typesView
{
    if (!_typesView) {
        _typesView = [[LWTheFormTypeView alloc] initWithFrame:CGRectZero];
        _typesView.backgroundColor = [UIColor whiteColor];
    }
    return _typesView;
}
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    }
    return _titleLabel;
}
- (UILabel *)starLabel
{
    if (!_starLabel) {
        _starLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _starLabel.font = [UIFont systemFontOfSize:kNSPXFONTFLOAT(22)];
        _starLabel.textAlignment = 1;

    }
    return _starLabel;
}
- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = stringJudgeNull(_title);
    CGFloat w = [self.titleLabel.text sizeWithFont:self.titleLabel.font constrainedToHeight:20].width;
    self.titleLabel.sd_layout.widthIs(w);
}

- (void)setIsMulti:(BOOL)isMulti
{
    _isMulti = isMulti;
    
    self.starLabel.text = _isMulti?@"多选":@"单选";
    [self.starLabel setCornerRadius:2.0f];
    self.starLabel.layer.borderWidth = .5;
    self.starLabel.layer.borderColor = _isMulti?[UIColor colorWithHexString:@"#ff3333"].CGColor:[UIColor colorWithHexString:@"#fcb53a"].CGColor;
    self.starLabel.textColor = [UIColor colorWithCGColor:self.starLabel.layer.borderColor];
    
}

- (void)setTypes:(NSMutableArray *)array andShowType:(showTheFormType)type
{
    self.typesView.showType = type;
    self.typesView.types = array;
    
}

@end
