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

@end

@implementation LWTheFormView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self addSubview:self.titleLabel];
        
        [self addSubview:self.typesView];
        
        self.titleLabel.sd_layout.leftSpaceToView(self,10).rightSpaceToView(self,0).topSpaceToView(self,15).heightIs(20);
        self.typesView.sd_layout.leftSpaceToView(self,0).topSpaceToView(self.titleLabel,5).rightSpaceToView(self,0).bottomSpaceToView(self,5);
        
        
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

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = stringJudgeNull(_title);
}

- (void)setTypes:(NSMutableArray *)array andShowType:(showTheFormType)type
{
    self.typesView.showType = type;
    self.typesView.types = array;
    
}

@end
