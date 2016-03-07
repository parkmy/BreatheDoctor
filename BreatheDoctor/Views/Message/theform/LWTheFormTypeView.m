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
        if (type == showTheFormTypeBiaoDan || type == showTheFormTypeMouKuaiSucc) {
            self.layer.borderColor = [LWThemeManager shareInstance].navBackgroundColor.CGColor;
            self.backgroundColor = [LWThemeManager shareInstance].navBackgroundColor;
        }else
        {
            self.layer.borderColor = [UIColor colorWithHexString:@"#cccccc"].CGColor;
        }
        _itmLabel.userInteractionEnabled = YES;
        _itmLabel.font = [UIFont systemFontOfSize:kNSPXFONTFLOAT(30)];
        _itmLabel.textAlignment = 1;
        if (type == showTheFormTypeBiaoDan || type == showTheFormTypeMouKuaiSucc) {
            _itmLabel.textColor = [UIColor whiteColor];
        }else
        {
            _itmLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        }
        [self addSubview:_itmLabel];
        _itmLabel.sd_layout.topSpaceToView(self,0).leftSpaceToView(self,0).rightSpaceToView(self,0).bottomSpaceToView(self,0);
        
        
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
    
    CGFloat margin = 10;
    CGFloat btnHigh = 30.f*MULTIPLE;
    
//    int afterCount = 0;
    
    CGFloat w = (Screen_SIZE.width-margin*4-5)/3;
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
            [btn setCornerRadius:2.0f];
            CGFloat width = [title sizeWithFont:[UIFont systemFontOfSize:kNSPXFONTFLOAT(30)] constrainedToHeight:CGFLOAT_MAX].width + 10;
            
            btn.width = width > w?ww:w;
            btn.xOrigin = a*(w + margin) + margin;
            btn.yOrigin = b*(btnHigh + (margin*2)) + margin*2;
            btn.height = btnHigh;
            
            [self addSubview:btn];
            
           if (self.showType == showTheFormTypeBiaoDan || self.showType == showTheFormTypeMouKuaiSucc) {
                UIButton *itm = [UIButton buttonWithType:UIButtonTypeCustom];

               UIImage *image = kImage(@"duoxuan");
               
                [itm setImage:kImage(@"duoxuan") forState:UIControlStateNormal];
                itm.backgroundColor = [UIColor clearColor];
                [self addSubview:itm];
                itm.frame = CGRectZero;
                
                itm.width = image.size.width;
                itm.height = image.size.height;
                itm.xOrigin = btn.maxX-itm.width/2;
                itm.yOrigin = btn.yOrigin-itm.height/2;
               [itm setCornerRadius:itm.width/2];
               itm.layer.borderWidth = .5;
               itm.layer.borderColor = [UIColor whiteColor].CGColor;
            }

        }
    }
    
    
}

@end
