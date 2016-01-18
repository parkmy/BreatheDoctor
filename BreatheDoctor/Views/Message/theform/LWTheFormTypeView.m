//
//  LWTheFormTypeView.m
//  BreatheDoctor
//
//  Created by comv on 15/12/30.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWTheFormTypeView.h"

@implementation LWTheFormTypeViewItm


- (id)initWithFrame:(CGRect)frame withType:(showTheFormType)type
{
    if (self = [super initWithFrame:frame])
    {
        self.clipsToBounds = NO;
        
        self.backgroundColor = [UIColor whiteColor];
        _itmLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.layer.borderWidth = .5;
        self.layer.borderColor = type == showTheFormTypeBiaoDan?[LWThemeManager shareInstance].navBackgroundColor.CGColor:RGBA(0, 0, 0, .3).CGColor;
        _itmLabel.userInteractionEnabled = YES;
        _itmLabel.font = [UIFont systemFontOfSize:14];
        _itmLabel.textAlignment = 1;
        _itmLabel.textColor = type == showTheFormTypeBiaoDan?[LWThemeManager shareInstance].navBackgroundColor:RGBA(0, 0, 0, .6);
        [self addSubview:_itmLabel];
        _itmLabel.sd_layout.topSpaceToView(self,0).leftSpaceToView(self,0).rightSpaceToView(self,0).bottomSpaceToView(self,0);
        
//        _seleButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_seleButton setImage:kImage(@"duoxuan") forState:UIControlStateNormal];
//        _seleButton.backgroundColor = [UIColor clearColor];
//        [self addSubview:_seleButton];
//        _seleButton.sd_layout.topSpaceToView(self,-10).rightSpaceToView(self,-10).widthIs(20).heightIs(20);
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapItmClick)];
        [self addGestureRecognizer:tap];
        
    }
    return self;
}

- (void)tapItmClick
{
    
}

@end


@implementation LWTheFormTypeView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {   
        

        
        
    }
    return self;
}


- (void)setTypes:(NSMutableArray *)types
{
    _types = types;
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    CGFloat margin = 15.f;
    CGFloat btnHigh = 35.0f;
    
//    int afterCount = 0;
    
    CGFloat w = (Screen_SIZE.width-margin*4)/3;
    CGFloat ww = w*2+margin;
    
    
    @autoreleasepool {
        
        for (int i = 0; i < _types.count; i++)
        {
            
            int b = i/3;
            int a = i%3;
            
            LWTheFromRowArray *model = _types[i];
            NSString *title = model.content;
            LWTheFormTypeViewItm *btn = [[LWTheFormTypeViewItm alloc] initWithFrame:CGRectZero withType:self.showType];
            btn.itmLabel.text = title;
            [btn setCornerRadius:5.0f];
            CGFloat width = [title sizeWithFont:[UIFont systemFontOfSize:14] constrainedToHeight:CGFLOAT_MAX].width + 20;
            
            btn.width = width > w?ww:w;
            btn.xOrigin = a*(w + margin) + margin;
            btn.yOrigin = b*(btnHigh + margin) + margin;
            btn.height = btnHigh;
            
            [self addSubview:btn];
            
            if (self.showType == showTheFormTypeBiaoDan) {
                UIButton *itm = [UIButton buttonWithType:UIButtonTypeCustom];
                [itm setImage:kImage(@"duoxuan") forState:UIControlStateNormal];
                itm.backgroundColor = [UIColor clearColor];
                [self addSubview:itm];
                itm.frame = CGRectZero;
                
                itm.width = 20;
                itm.height = 20;
                itm.xOrigin = btn.maxX-10;
                itm.yOrigin = btn.yOrigin-10;
            }

        }
    }
    
    
}

@end
